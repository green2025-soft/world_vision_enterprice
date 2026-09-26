<script setup>
import { computed, nextTick, onMounted, reactive, ref } from 'vue'
import { useApiClient } from '@/composables/useApiClient'
import { useBranchStore } from '@/store/branch-store'
import { useSettingsStore } from '@/store/settings-store'
import { printADiv } from '@/utilities/methods'
import { formatBalanceAmount } from '@/modules/accounting/utils/balanceSheet'

const api = useApiClient()
const statementTitle = ref('Changes in Equity')
const reportId = ref('changes-in-equity-report')
const branchStore = useBranchStore()
const settingsStore = useSettingsStore()
const today = new Date()
const companyName = 'World vision Enterprice'
const companyAddress = 'HOUSE # 26, ROAD # 8, BLOCK # E, BANASREE RAMPURA DHAKA-1219, BANGLADESH'
const filters = reactive({
  month: `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, '0')}`,
  branchId: Number(branchStore.selectedBranchId) || 0,
})
const branches = ref([])
const branchesLoading = ref(false)
const branchError = ref('')
const report = ref(null)
const appliedFilters = ref(null)
const generatedAt = ref(null)
const printedAt = ref(null)
const isLoading = ref(false)
const errorMessage = ref('')
const errors = ref({})
const detailLevel = ref(2)
const hideZeroBalances = ref(false)
const detailLevels = [
  { value: 1, label: 'Categories' },
  { value: 2, label: 'Control groups' },
  { value: 3, label: 'Ledger groups' },
  { value: 4, label: 'Ledger accounts' },
]
const company = computed(() => settingsStore.data || {})
const currency = computed(() => company.value.currency_symbol || '৳')
const rows = computed(() => (report.value?.rows || []).filter(row => !hideZeroBalances.value || Object.values(row.amounts).some(value => Number(value) !== 0)))
const filtersChanged = computed(() => appliedFilters.value && (
  filters.month !== appliedFilters.value.month || Number(filters.branchId) !== appliedFilters.value.branchId || detailLevel.value !== appliedFilters.value.depth
))
const canExport = computed(() => report.value && !isLoading.value && !filtersChanged.value)
const branchOptions = computed(() => {
  const options = [...branches.value]
  const selectedId = Number(branchStore.selectedBranchId)
  if (selectedId && !options.some(branch => Number(branch.id) === selectedId)) {
    options.push({ id: selectedId, name: branchStore.branch || `Branch ${selectedId}` })
  }
  return options
})
const reportBranch = computed(() => {
  const id = Number(report.value?.branch_id || 0)
  if (!id) return 'All branches'
  return branchOptions.value.find(branch => Number(branch.id) === id)?.name || `Branch ${id}`
})
const reportDate = computed(() => {
  if (!report.value?.month) return ''
  const [year, month, day] = report.value.month.split('-').map(Number)
  return new Intl.DateTimeFormat('en-GB', { day: 'numeric', month: 'long', year: 'numeric' })
    .format(new Date(year, month - 1, day))
})
const generatedLabel = computed(() => generatedAt.value
  ? new Intl.DateTimeFormat('en-GB', { dateStyle: 'medium', timeStyle: 'short' }).format(generatedAt.value)
  : '')
const printDateLabel = computed(() => printedAt.value
  ? new Intl.DateTimeFormat('en-GB', {
    timeZone: 'Asia/Dhaka', day: '2-digit', month: '2-digit', year: 'numeric',
    hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: true,
  }).format(printedAt.value).toUpperCase()
  : '')
const amount = value => value === 0 ? '-' : formatBalanceAmount(value)

async function loadBranches() {
  branchesLoading.value = true
  branchError.value = ''
  try {
    const response = await api.get('core/branches/lists', {
      requiresAuth: true, loading: false, tosterMessage: false,
    })
    if (!Array.isArray(response.data)) throw new Error('The branch list could not be loaded.')
    branches.value = response.data
  } catch {
    branchError.value = 'Could not load the branch list.'
  } finally {
    branchesLoading.value = false
  }
}

