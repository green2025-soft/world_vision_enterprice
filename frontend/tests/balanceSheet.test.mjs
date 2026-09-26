import test from 'node:test'
import assert from 'node:assert/strict'
import { buildBalanceSheetSections, buildComparativeBalanceSheetSections, buildBalanceSheetNote, fiscalYearComparisonMonth, formatBalanceAmount } from '../src/modules/accounting/utils/balanceSheet.js'

function account(id, code, debit = 0, credit = 0, children = [], extra = {}) {
  return {
    id, code, name: `Account ${id}`,
    total_debit: debit, total_credit: credit,
    children, ...extra,
  }
}

test('income statement compares independent month and FY totals and keeps expense deductions in notes', () => {
  const periods = (income, expense, refund) => [
    account(3, 300000, 0, income, [account(30, 310000, 0, income)], { type: 'income', is_debit: false }),
    account(4, 400000, expense, refund, [
      account(40, 410000, expense, refund, [
        account(41, 411000, expense, 0), account(42, 412000, 0, refund, [], { is_debit: false }),
      ]),
    ], { type: 'expense', is_debit: true }),
  ]
  const month = periods(100, 150, 20)
  const fy = periods(800, 500, 30)
  const sections = buildComparativeBalanceSheetSections(month, fy)
  assert.equal(sections[0].balance, 100)
  assert.equal(sections[0].comparisonBalance, 800)
  assert.equal(sections[1].balance, 130)
  assert.equal(sections[1].comparisonBalance, 470)
  assert.equal(sections[0].balance - sections[1].balance, -30)
  const note = buildBalanceSheetNote(month, fy, 40)
  assert.equal(note.balance, 130)
  assert.equal(note.comparisonBalance, 470)
  assert.equal(note.rows.find(row => row.id === 42).balance, -20)
  assert.equal(note.rows.find(row => row.id === 42).comparisonBalance, -30)
})

test('uses each API root total without double counting categories and controls', () => {
  const coa = [account(1, 100000, '150.25', '20.10', [
    account(2, 110000, '100.25', '20.10', [account(3, 111000, '100.25', '20.10')]),
  ], { type: 'asset', balance: 9999 })]

  const [section] = buildBalanceSheetSections(coa)
  assert.equal(section.balance, 130.15)
  assert.equal(section.totalDebit, 150.25)
  assert.equal(section.totalCredit, 20.10)
  assert.deepEqual(section.rows.map(row => row.balance), [80.15, 80.15])
  assert.equal(section.rows.some(row => row.id === section.id), false)
})

test('contra asset and liability balances retain deductions using the root sign', () => {
  const coa = [
    account(1, 100000, 100, 25, [
      account(2, 110000, 0, 25, [], { is_debit: false, balance: 25 }),
    ], { type: 'asset', is_debit: true }),
    account(3, 200000, 15, 100, [
      account(4, 210000, 15, 0, [], { is_debit: true, balance: 15 }),
    ], { type: 'equity_liability', is_debit: false }),
  ]

  const [assets, liabilities] = buildBalanceSheetSections(coa)
  assert.equal(assets.balance, 75)
  assert.equal(assets.rows[0].balance, -25)
  assert.equal(liabilities.balance, 85)
  assert.equal(liabilities.rows[0].balance, -15)
})

test('supports debit-normal roots and decimal strings without floating point subtraction artifacts', () => {
  const [section] = buildBalanceSheetSections([
    account(1, 100000, '0.30', '0.10', [account(2, 110000, '10.075', '0.005')], { is_debit: '1' }),
  ])

  assert.equal(section.balance, 0.2)
  assert.equal(section.rows[0].totalDebit, 10.08)
  assert.equal(section.rows[0].totalCredit, 0.01)
  assert.equal(section.rows[0].balance, 10.07)
})

