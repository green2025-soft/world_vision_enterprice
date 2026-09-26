<script setup>
import { computed, nextTick, onMounted, reactive, ref } from 'vue'
import { useApiClient } from '@/composables/useApiClient'
import { useBranchStore } from '@/store/branch-store'
import { useSettingsStore } from '@/store/settings-store'
import { printADiv } from '@/utilities/methods'
import { formatBalanceAmount } from '@/modules/accounting/utils/balanceSheet'
import { receiptsPaymentsGroups } from '@/modules/accounting/utils/receiptsPayments'

const api = useApiClient()
const statementTitle = ref('Receipts & Payments')
const reportId = ref('receipts-payments-report')
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
const groups = computed(() => receiptsPaymentsGroups(report.value, hideZeroBalances.value))
const currentPeriod = computed(() => {
  if (!report.value?.month) return ''
  const [year, month] = report.value.month.split('-').map(Number)
  return new Intl.DateTimeFormat('en-US', { month: 'short', year: 'numeric' }).format(new Date(year, month - 1, 1)).replace(' ', '-').toUpperCase()
})
const reportRows = computed(() => {
  if (!report.value) return []
  const result = []
  const heading = name => result.push({ name, kind: 'heading' })
  const append = key => groups.value[key].forEach(row => result.push({ ...row, kind: 'account' }))
  const total = (key, name, kind = 'subtotal') => result.push({ name, kind, amount: report.value.current.totals[key], fiscalAmount: report.value.fiscal.totals[key] })
  heading('Receipts')
  heading('Opening Balance')
  append('opening')
  total('opening', 'Total Opening Balance')
  if (groups.value.receipts.length) { heading('Receipts during the period'); append('receipts') }
  total('total_receipts', 'Total Receipts', 'grand-total')
  heading('Payments')
  if (groups.value.payments.length) { heading('Payments during the period'); append('payments') }
  heading('Closing Balance')
  append('closing')
  total('closing', 'Total Closing Balance')
  total('total_payments', 'Total Payments', 'grand-total')
  return result
})
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
    const response = await api.get('accounting/receipts-payments', {
      requiresAuth: true, loading: false, tosterMessage: false,
      params: { month: requested.month, branch_id: requested.branchId, depth: requested.depth },
    })
    if (response.status !== true || !response.data?.current?.groups || !response.data?.fiscal?.totals) {
      throw new Error('The receipts and payments response is incomplete. Please try again.')
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
    [companyName], [companyAddress], ['Receipts & Payments', `As on ${reportDate.value}`],
    ['Branch Office', reportBranch.value], ['Month period', report.value.start_date, report.value.month],
    ['Financial year period', report.value.fy_start_date, report.value.month],
    ['Detail', detailLevels.find(item => item.value === detailLevel.value)?.label],
    ['Currency', currency.value], [], ['Particulars', currentPeriod.value, report.value.financial_year],
    ...reportRows.value.map(row => [row.code ? `${row.code} - ${row.name}` : row.name, row.amount ?? '', row.fiscalAmount ?? '']),
    ['Basis', 'All cash and bank transactions from pending and approved vouchers are included. Internal transfers and non-cash transactions are excluded; rejected entries are excluded.'],
    ['Account breakdown', 'COA counterparts are shown for cash transactions. Opposite-side entries appear as deductions to reconcile the net cash amount.'],
    ['Generated', generatedLabel.value],
  ]
  downloadCsv(csvRows, `receipts-payments-${appliedFilters.value.month}-branch-${report.value.branch_id || 'all'}.csv`)
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
  <div class="container-fluid receipts-payments-page">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-3">
      <div>
        <h2 class="h4 mb-1"><i class="fas fa-balance-scale me-2" aria-hidden="true"></i>{{ statementTitle }}</h2>
        <p class="text-muted mb-0">{{ 'Monthly receipts and payments with financial-year totals from 1 July.' }}</p>
      </div>
      <div class="d-flex gap-2">
        <RouterLink class="btn btn-outline-secondary" to="/accounting/cash-bank-book">Cash &amp; Bank Book</RouterLink>
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
                <label for="receipts-payments-month" class="form-label">Report month <span class="text-danger">*</span></label>
                <input id="receipts-payments-month" v-model="filters.month" type="month" required
                  class="form-control" :class="{ 'is-invalid': errors.month }"
                  :aria-invalid="Boolean(errors.month)" aria-describedby="receipts-payments-month-error">
                <div id="receipts-payments-month-error" class="invalid-feedback">{{ errors.month?.[0] }}</div>
              </div>
              <div class="col-sm-6 col-lg-3">
                <label for="receipts-payments-detail" class="form-label">Detail level</label>
                <select id="receipts-payments-detail" v-model.number="detailLevel" class="form-select">
                  <option v-for="level in detailLevels" :key="level.value" :value="level.value">{{ level.label }}</option>
                </select>
              </div>
              <div class="col-sm-6 col-lg-3">
                <label for="receipts-payments-branch" class="form-label">Branch</label>
                <select id="receipts-payments-branch" v-model.number="filters.branchId" class="form-select"
                  :class="{ 'is-invalid': errors.branch_id }" :disabled="branchesLoading"
                  :aria-invalid="Boolean(errors.branch_id)" aria-describedby="receipts-payments-branch-error">
                  <option :value="0">All branches</option>
                  <option v-for="branch in branchOptions" :key="branch.id" :value="Number(branch.id)">{{ branch.name }}</option>
                </select>
                <div id="receipts-payments-branch-error" class="invalid-feedback">{{ errors.branch_id?.[0] }}</div>
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
          <span class="text-muted">All cash/bank activity. Opening and closing include all pending and approved voucher types.</span>
          <div class="form-check mb-0">
            <input id="receipts-payments-hide-zero" v-model="hideZeroBalances" type="checkbox" class="form-check-input">
            <label for="receipts-payments-hide-zero" class="form-check-label">Hide zero balances</label>
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
    <article v-else-if="report" :id="reportId" class="receipts-report" aria-label="Receipts & Payments">
      <header class="receipts-heading">
        <h2>{{ companyName }}</h2>
        <p class="address">{{ companyAddress }}</p>
        <h1>Receipts & Payments</h1>
        <p>As on <strong>{{ reportDate }}</strong></p>
        <p>Branch Office: <strong>{{ reportBranch }}</strong></p>
        <p>Print Date: {{ printDateLabel }} </p>
      </header>
      <div class="receipts-table-wrap">
        <table class="receipts-table">
          <colgroup><col style="width: 64%"><col style="width: 18%"><col style="width: 18%"></colgroup>
          <thead><tr><th scope="col">Particulars</th><th scope="col">Current Month<br>{{ currentPeriod }}</th><th scope="col">For the Period<br>{{ report.financial_year }}</th></tr></thead>
          <tbody>
            <tr v-for="(row, index) in reportRows" :key="index" :class="row.kind">
              <th v-if="row.kind === 'heading'" colspan="3" scope="rowgroup">{{ row.name }}</th>
              <template v-else>
                <th scope="row"><template v-if="row.code">{{ row.code }} - </template>{{ row.name }}</th>
                <td><span>{{ amount(row.amount) }}</span></td><td><span>{{ amount(row.fiscalAmount) }}</span></td>
              </template>
            </tr>
          </tbody>
        </table>
      </div>
      <p class="small text-muted mt-3">Receipts and payments include all cash/bank transactions from pending and approved vouchers. Internal transfers and non-cash transactions are excluded.</p>
      <p class="small text-muted mt-3">COA counterparts are shown for cash transactions. Amounts in parentheses are deductions within that section, reconciling to the net cash received or paid.</p>
      <div class="receipts-signatures"><span>Prepared by</span><span>Checked by</span><span>Authorized by</span></div>
    </article>
  </div>