async function loadReport() {
  if (isLoading.value) return
  errors.value = {}
  errorMessage.value = ''
  if (!/^\d{4}-(0[1-9]|1[0-2])$/.test(filters.month)) {
    errors.value = { month: ['Select a valid report month.'] }
    return
  }

  const requested = { month: filters.month, branchId: Number(filters.branchId) || 0, depth: detailLevel.value }
  isLoading.value = true
  report.value = null
  try {
    const response = await api.get('accounting/changes-in-equity', {
      requiresAuth: true, loading: false, tosterMessage: false,
      params: { month: requested.month, branch_id: requested.branchId, depth: requested.depth },
    })
    if (response.status !== true || !Array.isArray(response.data?.rows) || !response.data?.periods || !response.data?.opening || !response.data?.closing) {
      throw new Error('The changes in equity response is incomplete. Please try again.')
    }
    report.value = response.data
    appliedFilters.value = requested
    generatedAt.value = new Date()
    printedAt.value = new Date()
  } catch (error) {
    errors.value = error.response?.data?.errors || {}
    errorMessage.value = error.response?.data?.message || error.message || 'Could not load the statement. Please try again.'
  } finally {
    isLoading.value = false
  }
}

async function printReport() {
  if (!canExport.value) return
  printedAt.value = new Date()
  await nextTick()
  // The shared print helper retains a clone with the same report ID after printing.
  document.getElementById('print-el')?.replaceChildren()
  printADiv(reportId.value, 'portrait')
}

function exportCsv() {
  if (!canExport.value) return
  const periods = report.value.periods
  const csvRows = [
    [companyName], [companyAddress], ['Changes in Equity', `For the month ended ${reportDate.value}`],
    ['Branch Office', reportBranch.value], ['Currency', currency.value],
    ['Detail', detailLevels.find(level => level.value === detailLevel.value)?.label],
    ...periods.map(period => [period.label, period.start_date, period.end_date]), [],
    ['Particulars', ...periods.map(period => period.label)],
    ['Opening Balance', ...periods.map(period => report.value.opening[period.key])],
    ...rows.value.map(row => [row.code ? `${row.code} - ${row.name}` : row.name, ...periods.map(period => row.amounts[period.key])]),
    ['Total Balance', ...periods.map(period => report.value.closing[period.key])],
    ['Generated', generatedLabel.value],
  ]
  downloadCsv(csvRows, `changes-in-equity-${appliedFilters.value.month}-branch-${report.value.branch_id || 'all'}.csv`)
}

function downloadCsv(rows, filename) {
  const csv = rows.map(row => row.map(value => {
    // Keep account names from being treated as spreadsheet formulas.
    let text = String(value ?? '')
    if (typeof value === 'string' && /^[\s\uFEFF]*[=+\-@\t\r\n]/.test(text)) text = `'${text}`
    return `"${text.replaceAll('"', '""')}"`
  }).join(',')).join('\r\n')
  const url = URL.createObjectURL(new Blob(['\uFEFF', csv], { type: 'text/csv;charset=utf-8;' }))
  const link = document.createElement('a')
  link.href = url
  link.download = filename
  document.body.appendChild(link)
  link.click()
  link.remove()
  setTimeout(() => URL.revokeObjectURL(url), 1000)
}

onMounted(() => {
  loadBranches()
  loadReport()
  settingsStore.fetchSettings()
})
</script>

