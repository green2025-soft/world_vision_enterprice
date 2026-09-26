<script setup>
import { computed, nextTick, onMounted, reactive, ref, watch } from 'vue'
import { useApiClient } from '@/composables/useApiClient'
import { useBranchStore } from '@/store/branch-store'
import { useSettingsStore } from '@/store/settings-store'
import { printADiv } from '@/utilities/methods'
import { buildComparativeBalanceSheetSections, buildBalanceSheetNote, fiscalYearComparisonMonth, formatBalanceAmount } from '@/modules/accounting/utils/balanceSheet'

const api = useApiClient()
const statementTitle = ref('Balance Sheet')
const reportId = ref('balance-sheet-report')
const noteReportId = ref('balance-sheet-note-report')
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
const earningsLines = [
  { key: 'posted_balance', label: 'Posted account balance (including closing entries)' },
  { key: 'income_balance', label: 'Income balance after closing entries' },
  { key: 'expense_balance', label: 'Expense balance after closing entries' },
  { key: 'unclosed_balance', label: 'Unclosed income less expenditure' },
  { key: 'reported_balance', label: 'Income over expenditure shown in this report' },
]
const earningsConfigurationMissing = computed(() => [report.value, comparisonReport.value].some(period =>
  period?.income_over_expenditure?.configured === false && period.income_over_expenditure.unclosed_balance !== 0,
))

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
const sections = computed(() => buildComparativeBalanceSheetSections(report.value?.coa || [], comparisonReport.value?.coa || [], {
  maxDepth: detailLevel.value,
  hideZeroBalances: hideZeroBalances.value,
}))
const assets = computed(() => sections.value.find(section => Number(section.code) === 100000))
const funds = computed(() => sections.value.find(section => Number(section.code) === 200000))
const currentColumnLabel = computed(() => periodLabel(report.value?.month))
const comparisonColumnLabel = computed(() => periodLabel(comparisonReport.value?.month))
const periodDescription = computed(() => `Cumulative balances up to ${report.value?.month} and ${comparisonReport.value?.month}. Both include all earlier entries.`)
const reportBasis = computed(() => 'Cumulative pending and approved entries through the report date; rejected entries excluded.')
const difference = computed(() => assets.value && funds.value
  ? Math.round((assets.value.balance - funds.value.balance) * 100) / 100
  : null)
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
  try {
    const fetchPeriod = (month, period) => api.get(`accounting/balance-sheet`, {
      requiresAuth: true,
      loading: false,
      tosterMessage: false,
      params: { month, branch_id: requested.branchId, depth: 4, ...(period ? { period } : {}) },
    })
    const [response, comparison] = await Promise.all([
      fetchPeriod(requested.month),
      fetchPeriod(requested.comparisonMonth),
    ])
    if ([response, comparison].some(result => result.status !== true || !Array.isArray(result.data?.coa))) {
      throw new Error('The statement response is incomplete. Please try again.')
    }
    report.value = response.data
    comparisonReport.value = comparison.data
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
    [statementTitle.value, `${'As at'} ${reportDate.value}`],
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
  if (difference.value !== null) rows.push(['Assets less funds & liabilities', difference.value])
  rows.push(['Basis', reportBasis.value])
  rows.push(['Generated', generatedLabel.value])

  downloadCsv(rows, `balance-sheet-${appliedFilters.value.month}-branch-${report.value.branch_id || 'all'}.csv`)
}

