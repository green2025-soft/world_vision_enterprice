<script setup>
import { computed, nextTick, onMounted, reactive, ref, watch } from 'vue'
import { useApiClient } from '@/composables/useApiClient'
import { useBranchStore } from '@/store/branch-store'
import { useSettingsStore } from '@/store/settings-store'
import { printADiv } from '@/utilities/methods'
import { buildBalanceSheetNote, fiscalYearComparisonMonth, formatBalanceAmount } from '@/modules/accounting/utils/balanceSheet'
import { buildIncomeExpenditureSections } from '@/modules/accounting/utils/incomeExpenditure'

const api = useApiClient()
const statementTitle = ref('Income & Expenditure')
const reportId = ref('income-expenditure-report')
const noteReportId = ref('income-expenditure-note-report')
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
const comparisonReport = ref(null)
const balanceReport = ref(null)
const comparisonBalanceReport = ref(null)
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
const comparisonMonth = computed(() => fiscalYearComparisonMonth(filters.month))
const noteOpen = ref(false)
const selectedNote = ref(null)
const noteData = computed(() => selectedNote.value
  ? buildBalanceSheetNote(report.value?.coa, comparisonReport.value?.coa, selectedNote.value.id)
  : null)
const noteTitle = computed(() => noteData.value
  ? `Note ${selectedNote.value.note}: ${noteData.value.code} - ${noteData.value.name}`
  : 'Account details')

function openNote(row) {
  if (!canExport.value) return
  selectedNote.value = { id: row.id, note: row.note }
  noteOpen.value = true
}
watch([() => filters.month, () => filters.branchId, detailLevel, hideZeroBalances], () => {
  noteOpen.value = false
})

