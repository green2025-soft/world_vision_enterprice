<script setup>
import { computed, nextTick, onMounted, reactive, ref } from 'vue'
import { useApiClient } from '@/composables/useApiClient'
import { useBranchStore } from '@/store/branch-store'
import { useSettingsStore } from '@/store/settings-store'
import { printADiv } from '@/utilities/methods'
import { formatBalanceAmount } from '@/modules/accounting/utils/balanceSheet'
import { trialBalanceRows, trialBalanceFields } from '@/modules/accounting/utils/trialBalance'

const api = useApiClient()
const statementTitle = ref('Trial Balance')
const reportId = ref('trial-balance-report')
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
const rows = computed(() => trialBalanceRows(report.value?.coa || [], { maxDepth: detailLevel.value, hideZeroBalances: hideZeroBalances.value }))
const difference = computed(() => Math.round(((report.value?.totals.closing_debit ?? 0) - (report.value?.totals.closing_credit ?? 0)) * 100) / 100)
const filtersChanged = computed(() => appliedFilters.value && (
  filters.month !== appliedFilters.value.month || Number(filters.branchId) !== appliedFilters.value.branchId
))
const canExport = computed(() => report.value && report.value.coa.length > 0 && !isLoading.value && !filtersChanged.value)
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

  const requested = { month: filters.month, branchId: Number(filters.branchId) || 0 }
  isLoading.value = true
  report.value = null
  try {
    const response = await api.get('accounting/trial-balance', {
      requiresAuth: true, loading: false, tosterMessage: false,
      params: { month: requested.month, branch_id: requested.branchId, depth: 4 },
    })
    if (response.status !== true || !Array.isArray(response.data?.coa) || !response.data?.totals) {
      throw new Error('The trial balance response is incomplete. Please try again.')
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
  const csvRows = [
    [companyName], [companyAddress], ['Trial Balance', `As on ${reportDate.value}`],
    ['Branch Office', reportBranch.value], ['Period', report.value.start_date, report.value.month],
    ['Currency', currency.value], ['Detail', detailLevels.find(item => item.value === detailLevel.value)?.label],
    ['Zero balances', hideZeroBalances.value ? 'Hidden' : 'Shown'], [],
    ['Head of accounts', 'Opening debit', 'Opening credit', 'Period debit', 'Period credit', 'Closing debit', 'Closing credit'],
  ]
  rows.value.forEach(row => csvRows.push([
    `${row.kind === 'root-total' ? 'Total ' : ''}${row.code} - ${row.name}`,
    ...trialBalanceFields.map(field => row.kind === 'heading' ? '' : row[field]),
  ]))
  csvRows.push(['Grand total', ...trialBalanceFields.map(field => report.value.totals[field])],
    ['Basis', 'Opening: all entries before the selected month. Period: selected month. Pending and approved entries included; rejected entries excluded.'],
    ['Generated', generatedLabel.value])
  downloadCsv(csvRows, `trial-balance-${appliedFilters.value.month}-branch-${report.value.branch_id || 'all'}.csv`)
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
  <div class="container-fluid trial-balance-page">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-3">
      <div>
        <h2 class="h4 mb-1"><i class="fas fa-balance-scale me-2" aria-hidden="true"></i>{{ statementTitle }}</h2>
        <p class="text-muted mb-0">{{ 'Opening balance, monthly movements and closing balance for every account.' }}</p>
      </div>
      <div class="d-flex gap-2">
        <RouterLink class="btn btn-outline-secondary" to="/accounting/cash-bank-book">Cash &amp; Bank Book</RouterLink>
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
                <label for="trial-balance-month" class="form-label">Report month <span class="text-danger">*</span></label>
                <input id="trial-balance-month" v-model="filters.month" type="month" required
                  class="form-control" :class="{ 'is-invalid': errors.month }"
                  :aria-invalid="Boolean(errors.month)" aria-describedby="trial-balance-month-error">
                <div id="trial-balance-month-error" class="invalid-feedback">{{ errors.month?.[0] }}</div>
              </div>
              <div class="col-sm-6 col-lg-3">
                <label for="trial-balance-detail" class="form-label">Detail level</label>
                <select id="trial-balance-detail" v-model.number="detailLevel" class="form-select">
                  <option v-for="level in detailLevels" :key="level.value" :value="level.value">{{ level.label }}</option>
                </select>
              </div>
              <div class="col-sm-6 col-lg-3">
                <label for="trial-balance-branch" class="form-label">Branch</label>
                <select id="trial-balance-branch" v-model.number="filters.branchId" class="form-select"
                  :class="{ 'is-invalid': errors.branch_id }" :disabled="branchesLoading"
                  :aria-invalid="Boolean(errors.branch_id)" aria-describedby="trial-balance-branch-error">
                  <option :value="0">All branches</option>
                  <option v-for="branch in branchOptions" :key="branch.id" :value="Number(branch.id)">{{ branch.name }}</option>
                </select>
                <div id="trial-balance-branch-error" class="invalid-feedback">{{ errors.branch_id?.[0] }}</div>
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
          <span class="text-muted">Opening: before the selected month. Period: selected month. Closing: month end.</span>
          <div class="form-check mb-0">
            <input id="trial-balance-hide-zero" v-model="hideZeroBalances" type="checkbox" class="form-check-input">
            <label for="trial-balance-hide-zero" class="form-check-label">Hide zero balances</label>
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
    <div v-else-if="report && !report.coa.length" class="card p-5 text-center" role="status">
      <h3 class="h5">No statement accounts found</h3>
      <p class="text-muted mb-0">There are no accounts available for this report.</p>
    </div>

    <article v-else-if="report" :id="reportId" class="trial-report" aria-label="Trial Balance">
      <header class="trial-heading">
        <h2>{{ companyName }}</h2>
        <p class="address">{{ companyAddress }}</p>
        <h1>Trial Balance</h1>
        <p>As on <strong>{{ reportDate }}</strong></p>
        <p>Branch Office: <strong>{{ reportBranch }}</strong></p>
        <p>Print Date: {{ printDateLabel }} </p>
      </header>
      <div class="trial-table-wrap">
        <table class="trial-table">
          <caption class="visually-hidden">Trial Balance, amounts in {{ currency }}</caption>
          <colgroup><col class="account-column"><col v-for="field in trialBalanceFields" :key="field" class="amount-column"></colgroup>
          <thead>
            <tr><th rowspan="2" scope="col">Head of Accounts</th><th colspan="2" scope="colgroup">Opening Balance</th><th colspan="2" scope="colgroup">For the Period</th><th colspan="2" scope="colgroup">Balance Ended</th></tr>
            <tr><template v-for="group in 3" :key="group"><th scope="col">Debit</th><th scope="col">Credit</th></template></tr>
          </thead>
          <tbody>
            <tr v-for="row in rows" :key="`${row.id}-${row.kind}`" :class="row.kind">
              <th v-if="row.kind === 'heading'" colspan="7" scope="rowgroup" :style="{ paddingLeft: `${Math.max(0, row.level - 1) * 0.5}rem` }">{{ row.code }} - {{ row.name }}</th>
              <template v-else>
                <th scope="row" :style="{ paddingLeft: `${Math.max(0, row.level - 1) * 0.5}rem` }"><template v-if="row.kind === 'root-total'">Total </template>{{ row.code }} - {{ row.name }}</th>
                <td v-for="field in trialBalanceFields" :key="field"><span>{{ amount(row[field]) }}</span></td>
              </template>
            </tr>
            <tr v-if="!rows.length"><td colspan="7" class="empty">No non-zero balances to display.</td></tr>
          </tbody>
          <tfoot><tr class="grand-total"><th scope="row">Grand Total</th><td v-for="field in trialBalanceFields" :key="field"><span>{{ amount(report.totals[field]) }}</span></td></tr></tfoot>
        </table>
      </div>
      <div class="trial-signatures"><span>Prepared by</span><span>Checked by</span><span>Authorized by</span></div>
    </article>
    <div v-if="report && difference !== 0" class="alert alert-warning mt-3" role="status">Closing debit less credit: <strong>{{ amount(difference) }}</strong>. Review the journal entries for this difference.</div>
  </div>
</template>

<style scoped>
.trial-balance-page { padding-bottom: 2rem; }
.report-options { font-size: 0.875rem; }
.trial-report { margin: 0 auto; padding: 2.5rem 2rem; background: #fff; color: #111; font-family: Arial, sans-serif; }
.trial-heading { text-align: center; margin-bottom: 2rem; break-inside: avoid; }
.trial-heading h2 { font-size: 1.2rem; font-weight: 700; margin-bottom: 0.5rem; }
.trial-heading h1 { font-size: 1rem; text-transform: uppercase; margin: 1rem 0 0.5rem; }
.trial-heading p { font-size: 0.8rem; margin: 0.2rem 0; }
.trial-heading .address { font-size: 0.75rem; }
.trial-table-wrap { overflow-x: auto; }
.trial-table { width: 100%; border-collapse: separate; border-spacing: 0; table-layout: fixed; font-size: 0.75rem; line-height: 1.4; }
.account-column { width: 25%; }
.amount-column { width: 12.5%; }
.trial-table thead th { text-align: center; text-transform: uppercase; font-size: 0.7rem; padding: 0.2rem; }
.trial-table thead tr:first-child th { border-top: 1px solid #111; }
.trial-table thead tr:last-child th { border-top: 1px solid #111; border-bottom: 1px solid #111; }
.trial-table thead th[rowspan] { border-left: 1px solid #111; border-bottom: 1px solid #111; }
.trial-table thead tr th:last-child { border-right: 1px solid #111; }
.trial-table tbody th, .trial-table tfoot th { text-align: left; font-weight: 400; overflow-wrap: anywhere; padding: 0.2rem 0.3rem 0.2rem 0; }
.trial-table td { text-align: right; padding: 0.15rem 0 0.15rem 0.4rem; font-variant-numeric: tabular-nums; white-space: nowrap; }
.trial-table td span { display: block; }
.trial-table .heading th { font-weight: 700; text-transform: uppercase; padding-top: 0.4rem; }
.trial-table .subtotal th, .trial-table .root-total th, .trial-table .grand-total th { text-align: right; font-weight: 700; text-transform: uppercase; }
.trial-table .subtotal td span { font-weight: 700; border-bottom: 1px solid #111; }
.trial-table .root-total td span, .trial-table .grand-total td span { font-weight: 700; border-top: 1px solid #111; border-bottom: 3px double #111; }
.trial-table .empty { text-align: center; padding: 1rem; }
.trial-signatures { display: flex; justify-content: space-between; gap: 2rem; margin-top: 5rem; font-size: 0.75rem; text-align: center; text-transform: uppercase; font-weight: 700; break-inside: avoid; }
.trial-signatures span { width: 30%; padding-top: 0.3rem; border-top: 1px solid #555; }
@media (min-width: 992px) { .report-submit { padding-top: 2rem; } }
@media screen and (max-width: 991px) { .trial-table { min-width: 850px; } .trial-report { padding: 1rem; } }
@media print {
  .trial-report { width: 100%; padding: 0.1in 0; margin: 0; }
  .trial-heading { margin-bottom: 0.3in; }
  .trial-heading h2 { font-size: 12pt; }
  .trial-heading h1 { font-size: 10pt; }
  .trial-heading p { font-size: 8pt; }
  .trial-heading .address { font-size: 7pt; }
  .trial-table-wrap { overflow: visible; }
  .trial-table { min-width: 0; font-size: 7pt; }
  .trial-table thead th { font-size: 7pt; }
  .trial-table thead { display: table-header-group; }
  .trial-table tfoot { display: table-row-group; }
  .trial-table tr { break-inside: avoid; }
  .trial-table .heading { break-after: avoid; }
  .trial-table .subtotal, .trial-table .root-total { break-before: avoid; }
  .trial-signatures { margin-top: 0.7in; font-size: 8pt; }
}
</style>