</template>

<style scoped>
.receipts-payments-page { padding-bottom: 2rem; }
.report-options { font-size: 0.875rem; }
.receipts-report { margin: 0 auto; padding: 2.5rem 2rem; background: #fff; color: #111; font-family: Arial, sans-serif; }
.receipts-heading { text-align: center; margin-bottom: 2rem; break-inside: avoid; }
.receipts-heading h2 { font-size: 1.2rem; font-weight: 700; margin-bottom: 0.5rem; }
.receipts-heading h1 { font-size: 1rem; text-transform: uppercase; margin: 1rem 0 0.5rem; }
.receipts-heading p { font-size: 0.8rem; margin: 0.2rem 0; }
.receipts-heading .address { font-size: 0.75rem; }
.receipts-table-wrap { overflow-x: auto; }
.receipts-table { width: 100%; border-collapse: separate; border-spacing: 0; table-layout: fixed; font-size: 0.82rem; line-height: 1.4; }

.receipts-table thead { outline: 1px solid #111; }
.receipts-table thead th { text-align: center; text-transform: uppercase; font-size: 0.7rem; padding: 0.2rem; }
.receipts-table thead tr:first-child th { border-top: 1px solid #111; }
.receipts-table thead tr:last-child th { border-top: 1px solid #111; border-bottom: 1px solid #111; }
.receipts-table thead th[rowspan] { border-left: 1px solid #111; border-bottom: 1px solid #111; }
.receipts-table thead tr th:last-child { border-right: 1px solid #111; }
.receipts-table tbody th, .receipts-table tfoot th { text-align: left; font-weight: 400; overflow-wrap: anywhere; padding: 0.2rem 0.3rem 0.2rem 0; }
.receipts-table td { text-align: right; padding: 0.15rem 0 0.15rem 0.4rem; font-variant-numeric: tabular-nums; white-space: nowrap; }
.receipts-table td span { display: block; }
.receipts-table .heading th { font-weight: 700; text-transform: uppercase; padding-top: 0.4rem; }
.receipts-table .subtotal th, .receipts-table .root-total th, .receipts-table .grand-total th { text-align: right; font-weight: 700; text-transform: uppercase; }
.receipts-table .subtotal td span { font-weight: 700; border-bottom: 1px solid #111; }
.receipts-table .root-total td span, .receipts-table .grand-total td span { font-weight: 700; border-top: 1px solid #111; border-bottom: 3px double #111; }
.receipts-table .empty { text-align: center; padding: 1rem; }
.receipts-signatures { display: flex; justify-content: space-between; gap: 2rem; margin-top: 5rem; font-size: 0.75rem; text-align: center; text-transform: uppercase; font-weight: 700; break-inside: avoid; }
.receipts-signatures span { width: 30%; padding-top: 0.3rem; border-top: 1px solid #555; }
@media (min-width: 992px) { .report-submit { padding-top: 2rem; } }
@media screen and (max-width: 991px) { .receipts-table { min-width: 650px; } .receipts-report { padding: 1rem; } }
@media print {
  .receipts-report { width: 100%; padding: 0.1in 0; margin: 0; }
  .receipts-heading { margin-bottom: 0.3in; }
  .receipts-heading h2 { font-size: 12pt; }
  .receipts-heading h1 { font-size: 10pt; }
  .receipts-heading p { font-size: 8pt; }
  .receipts-heading .address { font-size: 9pt; }
  .receipts-table-wrap { overflow: visible; }
  .receipts-table { min-width: 0; font-size: 9pt; }
  .receipts-table thead { outline: 1px solid #111; }
.receipts-table thead th { font-size: 9pt; }
  .receipts-table thead { display: table-header-group; }
  .receipts-table tfoot { display: table-row-group; }
  .receipts-table tr { break-inside: avoid; }
  .receipts-table .heading { break-after: avoid; }
  .receipts-table .subtotal, .receipts-table .root-total { break-before: avoid; }
  .receipts-signatures { margin-top: 0.7in; font-size: 8pt; }
}
</style>