test('zero filtering retains offsetting descendants beyond the visible depth', () => {
  const coa = [account(1, 100000, 20, 20, [
    account(2, 110000, 20, 20, [
      account(3, 111000, 20, 20, [
        account(4, 111100, 20, 0),
        account(5, 111200, 0, 20),
      ]),
    ]),
    account(6, 120000, 5, 5, [account(7, 121000, 5, 5)]),
  ], { type: 'asset' })]

  const [categories] = buildBalanceSheetSections(coa, { maxDepth: 1, hideZeroBalances: true })
  assert.equal(categories.balance, 0)
  assert.deepEqual(categories.rows.map(row => row.id), [2])
  assert.equal(categories.rows[0].hasChildren, true)

  const [controls] = buildBalanceSheetSections(coa, { hideZeroBalances: true })
  assert.deepEqual(controls.rows.map(row => row.id), [2, 3])
  assert.deepEqual(controls.rows.map(row => row.depth), [1, 2])

  const [unfiltered] = buildBalanceSheetSections(coa)
  assert.deepEqual(unfiltered.rows.map(row => row.id), [2, 3, 6, 7])
})

test('sorts numeric account codes per level without changing the API tree', () => {
  const coa = [
    account(1, '10'),
    account(2, '2', 0, 0, [
      account(3, '10'),
      account(4, '2', 0, 0, [account(5, '20'), account(6, '3')]),
    ], { type: 'asset' }),
  ]
  const original = structuredClone(coa)
  const sections = buildBalanceSheetSections(coa)

  assert.deepEqual(sections.map(section => section.code), ['2', '10'])
  assert.deepEqual(sections[0].rows.map(row => row.code), ['2', '3', '20', '10'])
  assert.deepEqual(coa, original)
})

test('retains roots when all zero rows are hidden and accepts an empty response', () => {
  assert.deepEqual(buildBalanceSheetSections(null), [])
  const sections = buildBalanceSheetSections([account(1, 100000, 0, 0, [account(2, 110000)])], {
    hideZeroBalances: true,
  })
  assert.equal(sections.length, 1)
  assert.deepEqual(sections[0].rows, [])
})

test('formats English Bangladesh amounts and accounting deductions with two decimals', () => {
  assert.equal(formatBalanceAmount('1234567.8'), '1,234,567.80')
  assert.equal(formatBalanceAmount('-1234.5'), '(1,234.50)')
  assert.equal(formatBalanceAmount('-0.004'), '0.00')
  assert.equal(formatBalanceAmount('1.005'), '1.01')
  assert.equal(formatBalanceAmount(null), '0.00')
})

test('comparison retains prior-period-only accounts and matches totals without double counting', () => {
  const current = [account(1, 100000, 100, 0, [account(2, 110000, 100, 0, [account(3, 111000, 100)])], { type: 'asset' })]
  const previous = [account(1, 100000, 50, 10, [account(2, 110000, 50, 10, [
    account(3, 111000, 50), account(4, 112000, 0, 10),
  ])], { type: 'asset' })]
  const original = structuredClone([current, previous])
  const [section] = buildComparativeBalanceSheetSections(current, previous)
  assert.equal(section.balance, 100)
  assert.equal(section.comparisonBalance, 40)
  assert.deepEqual(section.rows.map(row => [row.id, row.balance, row.comparisonBalance, row.note]), [
    [2, 100, 40, ''], [3, 100, 50, '01'], [4, 0, -10, '02'],
  ])
  assert.deepEqual([current, previous], original)
})

test('comparison zero filter checks both periods and retains parents with offsetting children', () => {
  const current = [account(1, 100000, 0, 0, [account(2, 110000, 0, 0, [
    account(3, 111000), account(4, 112000), account(5, 113000),
  ])], { type: 'asset' })]
  const previous = [account(1, 100000, 20, 20, [account(2, 110000, 20, 20, [
    account(3, 111000, 20), account(4, 112000, 0, 20), account(5, 113000),
  ])], { type: 'asset' })]
  const [section] = buildComparativeBalanceSheetSections(current, previous, { hideZeroBalances: true })
  assert.deepEqual(section.rows.map(row => row.id), [2, 3, 4])
  const [summary] = buildComparativeBalanceSheetSections(current, previous, { maxDepth: 1, hideZeroBalances: true })
  assert.deepEqual(summary.rows.map(row => row.id), [2])
  assert.equal(summary.balance, 0)
  assert.equal(summary.comparisonBalance, 0)
})

test('financial year baseline stays at the previous June closing across the calendar-year boundary', () => {
  for (const month of ['2026-07', '2026-09', '2026-12', '2027-01', '2027-06']) {
    assert.equal(fiscalYearComparisonMonth(month), '2026-06')
  }
  assert.equal(fiscalYearComparisonMonth('2026-06'), '2025-06')
  assert.equal(fiscalYearComparisonMonth('2027-07'), '2027-06')
  assert.equal(fiscalYearComparisonMonth('2026-13'), '')
})

