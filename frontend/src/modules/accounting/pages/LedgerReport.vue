<script setup>
import { computed, nextTick, onMounted, reactive, ref } from 'vue'
import { useApiClient } from '@/composables/useApiClient'
import { useBranchStore } from '@/store/branch-store'
import { useSettingsStore } from '@/store/settings-store'
import { printADiv, numberToWords } from '@/utilities/methods'
import { formatBalanceAmount } from '@/modules/accounting/utils/balanceSheet'
import { ledgerLevels, ledgerOptions, resetLedgerChildren } from '@/modules/accounting/utils/ledgerReport'

const api = useApiClient()
const reportId = ref('ledger-report')
const branchStore = useBranchStore()
const settingsStore = useSettingsStore()
const today = new Date()
const companyName = 'World vision Enterprice'
const companyAddress = 'HOUSE # 26, ROAD # 8, BLOCK # E, BANASREE RAMPURA DHAKA-1219, BANGLADESH'
const filters = reactive({
  start_date: `${today.getFullYear() - 1}-${String(today.getMonth() + 1).padStart(2, '0')}-${String(Math.min(today.getDate(), new Date(today.getFullYear() - 1, today.getMonth() + 1, 0).getDate())).padStart(2, '0')}`,
  end_date: `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, '0')}-${String(today.getDate()).padStart(2, '0')}`,
  ...Object.fromEntries(ledgerLevels.map(level => [level.key, ''])),
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
const accounts = ref([])
const accountsLoading = ref(false)
const accountsError = ref('')
const company = computed(() => settingsStore.data || {})
const currency = computed(() => company.value.currency_symbol || '\u09f3')
const currentFilters = () => ({ ...filters })
const filtersChanged = computed(() => appliedFilters.value && JSON.stringify(currentFilters()) !== JSON.stringify(appliedFilters.value))
const canExport = computed(() => report.value && !isLoading.value && !filtersChanged.value)
const optionsFor = index => ledgerOptions(accounts.value, filters, index)
const balanceWords = computed(() => report.value ? `${numberToWords(Math.abs(report.value.totals.balance))}${report.value.totals.balance < 0 ? ' (Credit balance)' : ''}` : '')
function dateLabel(date) {
  if (!date) return '-'
  const [year, month, day] = date.split('-')
  return `${day}/${month}/${year}`
}
async function loadAccounts() {
  accountsLoading.value = true
  accountsError.value = ''
  try {
    const response = await api.get('accounting/ledger-report/accounts', { requiresAuth: true, loading: false, tosterMessage: false })
    if (!Array.isArray(response.data)) throw new Error('Could not load accounts.')
    accounts.value = response.data
  } catch {
    accountsError.value = 'Could not load account filters. Please retry.'
  } finally {
    accountsLoading.value = false
  }
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
  for (const level of ledgerLevels.filter(level => !level.optional)) {
    if (!filters[level.key]) errors.value[level.key] = [`Select ${level.label}.`]
  }
  if (Object.keys(errors.value).length) return
  const requested = currentFilters()
  isLoading.value = true
  report.value = null
  try {
    const response = await api.get('accounting/ledger-report', {
      requiresAuth: true, loading: false, tosterMessage: false,
      params: { start_date: requested.start_date, end_date: requested.end_date, branch_id: Number(requested.branchId) || 0, ...Object.fromEntries(ledgerLevels.filter(level => requested[level.key]).map(level => [level.key, Number(requested[level.key])])) },
    })
    if (response.status !== true || !Array.isArray(response.data?.rows) || !response.data?.totals) {
      throw new Error('The ledger response is incomplete. Please try again.')
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
    [companyName], [companyAddress], ['Ledger Report'],
    ['Period', report.value.start_date, report.value.end_date], ['Branch Office', reportBranch.value], ['Currency', currency.value],
    ...ledgerLevels.map(level => [level.label, report.value.accounts[level.key] ? `${report.value.accounts[level.key].code} - ${report.value.accounts[level.key].name}` : 'All accounts']), [],
    ['Date', 'Account', 'Particulars', 'Voucher', 'Debit', 'Credit', 'Balance'],
    ['', '', 'Opening Balance', '', '', '', balanceAmount(report.value.opening_balance)],
    ...report.value.rows.map(row => [row.date, `${row.account_code} - ${row.account_name}`, row.particulars, row.voucher_no, row.debit, row.credit, balanceAmount(row.balance)]),
    ['', '', 'Total Amount', '', report.value.totals.debit, report.value.totals.credit, balanceAmount(report.value.totals.balance)],
    ['In word', balanceWords.value], ['Generated', generatedLabel.value],
  ]
  downloadCsv(csvRows, `ledger-${report.value.start_date}-${report.value.end_date}-branch-${report.value.branch_id || 'all'}.csv`)
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
  loadAccounts()
  settingsStore.fetchSettings()
})
</script>

<template>
  <div class="container-fluid pb-4">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-3">
      <h2 class="h4 mb-0">Ledger Report</h2>
      <RouterLink class="btn btn-outline-secondary" to="/accounting/trial-balance">Trial Balance</RouterLink>
    </div>
    <form class="card p-3 mb-3" @submit.prevent="loadReport">
      <fieldset :disabled="isLoading">
        <legend class="visually-hidden">Ledger report filters</legend>
        <div class="row g-3">
          <div class="col-md-6 col-xl-3">
            <label for="ledger-start" class="form-label">Starting Date <span class="text-danger">*</span></label>
            <input id="ledger-start" v-model="filters.start_date" type="date" required class="form-control" :class="{ 'is-invalid': errors.start_date }" :max="filters.end_date">
            <div class="invalid-feedback">{{ errors.start_date?.[0] }}</div>
          </div>
          <div class="col-md-6 col-xl-3">
            <label for="ledger-end" class="form-label">Closing Date <span class="text-danger">*</span></label>
            <input id="ledger-end" v-model="filters.end_date" type="date" required class="form-control" :class="{ 'is-invalid': errors.end_date }" :min="filters.start_date">
            <div class="invalid-feedback">{{ errors.end_date?.[0] }}</div>
          </div>
          <div v-for="(level, index) in ledgerLevels" :key="level.key" class="col-md-6 col-xl-3">
            <label :for="`ledger-${level.key}`" class="form-label">{{ level.label }} <span v-if="!level.optional" class="text-danger">*</span></label>
            <select :id="`ledger-${level.key}`" v-model="filters[level.key]" class="form-select" :class="{ 'is-invalid': errors[level.key] }" :required="!level.optional"
              :disabled="accountsLoading || (index > 0 && !filters[ledgerLevels[index - 1].key])" @change="resetLedgerChildren(filters, index)">
              <option value="">{{ level.optional ? (level.key === 'ledger_group_id' ? 'All General Ledgers in selected Control Group' : 'All Ledger Accounts') : `Select ${level.label}` }}</option>
              <option v-for="account in optionsFor(index)" :key="account.id" :value="account.id">{{ account.code }} - {{ account.name }}</option>
            </select>
            <div class="invalid-feedback">{{ errors[level.key]?.[0] }}</div>
          </div>
          <div class="col-md-6 col-xl-3">
            <label for="ledger-branch" class="form-label">Branch</label>
            <select id="ledger-branch" v-model.number="filters.branchId" class="form-select" :disabled="branchesLoading" :class="{ 'is-invalid': errors.branch_id }">
              <option :value="0">All branches</option><option v-for="branch in branchOptions" :key="branch.id" :value="Number(branch.id)">{{ branch.name }}</option>
            </select>
            <div class="invalid-feedback">{{ errors.branch_id?.[0] }}</div>
          </div>
          <div class="col-md-4"><button type="submit" class="btn btn-success w-100"><i class="fas fa-search me-1" aria-hidden="true"></i>{{ isLoading ? 'Loading...' : 'Search' }}</button></div>
          <div class="col-md-4"><button type="button" class="btn btn-primary w-100" :disabled="!canExport" @click="printReport"><i class="fas fa-print me-1" aria-hidden="true"></i>Print / PDF</button></div>
          <div class="col-md-4"><button type="button" class="btn btn-outline-secondary w-100" :disabled="!canExport" @click="exportCsv">Export CSV</button></div>
        </div>
      </fieldset>
      <div v-if="accountsError" class="text-danger mt-2">{{ accountsError }} <button type="button" class="btn btn-link p-0" @click="loadAccounts">Retry</button></div>
      <div v-if="branchError" class="text-danger mt-2">{{ branchError }} <button type="button" class="btn btn-link p-0" @click="loadBranches">Retry</button></div>
    </form>
    <div v-if="errorMessage" class="alert alert-danger" role="alert">{{ errorMessage }}</div>
    <div v-if="report && filtersChanged" class="alert alert-info">Filters changed. Search again to update the report.</div>
    <div v-if="isLoading" class="text-center p-5" role="status">Loading ledger...</div>
    <article v-else-if="report" id="ledger-report" class="ledger-report">
      <header class="ledger-heading">
        <h2>{{ companyName }}</h2><p class="address">{{ companyAddress }}</p>
        <h1>Ledger Report</h1>
        <p>From the date of {{ dateLabel(report.start_date) }} to {{ dateLabel(report.end_date) }}</p>
        <p>Branch Office: {{ reportBranch }}</p><p>Print Date: {{ printDateLabel }} (BDT)</p>
      </header>
      <div class="ledger-selection">
        <p><strong>Control Group:</strong> {{ report.accounts.control_group_id.code }} - {{ report.accounts.control_group_id.name }}</p>
        <p v-if="report.accounts.ledger_group_id"><strong>General Ledger:</strong> {{ report.accounts.ledger_group_id.code }} - {{ report.accounts.ledger_group_id.name }}</p>
        <p><strong>Ledger Account:</strong> {{ report.accounts.ledger_account_id ? `${report.accounts.ledger_account_id.code} - ${report.accounts.ledger_account_id.name}` : 'All accounts' }}</p>
      </div>
      <div class="ledger-table-wrap">
        <table class="ledger-table">
          <caption class="visually-hidden">Ledger Report, amounts in {{ currency }}. Dr indicates a debit balance; Cr indicates a credit balance.</caption>
          <colgroup><col style="width: 9%"><col style="width: 12%"><col style="width: 34%"><col style="width: 8%"><col style="width: 10%"><col style="width: 10%"><col style="width: 17%"></colgroup>
          <thead><tr><th scope="col">Date</th><th colspan="2" scope="colgroup">Particulars</th><th scope="col">Voucher</th><th scope="col">Debit</th><th scope="col">Credit</th><th scope="col">Balance</th></tr></thead>
          <tbody>
            <tr><td class="text-center">-</td><td colspan="2">Opening Balance</td><td class="text-center">-</td><td class="amount">-</td><td class="amount">-</td><td class="amount"><div class="ledger-balance"><span>{{ balanceSide(report.opening_balance) }}</span><span>{{ balanceNumber(report.opening_balance) }}</span></div></td></tr>
            <tr v-for="row in report.rows" :key="row.id">
              <td>{{ dateLabel(row.date) }}</td><td>{{ row.account_code }} - {{ row.account_name }}</td><td class="narration">{{ row.particulars }}</td><td>{{ row.voucher_no || '-' }}</td>
              <td class="amount">{{ amount(row.debit) }}</td><td class="amount">{{ amount(row.credit) }}</td><td class="amount"><div class="ledger-balance"><span>{{ balanceSide(row.balance) }}</span><span>{{ balanceNumber(row.balance) }}</span></div></td>
            </tr>
            <tr v-if="!report.rows.length"><td colspan="7" class="text-center">No transactions in the selected period. Opening balance is carried forward.</td></tr>
          </tbody>
          <tfoot>
            <tr class="total"><th colspan="4" scope="row">Sub Total</th><td class="amount">{{ amount(report.totals.debit) }}</td><td class="amount">{{ amount(report.totals.credit) }}</td><td class="amount"><div class="ledger-balance"><span>{{ balanceSide(report.totals.balance) }}</span><span>{{ balanceNumber(report.totals.balance) }}</span></div></td></tr>
            <tr class="total"><th colspan="4" scope="row">Total Amount</th><td class="amount">{{ amount(report.totals.debit) }}</td><td class="amount">{{ amount(report.totals.credit) }}</td><td class="amount"><div class="ledger-balance"><span>{{ balanceSide(report.totals.balance) }}</span><span>{{ balanceNumber(report.totals.balance) }}</span></div></td></tr>
            <tr><td colspan="7" class="in-words">In word: {{ balanceWords }}</td></tr>
          </tfoot>
        </table>
      </div>
      <div class="ledger-signatures"><span>Prepared by</span><span>Checked by</span><span>Authorized by</span></div>
    </article>
    <div v-else-if="!isLoading && !errorMessage" class="text-muted text-center p-4">Select the account hierarchy and dates, then Search.</div>
  </div>
</template>

<style scoped>
.ledger-report { background: #fff; color: #111; padding: 2rem; font-family: Arial, sans-serif; }
.ledger-heading { text-align: center; margin-bottom: 1.5rem; break-inside: avoid; }
.ledger-heading h2 { font-size: 1.1rem; margin-bottom: 0.5rem; }
.ledger-heading h1 { font-size: 0.95rem; text-transform: uppercase; text-decoration: underline; font-weight: 700; margin: 1rem 0 0.5rem; }
.ledger-heading p { font-size: 0.75rem; margin: 0.2rem 0; }
.ledger-heading .address { font-size: 0.7rem; }
.ledger-selection { font-size: 0.75rem; margin-bottom: 0.5rem; }
.ledger-selection p { margin: 0.2rem 0; }
.ledger-selection strong { display: inline-block; width: 9rem; text-transform: uppercase; }
.ledger-table-wrap { overflow-x: auto; }
.ledger-table { width: 100%; min-width: 850px; border-collapse: collapse; table-layout: fixed; font-size: 0.75rem; line-height: 1.35; }
.ledger-table th, .ledger-table td { border: 1px solid #222; padding: 0.3rem 0.2rem; overflow-wrap: anywhere; }
.ledger-table thead th { text-align: center; text-transform: uppercase; font-size: 0.65rem; }
.ledger-table .amount { text-align: right; font-variant-numeric: tabular-nums; white-space: nowrap; }
.ledger-balance { display: flex; justify-content: space-between; align-items: baseline; gap: 0.5rem; padding-inline: 0.2rem; }
.ledger-balance > span { flex: 0 0 auto; }
.ledger-balance > span:last-child { margin-left: auto; text-align: right; }
.narration { white-space: pre-wrap; }
.total { font-weight: 700; }
.total th { text-align: right; text-transform: uppercase; }
.in-words { text-transform: uppercase; font-weight: 700; }
.ledger-signatures { display: flex; justify-content: space-between; gap: 2rem; margin-top: 4rem; text-align: center; text-transform: uppercase; font-size: 0.75rem; font-weight: 700; break-inside: avoid; }
.ledger-signatures span { width: 30%; border-top: 1px solid #555; padding-top: 0.3rem; }
@media screen and (max-width: 991px) { .ledger-report { padding: 1rem; } .ledger-table { min-width: 850px; } }
@media print {
  .ledger-report { padding: 0.1in 0; margin: 0; width: 100%; }
  .ledger-heading { margin-bottom: 0.2in; }
  .ledger-heading h2 { font-size: 12pt; }
  .ledger-heading h1 { font-size: 10pt; }
  .ledger-heading p, .ledger-selection { font-size: 8pt; }
  .ledger-table-wrap { overflow: visible; }
  .ledger-table { min-width: 0; font-size: 7pt; }
  .ledger-table thead th { font-size: 7pt; }
  .ledger-table thead { display: table-header-group; }
  .ledger-table tfoot { display: table-row-group; }
  .ledger-table tr { break-inside: avoid; }
  .ledger-signatures { margin-top: 0.6in; font-size: 8pt; }
}
</style>