function exportNoteCsv() {
  if (!canExport.value || !noteData.value) return
  const note = noteData.value
  const columns = ['Particulars', currentColumnLabel.value, comparisonColumnLabel.value]
  const rows = [
    [companyName], [companyAddress], [`${statementTitle.value} — Notes`, `${'As at'} ${reportDate.value}`],
    [noteTitle.value], ['Branch Office', reportBranch.value], ['Currency', currency.value],
    ['Account path', note.path.join(' / ')],
    ['Periods', periodDescription.value], [],
  ]
  if (note.earnings || note.comparisonEarnings) {
    rows.push(['Income and expenditure reconciliation'], columns)
    earningsLines.forEach(line => rows.push([line.label, note.earnings?.[line.key] ?? 0, note.comparisonEarnings?.[line.key] ?? 0]))
    rows.push(['Basis', 'Posted closing entries are included; only remaining net income is added as a calculated report amount.'], [])
  }
  rows.push(['Reported account totals'], columns,
    ['Debit', note.totalDebit, note.comparisonDebit],
    ['Credit', note.totalCredit, note.comparisonCredit],
    ['Balance', note.balance, note.comparisonBalance], [], ['Subaccount breakdown'], columns)
  note.rows.forEach(row => rows.push([`${'  '.repeat(Math.max(0, row.depth - 1))}${row.code ? `${row.code} - ` : ''}${row.name}`, row.balance, row.comparisonBalance]))
  rows.push([`Total ${note.name}`, note.balance, note.comparisonBalance],
    ['Basis', `${reportBasis.value} Group totals include their subaccounts.`],
    ['Generated', generatedLabel.value])
  downloadCsv(rows, `balance-sheet-note-${selectedNote.value.note}-${appliedFilters.value.month}-branch-${report.value.branch_id || 'all'}.csv`)
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
  <div class="container-fluid balance-sheet-page">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-3">
      <div>
        <h2 class="h4 mb-1"><i class="fas fa-balance-scale me-2" aria-hidden="true"></i>{{ statementTitle }}</h2>
        <p class="text-muted mb-0">{{ 'Financial position at the end of the selected month.' }}</p>
      </div>
      <div class="d-flex gap-2">
        <RouterLink class="btn btn-outline-secondary" to="/accounting/cash-flow-statement">Cash Flow Statement</RouterLink>
        <RouterLink class="btn btn-outline-secondary" to="/accounting/changes-in-equity">Changes in Equity</RouterLink>
        <RouterLink class="btn btn-outline-secondary" to="/accounting/trial-balance">Trial Balance</RouterLink>
        <RouterLink class="btn btn-outline-secondary" :to="'/accounting/income-expenditure'">
          {{ 'Income & Expenditure' }}
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
                <label for="balance-sheet-month" class="form-label">Report month <span class="text-danger">*</span></label>
                <input id="balance-sheet-month" v-model="filters.month" type="month" required
                  class="form-control" :class="{ 'is-invalid': errors.month }"
                  :aria-invalid="Boolean(errors.month)" aria-describedby="balance-sheet-month-error">
                <div id="balance-sheet-month-error" class="invalid-feedback">{{ errors.month?.[0] }}</div>
              </div>
              <div class="col-sm-6 col-lg-3">
                <label for="balance-sheet-detail" class="form-label">Detail level</label>
                <select id="balance-sheet-detail" v-model.number="detailLevel" class="form-select">
                  <option v-for="level in detailLevels" :key="level.value" :value="level.value">{{ level.label }}</option>
                </select>
              </div>
              <div class="col-sm-6 col-lg-3">
                <label for="balance-sheet-branch" class="form-label">Branch</label>
                <select id="balance-sheet-branch" v-model.number="filters.branchId" class="form-select"
                  :class="{ 'is-invalid': errors.branch_id }" :disabled="branchesLoading"
                  :aria-invalid="Boolean(errors.branch_id)" aria-describedby="balance-sheet-branch-error">
                  <option :value="0">All branches</option>
                  <option v-for="branch in branchOptions" :key="branch.id" :value="Number(branch.id)">{{ branch.name }}</option>
                </select>
                <div id="balance-sheet-branch-error" class="invalid-feedback">{{ errors.branch_id?.[0] }}</div>
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
          <span v-if="comparisonMonth" class="text-muted">
            July–June financial year. Comparison: cumulative balance up to 30 June {{ comparisonMonth.slice(0, 4) }}.
          </span>
          <div class="form-check mb-0">
            <input id="balance-sheet-hide-zero" v-model="hideZeroBalances" type="checkbox" class="form-check-input">
            <label for="balance-sheet-hide-zero" class="form-check-label">Hide zero balances</label>
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

    <article v-else-if="report" :id="reportId" class="balance-sheet-report"  :aria-label="statementTitle">
      <header class="balance-sheet-heading">
        <h2 class="company-name">{{ companyName }}</h2>
        <p class="company-address">{{ companyAddress }}</p>
        <h1>{{ statementTitle }}</h1>
        <p>{{ 'As at' }} <strong>{{ reportDate }}</strong></p>
        <p>Branch Office: <strong>{{ reportBranch }}</strong></p>
        <p>Print Date: {{ printDateLabel }} </p>
      </header>

      <div class="balance-sheet-table-wrap">
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
              <th scope="col">{{ currentColumnLabel }}</th>
              <th scope="col">{{ comparisonColumnLabel }}</th>
            </tr>
          </thead>
          <tbody v-for="section in sections" :key="section.id">
            <tr class="root-row"><th colspan="4" scope="rowgroup">{{ section.name }} ({{ section.code }})</th></tr>
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
        </table>
      </div>
      <div class="balance-sheet-signatures"><span>Prepared by</span><span>Checked by</span><span>Authorized by</span></div>
    </article>
    <div v-if="report && earningsConfigurationMissing" class="alert alert-warning mt-3 screen-only" role="status">
      Assign the <strong>Income over expenditure</strong> report role to an account under Funds &amp; Liabilities in Chart of Accounts to include unclosed income and expenses.
    </div>
    <div v-else-if="report && difference !== null && difference !== 0" class="alert alert-warning mt-3 screen-only" role="status">
      Current-period difference (assets less funds &amp; liabilities): <strong>{{ amount(difference) }}</strong>.
      Income and expenditure have been included. Review the journal entries and account hierarchy for the remaining difference.
    </div>
    <BModal v-model="noteOpen" :title="noteTitle" size="xl" scrollable hide-footer>
      <div class="d-flex flex-wrap justify-content-end gap-2 mb-3 screen-only">
        <button type="button" class="btn btn-outline-secondary" :disabled="!canExport || !noteData" @click="exportNoteCsv">
          <i class="fas fa-file-csv me-1" aria-hidden="true"></i> Export CSV
        </button>
        <button type="button" class="btn btn-outline-primary" :disabled="!canExport || !noteData" @click="printReport(true)">
          <i class="fas fa-print me-1" aria-hidden="true"></i> Print / PDF
        </button>
      </div>
      <article v-if="noteData && report && comparisonReport" :id="noteReportId" class="balance-sheet-report balance-sheet-note"  :aria-label="`${statementTitle} notes`">
        <header class="balance-sheet-heading">
          <h2 class="company-name">{{ companyName }}</h2>
          <p class="company-address">{{ companyAddress }}</p>
          <h1>{{ statementTitle }} &mdash; Notes</h1>
          <p>{{ 'As at' }} <strong>{{ reportDate }}</strong></p>
          <p>Branch Office: <strong>{{ reportBranch }}</strong></p>
          <p>Print Date: {{ printDateLabel }} </p>
        </header>
        <h2 class="note-account-title">{{ noteTitle }}</h2>
        <p class="small text-muted mb-2">{{ noteData.path.join(' / ') }}</p>
        <p class="small">{{ periodDescription }}</p>
        <template v-if="noteData.earnings || noteData.comparisonEarnings">
          <h3 class="h6">Income and expenditure reconciliation</h3>
          <div class="balance-sheet-table-wrap">
            <table class="statement-table note-table">
              <colgroup><col style="width: 59%"><col class="amount-column"><col class="amount-column"></colgroup>
              <thead><tr><th rowspan="2" scope="col">Particulars</th><th colspan="2" scope="colgroup">Amount ({{ currency }})</th></tr><tr><th scope="col">{{ currentColumnLabel }}</th><th scope="col">{{ comparisonColumnLabel }}</th></tr></thead>
              <tbody>
                <tr v-for="line in earningsLines" :key="line.key" :class="{ 'section-total': line.key === 'reported_balance' }">
                  <th scope="row">{{ line.label }}</th>
                  <td class="amount"><span>{{ amount(noteData.earnings?.[line.key] ?? 0) }}</span></td>
                  <td class="amount"><span>{{ amount(noteData.comparisonEarnings?.[line.key] ?? 0) }}</span></td>
                </tr>
              </tbody>
            </table>
          </div>
          <p class="small text-muted">Posted closing entries are already reflected in these balances. Only the remaining net income is added as a calculated report amount; no journal entry is created.</p>
        </template>
        <div class="balance-sheet-table-wrap">
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
        <div v-if="noteData.rows.length" class="balance-sheet-table-wrap">
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
        <div class="balance-sheet-signatures"><span>Prepared by</span><span>Checked by</span><span>Authorized by</span></div>
      </article>
      <div class="text-end mt-3"><button type="button" class="btn btn-secondary" @click="noteOpen = false">Close</button></div>
    </BModal>
  </div>
</template>

<style scoped>
.balance-sheet-page { padding-bottom: 2rem; }
.report-options { font-size: 0.875rem; }
.balance-sheet-report { margin: 0 auto; background: #fff; color: #111; padding: 2.5rem 2rem; font-family: Arial, sans-serif; }
.balance-sheet-heading { text-align: center; margin-bottom: 2rem; line-height: 1.4; break-inside: avoid; }
.company-name { font-size: 1.2rem; font-weight: 700; margin: 0 0 0.45rem; }
.company-address { font-size: 0.75rem; margin-bottom: 1rem !important; }
.balance-sheet-heading h1 { font-size: 1.1rem; font-weight: 700; margin: 0 0 0.5rem; }
.balance-sheet-heading p { font-size: 0.8rem; margin: 0 0 0.2rem; }
.balance-sheet-table-wrap { overflow-x: auto; }
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
.balance-sheet-note .small { font-size: 0.75rem; }
@media print {
  :global(body:has(#print-el .balance-sheet-note) .modal),
  :global(body:has(#print-el .balance-sheet-note) .modal-backdrop) { display: none !important; }
}
.statement-table .amount { text-align: right; font-variant-numeric: tabular-nums; white-space: nowrap; padding-left: 0.65rem; }
.statement-table .amount span { display: block; padding: 0 0.15rem; }
.statement-table .category-row .amount span { border: 1px solid #111; font-weight: 700; }
.statement-table .section-total th { text-align: center; text-transform: uppercase; font-weight: 700; padding-top: 0.2rem; }
.statement-table .section-total .amount span { border-bottom: 3px double #111; font-weight: 700; }
.statement-table .empty-row td { padding: 0.5rem 0; color: #555; text-align: center; }
.balance-sheet-signatures { display: flex; justify-content: space-between; gap: 2rem; margin-top: 5rem; text-align: center; font-size: 0.78rem; font-weight: 700; text-transform: uppercase; break-inside: avoid; }
.balance-sheet-signatures span { width: 30%; border-top: 1px solid #555; padding-top: 0.25rem; }
@media (min-width: 992px) { .report-submit { padding-top: 2rem; } }
@media screen and (max-width: 767px) {
  .balance-sheet-report { padding: 1.25rem 0.75rem; }
  .statement-table { min-width: 650px; }
  .balance-sheet-signatures { gap: 1rem; font-size: 0.7rem; }
}
@media print {
  .balance-sheet-report { max-width: none; width: 100%; margin: 0; border: 0; padding: 0.1in 0; color: #000; print-color-adjust: exact; -webkit-print-color-adjust: exact; }
  .balance-sheet-heading { margin-bottom: 0.3in; }
  .company-name { font-size: 13pt; }
  .balance-sheet-heading h1 { font-size: 11pt; }
  .balance-sheet-heading p { font-size: 9pt; }
  .balance-sheet-heading .company-address { font-size: 8pt; }
  .balance-sheet-table-wrap { overflow: visible; }
  .statement-table { min-width: 0; font-size: 9pt; }
  .statement-table thead { display: table-header-group; }
  .statement-table tr { break-inside: avoid; }
  .statement-table .root-row, .statement-table .category-row { break-after: avoid; }
  .statement-table .section-total { break-before: avoid; }
  .balance-sheet-signatures { margin-top: 0.7in; font-size: 9pt; }
  .screen-only { display: none !important; }
}
</style>
