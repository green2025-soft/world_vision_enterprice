<script setup>
import { computed, nextTick, onMounted, reactive, ref } from 'vue'
import { useApiClient } from '@/composables/useApiClient'
import { useBranchStore } from '@/store/branch-store'
import { useSettingsStore } from '@/store/settings-store'
import { printADiv } from '@/utilities/methods'
import { formatBalanceAmount } from '@/modules/accounting/utils/balanceSheet'

const api = useApiClient()
const reportId = ref('cash-bank-book')
const branchStore = useBranchStore()
const settingsStore = useSettingsStore()
const today = new Date()
const companyName = 'World vision Enterprice'
const companyAddress = 'HOUSE # 26, ROAD # 8, BLOCK # E, BANASREE RAMPURA DHAKA-1219, BANGLADESH'
const filters = reactive({
  start_date: `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, '0')}-${String(today.getDate()).padStart(2, '0')}`,
  end_date: `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, '0')}-${String(today.getDate()).padStart(2, '0')}`,
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
const company = computed(() => settingsStore.data || {})
const currency = computed(() => company.value.currency_symbol || '\u09f3')
const currentFilters = () => ({ ...filters })
const filtersChanged = computed(() => appliedFilters.value && JSON.stringify(currentFilters()) !== JSON.stringify(appliedFilters.value))
const canExport = computed(() => report.value && !isLoading.value && !filtersChanged.value)
function dateLabel(date) {
  if (!date) return '-'
  const [year, month, day] = date.split('-')
  return `${day}/${month}/${year}`
}
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
const generatedLabel = computed(() => generatedAt.value
  ? new Intl.DateTimeFormat('en-GB', { dateStyle: 'medium', timeStyle: 'short' }).format(generatedAt.value)
  : '')
const printDateLabel = computed(() => printedAt.value
  ? new Intl.DateTimeFormat('en-GB', {
    timeZone: 'Asia/Dhaka', day: '2-digit', month: '2-digit', year: 'numeric',
    hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: true,
  }).format(printedAt.value).toUpperCase()
  : '')
const balanceSide = value => Number(value) === 0 ? '' : Number(value) < 0 ? 'cr' : 'dr'
const balanceNumber = value => Number(value) === 0 ? '-' : formatBalanceAmount(Math.abs(Number(value)))
const balanceAmount = value => Number(value) === 0 ? '-' : `${balanceSide(value)} ${balanceNumber(value)}`
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
  if (!filters.start_date || !filters.end_date || filters.end_date < filters.start_date) {
    errors.value = { end_date: ['Select a valid starting and closing date.'] }
    return
  }
  const requested = currentFilters()
  isLoading.value = true
  report.value = null
  try {
    const response = await api.get('accounting/cash-bank-book', {
      requiresAuth: true, loading: false, tosterMessage: false,
      params: { start_date: requested.start_date, end_date: requested.end_date, branch_id: Number(requested.branchId) || 0 },
    })
    if (response.status !== true || !Array.isArray(response.data?.rows) || !response.data?.totals) {
      throw new Error('The cash and bank book response is incomplete. Please try again.')
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
    [companyName], [companyAddress], ['Cash & Bank Book'],
    ['Period', report.value.start_date, report.value.end_date], ['Branch Office', reportBranch.value], ['Currency', currency.value], [],
    ['Date', 'Account', 'Particulars', 'Voucher', 'Debit', 'Credit', 'Cash', 'Bank'],
    ['', '', 'Opening Balance', '', '', '', balanceAmount(report.value.opening.cash), balanceAmount(report.value.opening.bank)],
    ...report.value.rows.map(row => [row.date, `${row.account_code} - ${row.account_name}`, row.particulars, row.voucher_no, row.debit, row.credit, balanceAmount(row.cash), balanceAmount(row.bank)]),
    ['', '', 'Sub Total', '', report.value.totals.debit, report.value.totals.credit, balanceAmount(report.value.closing.cash), balanceAmount(report.value.closing.bank)],
    ['', '', 'Closing Balance', '', '', '', balanceAmount(report.value.closing.cash), balanceAmount(report.value.closing.bank)],
    ['Generated', generatedLabel.value],
  ]
  downloadCsv(csvRows, `cash-bank-book-${report.value.start_date}-${report.value.end_date}-branch-${report.value.branch_id || 'all'}.csv`)
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
  <div class="container-fluid pb-4">
    <div class="d-flex flex-wrap justify-content-between gap-2 mb-3"><h2 class="h4">Cash &amp; Bank Book</h2><RouterLink to="/accounting/ledger-report" class="btn btn-outline-secondary">Ledger Report</RouterLink></div>
    <form class="card p-3 mb-3" @submit.prevent="loadReport">
      <RouterLink class="mb-3" to="/accounting/cash-flow-statement">Cash Flow Statement</RouterLink>
      <fieldset :disabled="isLoading">
        <legend class="visually-hidden">Cash and bank filters</legend>
        <div class="row g-3 align-items-end">
          <div class="col-md-6 col-xl-3"><label for="cash-start" class="form-label">Starting Date</label><input id="cash-start" v-model="filters.start_date" type="date" required :max="filters.end_date" class="form-control" :class="{ 'is-invalid': errors.start_date }"><div class="invalid-feedback">{{ errors.start_date?.[0] }}</div></div>
          <div class="col-md-6 col-xl-3"><label for="cash-end" class="form-label">Closing Date</label><input id="cash-end" v-model="filters.end_date" type="date" required :min="filters.start_date" class="form-control" :class="{ 'is-invalid': errors.end_date }"><div class="invalid-feedback">{{ errors.end_date?.[0] }}</div></div>
          <div class="col-md-6 col-xl-3"><button class="btn btn-success w-100" type="submit"><i class="fas fa-search me-1" aria-hidden="true"></i>{{ isLoading ? 'Loading...' : 'Search' }}</button></div>
          <div class="col-md-6 col-xl-3"><button class="btn btn-primary w-100" type="button" :disabled="!canExport" @click="printReport"><i class="fas fa-print me-1" aria-hidden="true"></i>Print / PDF</button></div>
          <div class="col-md-6 col-xl-3"><label for="cash-branch" class="form-label">Branch</label><select id="cash-branch" v-model.number="filters.branchId" class="form-select" :disabled="branchesLoading" :class="{ 'is-invalid': errors.branch_id }"><option :value="0">All branches</option><option v-for="branch in branchOptions" :key="branch.id" :value="Number(branch.id)">{{ branch.name }}</option></select><div class="invalid-feedback">{{ errors.branch_id?.[0] }}</div></div>
          <div class="col-md-6 col-xl-3"><button type="button" class="btn btn-outline-secondary w-100" :disabled="!canExport" @click="exportCsv">Export CSV</button></div>
        </div>
      </fieldset>
      <div v-if="branchError" class="text-danger mt-2">{{ branchError }} <button type="button" class="btn btn-link p-0" @click="loadBranches">Retry</button></div>
    </form>
    <div v-if="errorMessage" class="alert alert-danger" role="alert">{{ errorMessage }}</div>
    <div v-if="report && filtersChanged" class="alert alert-info">Filters changed. Search again to update the report.</div>
    <div v-if="isLoading" class="text-center p-4" role="status">Loading cash and bank book...</div>
    <article v-else-if="report" id="cash-bank-book" class="cash-book">
      <header class="book-heading"><h2>{{ companyName }}</h2><p>{{ companyAddress }}</p><h1>Cash &amp; Bank Book</h1><p>{{ dateLabel(report.start_date) }} to {{ dateLabel(report.end_date) }}</p><p>Branch Office: {{ reportBranch }}</p><p>Print Date: {{ printDateLabel }} (BDT)</p></header>
      <div class="book-table-wrap">
        <table class="book-table">
          <caption class="visually-hidden">Cash and bank book, amounts in {{ currency }}</caption>
          <colgroup><col style="width: 30%"><col style="width: 12%"><col style="width: 12%"><col style="width: 12%"><col style="width: 17%"><col style="width: 17%"></colgroup>
          <thead><tr><th scope="col">Particulars</th><th scope="col">Voucher</th><th scope="col">Debit</th><th scope="col">Credit</th><th scope="col">Cash</th><th scope="col">Bank</th></tr></thead>
          <tbody>
            <tr class="balance-row"><th colspan="4" scope="row">Opening Balance</th><td v-for="kind in ['cash', 'bank']" :key="kind"><div class="book-balance"><span>{{ balanceSide(report.opening[kind]) }}</span><span>{{ balanceNumber(report.opening[kind]) }}</span></div></td></tr>
            <tr v-for="row in report.rows" :key="row.id"><td><div class="account-label">{{ dateLabel(row.date) }} · {{ row.account_code }} - {{ row.account_name }}</div><div class="narration">{{ row.particulars }}</div></td><td>{{ row.voucher_no || '-' }}</td><td class="amount">{{ amount(row.debit) }}</td><td class="amount">{{ amount(row.credit) }}</td><td v-for="kind in ['cash', 'bank']" :key="kind"><div class="book-balance"><span>{{ balanceSide(row[kind]) }}</span><span>{{ balanceNumber(row[kind]) }}</span></div></td></tr>
            <tr v-if="!report.rows.length"><td colspan="6" class="text-center">No transactions in the selected period.</td></tr>
          </tbody>
          <tfoot>
            <tr v-if="report.rows.length" class="balance-row"><th colspan="2" scope="row">Sub Total</th><td class="amount">{{ amount(report.totals.debit) }}</td><td class="amount">{{ amount(report.totals.credit) }}</td><td v-for="kind in ['cash', 'bank']" :key="kind"><div class="book-balance"><span>{{ balanceSide(report.closing[kind]) }}</span><span>{{ balanceNumber(report.closing[kind]) }}</span></div></td></tr>
            <tr class="balance-row closing"><th colspan="4" scope="row">Closing Balance</th><td v-for="kind in ['cash', 'bank']" :key="kind"><div class="book-balance"><span>{{ balanceSide(report.closing[kind]) }}</span><span>{{ balanceNumber(report.closing[kind]) }}</span></div></td></tr>
          </tfoot>
        </table>
      </div>
      <div class="book-signatures"><span>Prepared by</span><span>Checked by</span><span>Authorized by</span></div>
    </article>
  </div>
</template>

<style scoped>
.cash-book { background: #fff; color: #111; padding: 2rem; font-family: Arial, sans-serif; }
.book-heading { text-align: center; margin-bottom: 1.5rem; break-inside: avoid; }
.book-heading h2 { font-size: 1.1rem; font-weight: 700; }
.book-heading h1 { font-size: 1rem; text-transform: uppercase; font-weight: 700; margin: 1rem 0 0.5rem; }
.book-heading p { font-size: 0.75rem; margin: 0.2rem 0; }
.book-table-wrap { overflow-x: auto; }
.book-table { width: 100%; min-width: 900px; border-collapse: collapse; table-layout: fixed; font-size: 0.8rem; }
.book-table th, .book-table td { border: 1px solid #999; padding: 0.4rem; overflow-wrap: anywhere; }
.book-table thead th { text-align: center; text-transform: uppercase; }
.book-table .amount { text-align: right; white-space: nowrap; font-variant-numeric: tabular-nums; }
.book-balance { display: flex; justify-content: space-between; align-items: baseline; gap: 0.5rem; font-variant-numeric: tabular-nums; white-space: nowrap; }
.book-balance span { flex: 0 0 auto; }
.book-balance span:last-child { margin-left: auto; text-align: right; }
.balance-row { font-weight: 700; }
.balance-row th { text-align: left; }
.closing { background: #f4f5f8; }
.account-label { font-size: 0.7rem; margin-bottom: 0.2rem; }
.narration { white-space: pre-wrap; }
.book-signatures { display: flex; justify-content: space-between; gap: 2rem; text-align: center; text-transform: uppercase; font-size: 0.75rem; margin-top: 4rem; break-inside: avoid; }
.book-signatures span { width: 30%; border-top: 1px solid #555; padding-top: 0.3rem; }
@media screen and (max-width: 991px) { .cash-book { padding: 1rem; } }
@media print {
  .cash-book { padding: 0.1in 0; width: 100%; }
  .book-table-wrap { overflow: visible; }
  .book-table { min-width: 0; font-size: 7pt; }
  .book-table th, .book-table td { padding: 0.2rem; }
  .account-label { font-size: 7pt; }
  .book-table thead { display: table-header-group; }
  .book-table tfoot { display: table-row-group; }
  .book-table tr { break-inside: avoid; }
  .book-signatures { margin-top: 0.6in; }
}
</style>
