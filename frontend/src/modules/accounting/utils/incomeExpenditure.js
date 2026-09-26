import { buildComparativeBalanceSheetSections } from './balanceSheet.js'

// Continue the visible balance-sheet note sequence for the same month, branch and detail.
export function buildIncomeExpenditureSections(monthCoa, fiscalCoa, balanceCoa, comparisonBalanceCoa, options = {}) {
  const balanceSections = buildComparativeBalanceSheetSections(balanceCoa, comparisonBalanceCoa, options)
  let serial = balanceSections.reduce((last, section) =>
    section.rows.reduce((value, row) => Math.max(value, Number(row.note) || 0), last), 0)
  return buildComparativeBalanceSheetSections(monthCoa, fiscalCoa, options).map(section => ({
    ...section,
    rows: section.rows.map(row => ({ ...row, note: row.note ? String(++serial).padStart(2, '0') : '' })),
  }))
}