test('detail levels expose notes at the displayed level through ledger accounts', () => {
  const tree = [account(1, 100000, 120, 0, [account(2, 110000, 120, 0, [
    account(3, 111000, 120, 0, [account(4, 111100, 120, 0, [account(5, 111101, 120)])]),
  ])], { type: 'asset' })]
  for (const maxDepth of [1, 2, 3, 4]) {
    const [section] = buildComparativeBalanceSheetSections(tree, [], { maxDepth })
    assert.equal(section.rows.length, maxDepth)
    assert.equal(section.rows.at(-1).note, '01')
    assert.equal(section.rows.at(-1).balance, 120)
    assert.equal(section.balance, 120)
  }
})

test('notes retain section signs for contra accounts and show both periods through leaf ledgers', () => {
  const tree = amount => [account(1, 200000, amount, 0, [
    account(2, 210000, amount, 0, [account(3, 211000, amount, 0, [
      account(4, 211100, amount, 0, [account(5, 211101, amount, 0, [], { is_debit: true })]),
    ], { is_debit: true })]),
  ], { type: 'equity_liability', is_debit: false })]
  const note = buildBalanceSheetNote(tree(125.35), tree(20.10), 3)
  assert.equal(note.balance, -125.35)
  assert.equal(note.comparisonBalance, -20.10)
  assert.equal(note.totalDebit, 125.35)
  assert.equal(note.comparisonDebit, 20.10)
  assert.equal(note.totalCredit, 0)
  assert.deepEqual(note.rows.map(row => row.id), [4, 5])
  assert.equal(note.rows[1].balance, -125.35)
  assert.deepEqual(note.path, ['Account 1', 'Account 2', 'Account 3'])
  assert.deepEqual(buildBalanceSheetNote(tree(125.35), tree(20.10), 5).rows, [])
  assert.equal(buildBalanceSheetNote(tree(125.35), [], 999), null)
  assert.equal(buildBalanceSheetNote([], tree(20.10), 3).comparisonBalance, -20.10)
})

test('income reconciliation remains available in Notes and calculated lines are not counted twice', () => {
  const earnings = { posted_balance: 40, income_balance: 40, expense_balance: 20, unclosed_balance: 20, reported_balance: 60 }
  const previousEarnings = { posted_balance: 10, income_balance: 0, expense_balance: 0, unclosed_balance: 0, reported_balance: 10 }
  const current = [account(1, 200000, 0, 60, [account(2, 210000, 0, 60, [
    account(3, 213000, 0, 60, [
      account('income-over-expenditure-unclosed', '', 0, 20, [], { is_report_adjustment: true }),
      account(4, 213100, 0, 40, [account(5, 213101, 0, 40)]),
    ], { earnings }),
  ])], { type: 'equity_liability', is_debit: false })]
  const previous = [account(1, 200000, 0, 10, [account(2, 210000, 0, 10, [
    account(3, 213000, 0, 10, [account(4, 213100, 0, 10, [account(5, 213101, 0, 10)])], { earnings: previousEarnings }),
  ])], { type: 'equity_liability', is_debit: false })]
  const [section] = buildComparativeBalanceSheetSections(current, previous, { maxDepth: 4 })
  assert.equal(section.balance, 60)
  assert.ok(section.rows.find(row => row.id === 3).note)
  assert.equal(section.rows.at(-1).id, 'income-over-expenditure-unclosed')
  assert.equal(section.rows.at(-1).note, '')
  const note = buildBalanceSheetNote(current, previous, 3)
  assert.deepEqual(note.earnings, earnings)
  assert.deepEqual(note.comparisonEarnings, previousEarnings)
  assert.equal(note.balance, 60)
  assert.equal(note.comparisonBalance, 10)
  assert.equal(note.rows.filter(row => row.depth === 1).reduce((sum, row) => sum + row.balance, 0), 60)
  const previousOnly = buildBalanceSheetNote([], previous, 3)
  assert.equal(previousOnly.earnings, null)
  assert.deepEqual(previousOnly.comparisonEarnings, previousEarnings)
})