<template>
  <div class="container-fluid changes-in-equity-page">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-3">
      <div>
        <h2 class="h4 mb-1"><i class="fas fa-balance-scale me-2" aria-hidden="true"></i>{{ statementTitle }}</h2>
        <p class="text-muted mb-0">{{ 'Opening equity, changes during each period and closing equity.' }}</p>
      </div>
      <div class="d-flex gap-2">
        <RouterLink class="btn btn-outline-secondary" to="/accounting/ledger-report">Ledger Report</RouterLink>
        <RouterLink class="btn btn-outline-secondary" to="/accounting/receipts-payments">Receipts &amp; Payments</RouterLink>
        <RouterLink class="btn btn-outline-secondary" to="/accounting/balance-sheet">
          {{ 'Balance Sheet' }}
        </RouterLink>
        <button type="button" class="btn btn-outline-secondary" :disabled="!canExport" @click="exportCsv">
          <i class="fas fa-file-csv me-1" aria-hidden="true"></i> Export CSV
        </button>
        <button type="button" class="btn btn-outline-primary" :disabled="!canExport" @click="printReport()">
          <i class="fas fa-print me-1" aria-hidden="true"></i> Print / PDF
        </button>
      </div>
    </div>

    <div class="card card-outline card-info mb-3">
      <div class="card-body">
        <form @submit.prevent="loadReport">
          <fieldset :disabled="isLoading">
            <legend class="visually-hidden">Report filters</legend>
            <div class="row g-3 align-items-start">
              <div class="col-sm-6 col-lg-3">
                <label for="changes-in-equity-month" class="form-label">Report month <span class="text-danger">*</span></label>
                <input id="changes-in-equity-month" v-model="filters.month" type="month" required
                  class="form-control" :class="{ 'is-invalid': errors.month }"
                  :aria-invalid="Boolean(errors.month)" aria-describedby="changes-in-equity-month-error">
                <div id="changes-in-equity-month-error" class="invalid-feedback">{{ errors.month?.[0] }}</div>
              </div>
              <div class="col-sm-6 col-lg-3">
                <label for="changes-in-equity-detail" class="form-label">Detail level</label>
                <select id="changes-in-equity-detail" v-model.number="detailLevel" class="form-select">
                  <option v-for="level in detailLevels" :key="level.value" :value="level.value">{{ level.label }}</option>
                </select>
              </div>
              <div class="col-sm-6 col-lg-3">
                <label for="changes-in-equity-branch" class="form-label">Branch</label>
                <select id="changes-in-equity-branch" v-model.number="filters.branchId" class="form-select"
                  :class="{ 'is-invalid': errors.branch_id }" :disabled="branchesLoading"
                  :aria-invalid="Boolean(errors.branch_id)" aria-describedby="changes-in-equity-branch-error">
                  <option :value="0">All branches</option>
                  <option v-for="branch in branchOptions" :key="branch.id" :value="Number(branch.id)">{{ branch.name }}</option>
                </select>
                <div id="changes-in-equity-branch-error" class="invalid-feedback">{{ errors.branch_id?.[0] }}</div>
                <small v-if="branchesLoading" class="text-muted">Loading branches…</small>
                <div v-else-if="branchError" class="small text-danger mt-1">
                  {{ branchError }} <button type="button" class="btn btn-link btn-sm p-0" @click="loadBranches">Retry</button>
                </div>
              </div>
              <div class="col-lg-3 report-submit">
                <button type="submit" class="btn btn-primary w-100" :disabled="isLoading">
                  <span v-if="isLoading" class="spinner-border spinner-border-sm me-1" aria-hidden="true"></span>
                  <i v-else class="fas fa-search me-1" aria-hidden="true"></i>
                  {{ isLoading ? 'Generating…' : 'Generate report' }}
                </button>
              </div>
            </div>
          </fieldset>
        </form>
        <div class="report-options d-flex flex-wrap align-items-center gap-3 mt-3 pt-3 border-top">
          <span class="text-muted">Selected month, previous month, current financial year to date and previous full financial year. Opening balances precede each period.</span>
          <div class="form-check mb-0">
            <input id="changes-in-equity-hide-zero" v-model="hideZeroBalances" type="checkbox" class="form-check-input">
            <label for="changes-in-equity-hide-zero" class="form-check-label">Hide zero balances</label>
          </div>
        </div>
      </div>
    </div>

    <div v-if="errorMessage" class="alert alert-danger d-flex flex-wrap justify-content-between align-items-center gap-2" role="alert">
      <span>{{ errorMessage }}</span>
      <button type="button" class="btn btn-sm btn-outline-danger" @click="loadReport">Try again</button>
    </div>
    <div v-if="filtersChanged && report" class="alert alert-info" role="status">
      Filters changed. Generate the report to update the results below.
    </div>
    <div v-if="isLoading" class="card py-5 text-center" role="status" aria-live="polite">
      <div class="spinner-border text-primary mx-auto mb-3" aria-hidden="true"></div>
      <span>Loading statement…</span>
    </div>
    <article v-else-if="report" :id="reportId" class="equity-report">
      <header class="equity-heading">
        <h2>{{ companyName }}</h2><p class="address">{{ companyAddress }}</p>
        <h1>Changes in Equity</h1>
        <p>For the month ended <strong>{{ reportDate }}</strong></p>
        <p>Branch Office: {{ reportBranch }}</p><p>Print Date: {{ printDateLabel }} (BDT)</p>
      </header>
      <div class="equity-table-wrap">
        <table class="equity-table">
          <caption class="visually-hidden">Changes in Equity, amounts in {{ currency }}</caption>
          <colgroup><col style="width: 36%"><col v-for="period in report.periods" :key="period.key" style="width: 16%"></colgroup>
          <thead>
            <tr><th rowspan="2" scope="col">Particulars</th><th colspan="4" scope="colgroup">Amounts</th></tr>
            <tr><th v-for="period in report.periods" :key="period.key" scope="col" :title="`${period.start_date} to ${period.end_date}`">{{ period.label }}</th></tr>
          </thead>
          <tbody>
            <tr class="opening-row"><th scope="row">Opening Balance</th><td v-for="period in report.periods" :key="period.key"><span>{{ amount(report.opening[period.key]) }}</span></td></tr>
            <tr v-for="row in rows" :key="row.id"><th scope="row"><template v-if="row.code">{{ row.code }} - </template>{{ row.name }}</th><td v-for="period in report.periods" :key="period.key"><span>{{ amount(row.amounts[period.key]) }}</span></td></tr>
            <tr v-if="!rows.length"><td colspan="5" class="empty">No equity movements in these periods.</td></tr>
          </tbody>
          <tfoot><tr class="total-row"><th scope="row">Total Balance</th><td v-for="period in report.periods" :key="period.key"><span>{{ amount(report.closing[period.key]) }}</span></td></tr></tfoot>
        </table>
      </div>
      <div class="equity-signatures"><span>Prepared by</span><span>Checked by</span><span>Authorized by</span></div>
    </article>
  </div>