const company = computed(() => settingsStore.data || {})
const currency = computed(() => company.value.currency_symbol || '৳')
const sections = computed(() => buildIncomeExpenditureSections(report.value?.coa || [], comparisonReport.value?.coa || [], balanceReport.value?.coa || [], comparisonBalanceReport.value?.coa || [], {
  maxDepth: detailLevel.value,
  hideZeroBalances: hideZeroBalances.value,
}))
const income = computed(() => sections.value.find(section => Number(section.code) === 300000))
const expenditure = computed(() => sections.value.find(section => Number(section.code) === 400000))
const surplus = computed(() => Math.round(((income.value?.balance ?? 0) - (expenditure.value?.balance ?? 0)) * 100) / 100)
const fiscalSurplus = computed(() => Math.round(((income.value?.comparisonBalance ?? 0) - (expenditure.value?.comparisonBalance ?? 0)) * 100) / 100)
const currentColumnLabel = computed(() => periodLabel(report.value?.month))
const comparisonColumnLabel = computed(() => comparisonReport.value?.financial_year)
const periodDescription = computed(() => `Month: ${report.value?.start_date} to ${report.value?.month}. Financial year: ${comparisonReport.value?.start_date} to ${comparisonReport.value?.month}.`)
const reportBasis = computed(() => 'Pending and approved entries within each stated period; rejected entries and prior financial years excluded.')
const filtersChanged = computed(() => appliedFilters.value && (
  filters.month !== appliedFilters.value.month || Number(filters.branchId) !== appliedFilters.value.branchId
))
const canExport = computed(() => report.value && sections.value.length > 0 && !isLoading.value && !filtersChanged.value)
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
function periodLabel(date) {
  if (!date) return ''
  const [year, month] = date.split('-').map(Number)
  return new Intl.DateTimeFormat('en-US', { month: 'short', year: '2-digit' })
    .format(new Date(year, month - 1, 1)).replace(' ', '-').toUpperCase()
}
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

  const requested = { month: filters.month, comparisonMonth: comparisonMonth.value, branchId: Number(filters.branchId) || 0 }
  isLoading.value = true
  noteOpen.value = false
  selectedNote.value = null
  report.value = null
  comparisonReport.value = null
  balanceReport.value = null
  comparisonBalanceReport.value = null
  try {
    const fetchPeriod = (month, period) => api.get(`accounting/income-expenditure`, {
      requiresAuth: true,
      loading: false,
      tosterMessage: false,
      params: { month, branch_id: requested.branchId, depth: 4, ...(period ? { period } : {}) },
    })
    const fetchBalance = month => api.get('accounting/balance-sheet', {
      requiresAuth: true, loading: false, tosterMessage: false,
      params: { month, branch_id: requested.branchId, depth: 4 },
    })
    const [response, comparison, balance, comparisonBalance] = await Promise.all([
      fetchPeriod(requested.month, 'month'),
      fetchPeriod(requested.month, 'financial_year'),
      fetchBalance(requested.month), fetchBalance(requested.comparisonMonth),
    ])
    if ([response, comparison, balance, comparisonBalance].some(result => result.status !== true || !Array.isArray(result.data?.coa))) {
      throw new Error('The statement response is incomplete. Please try again.')
    }
    report.value = response.data
    comparisonReport.value = comparison.data
    balanceReport.value = balance.data
    comparisonBalanceReport.value = comparisonBalance.data
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

async function printReport(note = false) {
  if (!canExport.value || (note && !noteData.value)) return
  printedAt.value = new Date()
  await nextTick()
  // The shared print helper retains a clone with the same report ID after printing.
  document.getElementById('print-el')?.replaceChildren()
  printADiv(note ? noteReportId.value : reportId.value, 'portrait')
}

function exportCsv() {
  if (!canExport.value) return
  const rows = [
    [companyName],
    [companyAddress],
    [statementTitle.value, `${'For the month ended'} ${reportDate.value}`],
    ['Branch Office', reportBranch.value],
    ['Currency', currency.value],
    ['Detail', detailLevels.find(level => level.value === detailLevel.value)?.label],
    ['Periods', periodDescription.value],
    ['Zero balances', hideZeroBalances.value ? 'Hidden' : 'Shown'],
    [],
  ]
  for (const section of sections.value) {
    rows.push([section.name])
    rows.push(['Particulars', 'Notes', currentColumnLabel.value, comparisonColumnLabel.value])
    for (const row of section.rows) {
      rows.push([row.code ? `${row.code} - ${row.name}` : row.name, row.note, row.balance, row.comparisonBalance])
    }
    rows.push([`Total ${section.name}`, '', section.balance, section.comparisonBalance])
    rows.push([])
  }
  rows.push(
    ['Surplus / (Deficit) (A-B)', '', surplus.value, fiscalSurplus.value], [],
    ['Total financial year income', income.value?.comparisonBalance ?? 0],
    ['Total financial year expenditure', expenditure.value?.comparisonBalance ?? 0],
    ['Total financial year surplus / (deficit)', fiscalSurplus.value],
  )
  rows.push(['Basis', reportBasis.value])
  rows.push(['Generated', generatedLabel.value])

  downloadCsv(rows, `income-expenditure-${appliedFilters.value.month}-branch-${report.value.branch_id || 'all'}.csv`)
}

function exportNoteCsv() {
  if (!canExport.value || !noteData.value) return
  const note = noteData.value
  const columns = ['Particulars', currentColumnLabel.value, comparisonColumnLabel.value]
  const rows = [
    [companyName], [companyAddress], [`${statementTitle.value} — Notes`, `${'For the month ended'} ${reportDate.value}`],
    [noteTitle.value], ['Branch Office', reportBranch.value], ['Currency', currency.value],
    ['Account path', note.path.join(' / ')],
    ['Periods', periodDescription.value], [],
  ]
  rows.push(['Reported account totals'], columns,
    ['Debit', note.totalDebit, note.comparisonDebit],
    ['Credit', note.totalCredit, note.comparisonCredit],
    ['Balance', note.balance, note.comparisonBalance], [], ['Subaccount breakdown'], columns)
  note.rows.forEach(row => rows.push([`${'  '.repeat(Math.max(0, row.depth - 1))}${row.code ? `${row.code} - ` : ''}${row.name}`, row.balance, row.comparisonBalance]))
  rows.push([`Total ${note.name}`, note.balance, note.comparisonBalance],
    ['Basis', `${reportBasis.value} Group totals include their subaccounts.`],
    ['Generated', generatedLabel.value])
  downloadCsv(rows, `income-expenditure-note-${selectedNote.value.note}-${appliedFilters.value.month}-branch-${report.value.branch_id || 'all'}.csv`)
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
  <div class="container-fluid income-expenditure-page">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-3">
      <div>
        <h2 class="h4 mb-1"><i class="fas fa-balance-scale me-2" aria-hidden="true"></i>{{ statementTitle }}</h2>
        <p class="text-muted mb-0">{{ 'Monthly income and expenditure with financial-year totals from 1 July.' }}</p>
      </div>
      <div class="d-flex gap-2">
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
                <label for="income-expenditure-month" class="form-label">Report month <span class="text-danger">*</span></label>
                <input id="income-expenditure-month" v-model="filters.month" type="month" required
                  class="form-control" :class="{ 'is-invalid': errors.month }"
                  :aria-invalid="Boolean(errors.month)" aria-describedby="income-expenditure-month-error">
                <div id="income-expenditure-month-error" class="invalid-feedback">{{ errors.month?.[0] }}</div>
              </div>
              <div class="col-sm-6 col-lg-3">
                <label for="income-expenditure-detail" class="form-label">Detail level</label>
                <select id="income-expenditure-detail" v-model.number="detailLevel" class="form-select">
                  <option v-for="level in detailLevels" :key="level.value" :value="level.value">{{ level.label }}</option>
                </select>
              </div>
              <div class="col-sm-6 col-lg-3">
                <label for="income-expenditure-branch" class="form-label">Branch</label>
                <select id="income-expenditure-branch" v-model.number="filters.branchId" class="form-select"
                  :class="{ 'is-invalid': errors.branch_id }" :disabled="branchesLoading"
                  :aria-invalid="Boolean(errors.branch_id)" aria-describedby="income-expenditure-branch-error">
                  <option :value="0">All branches</option>
                  <option v-for="branch in branchOptions" :key="branch.id" :value="Number(branch.id)">{{ branch.name }}</option>
                </select>
                <div id="income-expenditure-branch-error" class="invalid-feedback">{{ errors.branch_id?.[0] }}</div>
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
          <span class="text-muted">Month totals and financial-year totals from 1 July to the selected month end.</span>
          <div class="form-check mb-0">
            <input id="income-expenditure-hide-zero" v-model="hideZeroBalances" type="checkbox" class="form-check-input">
            <label for="income-expenditure-hide-zero" class="form-check-label">Hide zero balances</label>
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
    <div v-else-if="report && !sections.length" class="card p-5 text-center" role="status">
      <h3 class="h5">No statement accounts found</h3>
      <p class="text-muted mb-0">There are no accounts available for this report.</p>
    </div>

    <article v-else-if="report" :id="reportId" class="income-expenditure-report"  :aria-label="statementTitle">
      <header class="income-expenditure-heading">
        <h2 class="company-name">{{ companyName }}</h2>
        <p class="company-address">{{ companyAddress }}</p>
        <h1>{{ statementTitle }}</h1>
        <p>{{ 'For the month ended' }} <strong>{{ reportDate }}</strong></p>
        <p>Branch Office: <strong>{{ reportBranch }}</strong></p>
        <p>Print Date: {{ printDateLabel }} </p>
      </header>

      <div class="income-expenditure-table-wrap">
        <table class="statement-table">
          <caption class="visually-hidden">{{ statementTitle }}, amounts in {{ currency }}</caption>
          <colgroup><col class="particulars-column"><col class="notes-column"><col class="amount-column"><col class="amount-column"></colgroup>
          <thead>
            <tr>
              <th rowspan="2" scope="col">Particulars</th>
              <th rowspan="2" scope="col">Notes</th>
              <th colspan="2" scope="colgroup">Amount ({{ currency }})</th>
            </tr>
            <tr>
              <th scope="col"><template>Current month<br></template>{{ currentColumnLabel }}</th>
              <th scope="col"><template>For the period<br></template>{{ comparisonColumnLabel }}</th>
            </tr>
          </thead>
          <tbody v-for="section in sections" :key="section.id">
            <tr class="root-row"><th colspan="4" scope="rowgroup"><template>{{ Number(section.code) === 300000 ? 'A. ' : 'B. ' }}</template>{{ section.name }} ({{ section.code }})</th></tr>
            <tr v-for="row in section.rows" :key="row.id" :class="row.depth === 1 ? 'category-row' : 'control-row'">
              <th scope="row" class="particulars" :style="{ paddingLeft: `${(row.depth - 1) * 0.6}rem` }"><template v-if="row.code">{{ row.code }} - </template>{{ row.name }}</th>
              <td class="note-number">
                <button v-if="row.note" type="button" class="note-link" :disabled="!canExport"
                  :aria-label="`View note ${row.note}: ${row.name}`" @click="openNote(row)">{{ row.note }}</button>
              </td>
              <td class="amount"><span>{{ amount(row.balance) }}</span></td>
              <td class="amount"><span>{{ amount(row.comparisonBalance) }}</span></td>
            </tr>
            <tr v-if="!section.rows.length" class="empty-row">
              <td colspan="4">{{ hideZeroBalances ? 'No non-zero balances to display.' : 'No account groups to display.' }}</td>
            </tr>
            <tr class="section-total">
              <th colspan="2" scope="row">Total {{ section.name }}</th>
              <td class="amount"><span>{{ amount(section.balance) }}</span></td>
              <td class="amount"><span>{{ amount(section.comparisonBalance) }}</span></td>
            </tr>
          </tbody>
          <tfoot>
            <tr class="section-total surplus-row"><th colspan="2" scope="row">Surplus / (Deficit) (A-B)</th><td class="amount"><span>{{ amount(surplus) }}</span></td><td class="amount"><span>{{ amount(fiscalSurplus) }}</span></td></tr>
          </tfoot>
        </table>
      </div>
      <table class="statement-table fiscal-summary">
        <tbody>
          <tr class="section-total"><th scope="row">Total financial year income</th><td class="amount"><span>{{ amount(income?.comparisonBalance ?? 0) }}</span></td></tr>
          <tr class="section-total"><th scope="row">Total financial year expenditure</th><td class="amount"><span>{{ amount(expenditure?.comparisonBalance ?? 0) }}</span></td></tr>
          <tr class="section-total"><th scope="row">Total financial year surplus / (deficit)</th><td class="amount"><span>{{ amount(fiscalSurplus) }}</span></td></tr>
        </tbody>
      </table>
      <div class="income-expenditure-signatures"><span>Prepared by</span><span>Checked by</span><span>Authorized by</span></div>
    </article>
    <BModal v-model="noteOpen" :title="noteTitle" size="xl" scrollable hide-footer>
      <div class="d-flex flex-wrap justify-content-end gap-2 mb-3 screen-only">
        <button type="button" class="btn btn-outline-secondary" :disabled="!canExport || !noteData" @click="exportNoteCsv">
          <i class="fas fa-file-csv me-1" aria-hidden="true"></i> Export CSV
        </button>
        <button type="button" class="btn btn-outline-primary" :disabled="!canExport || !noteData" @click="printReport(true)">
          <i class="fas fa-print me-1" aria-hidden="true"></i> Print / PDF
        </button>
      </div>
      <article v-if="noteData && report && comparisonReport" :id="noteReportId" class="income-expenditure-report income-expenditure-note"  :aria-label="`${statementTitle} notes`">
        <header class="income-expenditure-heading">
          <h2 class="company-name">{{ companyName }}</h2>
          <p class="company-address">{{ companyAddress }}</p>
          <h1>{{ statementTitle }} &mdash; Notes</h1>
          <p>{{ 'For the month ended' }} <strong>{{ reportDate }}</strong></p>
          <p>Branch Office: <strong>{{ reportBranch }}</strong></p>
          <p>Print Date: {{ printDateLabel }} </p>
        </header>
        <h2 class="note-account-title">{{ noteTitle }}</h2>
        <p class="small text-muted mb-2">{{ noteData.path.join(' / ') }}</p>
        <p class="small">{{ periodDescription }}</p>
        <div class="income-expenditure-table-wrap">
          <table class="statement-table note-table note-summary">
            <colgroup><col style="width: 59%"><col class="amount-column"><col class="amount-column"></colgroup>
            <thead><tr><th scope="col">Reported account totals</th><th scope="col" class="text-end">{{ currentColumnLabel }}</th><th scope="col" class="text-end">{{ comparisonColumnLabel }}</th></tr></thead>
            <tbody>
              <tr><th scope="row">Debit</th><td class="amount"><span>{{ amount(noteData.totalDebit) }}</span></td><td class="amount"><span>{{ amount(noteData.comparisonDebit) }}</span></td></tr>
              <tr><th scope="row">Credit</th><td class="amount"><span>{{ amount(noteData.totalCredit) }}</span></td><td class="amount"><span>{{ amount(noteData.comparisonCredit) }}</span></td></tr>
              <tr class="section-total"><th scope="row">Balance</th><td class="amount"><span>{{ amount(noteData.balance) }}</span></td><td class="amount"><span>{{ amount(noteData.comparisonBalance) }}</span></td></tr>
            </tbody>
          </table>
        </div>
        <h3 class="h6 mt-4">Subaccount breakdown</h3>
        <div v-if="noteData.rows.length" class="income-expenditure-table-wrap">
          <table class="statement-table note-table">
            <colgroup><col style="width: 59%"><col class="amount-column"><col class="amount-column"></colgroup>
              <thead><tr><th rowspan="2" scope="col">Particulars</th><th colspan="2" scope="colgroup">Amount ({{ currency }})</th></tr><tr><th scope="col">{{ currentColumnLabel }}</th><th scope="col">{{ comparisonColumnLabel }}</th></tr></thead>
            <tbody>
              <tr v-for="row in noteData.rows" :key="row.id" :class="row.hasChildren ? 'category-row' : 'control-row'">
                <td :style="{ paddingLeft: `${0.5 + (row.depth - 1) * 0.8}rem` }"><template v-if="row.code">{{ row.code }} - </template>{{ row.name }}</td>
                <td class="amount"><span>{{ amount(row.balance) }}</span></td><td class="amount"><span>{{ amount(row.comparisonBalance) }}</span></td>
              </tr>
            </tbody>
            <tfoot><tr class="section-total"><th scope="row">Total {{ noteData.name }}</th><td class="amount"><span>{{ amount(noteData.balance) }}</span></td><td class="amount"><span>{{ amount(noteData.comparisonBalance) }}</span></td></tr></tfoot>
          </table>
          <p class="small text-muted">Group totals include their subaccounts. Amounts in parentheses are deductions.</p>
        </div>
        <p v-else class="text-muted">This account has no subaccounts. Its balances for the stated periods are shown above.</p>
        <div class="income-expenditure-signatures"><span>Prepared by</span><span>Checked by</span><span>Authorized by</span></div>
      </article>
      <div class="text-end mt-3"><button type="button" class="btn btn-secondary" @click="noteOpen = false">Close</button></div>
    </BModal>
  </div>
</template>

<style scoped>
.income-expenditure-report .income-expenditure-heading h1 { text-transform: uppercase; text-decoration: underline; }
.income-expenditure-report .section-total .amount span { border-top: 1px solid #111; }
.income-expenditure-report .surplus-row th, .income-expenditure-report .surplus-row td { padding-top: 1rem; }
.fiscal-summary { margin-top: 2rem; margin-left: auto; width: 65%; }
.fiscal-summary th { text-align: right !important; padding-right: 0.5rem !important; }
.fiscal-summary td { width: 32%; }
.income-expenditure-page { padding-bottom: 2rem; }
.report-options { font-size: 0.875rem; }
.income-expenditure-report { margin: 0 auto; background: #fff; color: #111; padding: 2.5rem 2rem; font-family: Arial, sans-serif; }
.income-expenditure-heading { text-align: center; margin-bottom: 2rem; line-height: 1.4; break-inside: avoid; }
.company-name { font-size: 1.2rem; font-weight: 700; margin: 0 0 0.45rem; }
.company-address { font-size: 0.75rem; margin-bottom: 1rem !important; }
.income-expenditure-heading h1 { font-size: 1.1rem; font-weight: 700; margin: 0 0 0.5rem; }
.income-expenditure-heading p { font-size: 0.8rem; margin: 0 0 0.2rem; }
.income-expenditure-table-wrap { overflow-x: auto; }
.statement-table { width: 100%; border-collapse: collapse; font-size: 0.82rem; table-layout: fixed; line-height: 1.35; }
.particulars-column { width: 51%; }
.notes-column { width: 8%; }
.amount-column { width: 20.5%; }
.statement-table thead th { border: 1px solid #111; text-align: center; text-transform: uppercase; padding: 0.2rem; font-weight: 700; }
.statement-table tbody th, .statement-table tbody td { padding: 0.17rem 0; border: 0; vertical-align: top; }
.statement-table .root-row th { text-align: left; font-weight: 700; text-transform: uppercase; padding-top: 0.35rem; }
.statement-table .particulars { text-align: left; font-weight: 400; overflow-wrap: anywhere; }
.statement-table .category-row .particulars { font-weight: 700; }
.statement-table .control-row .particulars { padding-left: 0.45rem; }
.statement-table .note-number { text-align: center; color: #d51b30; text-decoration: underline; font-variant-numeric: tabular-nums; }
.note-link { border: 0; background: transparent; color: inherit; text-decoration: underline; font: inherit; padding: 0; cursor: pointer; }
.note-link:focus-visible { outline: 2px solid #244b70; outline-offset: 3px; }
.note-link:disabled { cursor: default; opacity: 0.6; }
.note-account-title { font-size: 0.95rem; font-weight: 700; margin-bottom: 0.5rem; }
.note-table { margin-bottom: 1rem; }
.note-table tbody th { text-align: left; font-weight: 400; }
.note-table tbody th, .note-table tbody td, .note-table tfoot th, .note-table tfoot td { padding: 0.3rem 0.2rem; }
.note-table .category-row td:first-child { font-weight: 700; }
.income-expenditure-note .small { font-size: 0.75rem; }
@media print {
  :global(body:has(#print-el .income-expenditure-note) .modal),
  :global(body:has(#print-el .income-expenditure-note) .modal-backdrop) { display: none !important; }
}
.statement-table .amount { text-align: right; font-variant-numeric: tabular-nums; white-space: nowrap; padding-left: 0.65rem; }
.statement-table .amount span { display: block; padding: 0 0.15rem; }
.statement-table .category-row .amount span { font-weight: 700; }
.statement-table .section-total th { text-align: center; text-transform: uppercase; font-weight: 700; padding-top: 0.2rem; }
.statement-table .section-total .amount span { border-top: 1px solid #111; border-bottom: 3px double #111; font-weight: 700; }
.statement-table .empty-row td { padding: 0.5rem 0; color: #555; text-align: center; }
.income-expenditure-signatures { display: flex; justify-content: space-between; gap: 2rem; margin-top: 5rem; text-align: center; font-size: 0.78rem; font-weight: 700; text-transform: uppercase; break-inside: avoid; }
.income-expenditure-signatures span { width: 30%; border-top: 1px solid #555; padding-top: 0.25rem; }
@media (min-width: 992px) { .report-submit { padding-top: 2rem; } }
@media screen and (max-width: 767px) {
  .income-expenditure-report { padding: 1.25rem 0.75rem; }
  .statement-table { min-width: 650px; }
  .income-expenditure-signatures { gap: 1rem; font-size: 0.7rem; }
}
@media print {
  .income-expenditure-report { max-width: none; width: 100%; margin: 0; border: 0; padding: 0.1in 0; color: #000; print-color-adjust: exact; -webkit-print-color-adjust: exact; }
  .income-expenditure-heading { margin-bottom: 0.3in; }
  .company-name { font-size: 13pt; }
  .income-expenditure-heading h1 { font-size: 11pt; }
  .income-expenditure-heading p { font-size: 9pt; }
  .income-expenditure-heading .company-address { font-size: 8pt; }
  .income-expenditure-table-wrap { overflow: visible; }
  .statement-table { min-width: 0; font-size: 9pt; }
  .statement-table thead { display: table-header-group; }
  .statement-table tfoot { display: table-row-group; }
  .statement-table tr { break-inside: avoid; }
  .statement-table .root-row, .statement-table .category-row { break-after: avoid; }
  .statement-table .section-total { break-before: avoid; }
  .income-expenditure-signatures { margin-top: 0.7in; font-size: 9pt; }
  .screen-only { display: none !important; }
}
</style>