</template>

<style scoped>
.changes-in-equity-page { padding-bottom: 2rem; }
.report-options { font-size: 0.875rem; }
.equity-report { background: #fff; color: #111; padding: 2.5rem 2rem; font-family: Arial, sans-serif; }
.equity-heading { text-align: center; margin-bottom: 2rem; break-inside: avoid; }
.equity-heading h2 { font-size: 1.1rem; font-weight: 700; margin-bottom: 0.5rem; }
.equity-heading h1 { font-size: 1rem; text-transform: uppercase; text-decoration: underline; font-weight: 700; margin: 1rem 0 0.5rem; }
.equity-heading p { font-size: 0.8rem; margin: 0.2rem 0; }
.equity-heading .address { font-size: 0.75rem; }
.equity-table-wrap { overflow-x: auto; }
.equity-table { width: 100%; table-layout: fixed; border-collapse: collapse; font-size: 0.8rem; line-height: 1.4; }
.equity-table thead th { text-align: center; text-transform: uppercase; border: 1px solid #111; padding: 0.4rem; }
.equity-table tbody th, .equity-table tfoot th { text-align: left; padding: 0.35rem 0; font-weight: 400; overflow-wrap: anywhere; }
.equity-table td { text-align: right; padding: 0.35rem 0 0.35rem 0.5rem; font-variant-numeric: tabular-nums; white-space: nowrap; }
.equity-table td span { display: block; padding: 0.1rem 0.2rem; }
.equity-table .opening-row th, .equity-table .total-row th { font-weight: 700; text-transform: uppercase; }
.equity-table .opening-row span, .equity-table .total-row span { border-bottom: 3px double #111; font-weight: 700; }
.equity-table .total-row span { border-top: 1px solid #111; }
.equity-table .empty { text-align: center; padding: 1rem; }
.equity-signatures { display: flex; justify-content: space-between; gap: 2rem; margin-top: 5rem; text-align: center; text-transform: uppercase; font-size: 0.75rem; font-weight: 700; break-inside: avoid; }
.equity-signatures span { width: 30%; border-top: 1px solid #555; padding-top: 0.3rem; }
@media (min-width: 992px) { .report-submit { padding-top: 2rem; } }
@media screen and (max-width: 991px) { .equity-report { padding: 1rem; } .equity-table { min-width: 800px; } }
@media print {
  .equity-report { padding: 0.1in 0; margin: 0; width: 100%; }
  .equity-heading { margin-bottom: 0.3in; }
  .equity-heading h2 { font-size: 12pt; }
  .equity-heading h1 { font-size: 10pt; }
  .equity-heading p { font-size: 8pt; }
  .equity-table-wrap { overflow: visible; }
  .equity-table { min-width: 0; font-size: 8pt; }
  .equity-table thead { display: table-header-group; }
  .equity-table tfoot { display: table-row-group; }
  .equity-table tr { break-inside: avoid; }
  .equity-signatures { margin-top: 0.7in; font-size: 8pt; }
}
</style>
