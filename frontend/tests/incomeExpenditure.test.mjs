import test from 'node:test'
import assert from 'node:assert/strict'
import { buildIncomeExpenditureSections } from '../src/modules/accounting/utils/incomeExpenditure.js'

const leaf = (id, value = 1) => ({ id, code: id, name: `Account ${id}`, total_debit: value, total_credit: 0, children: [] })
const root = (id, children) => ({ ...leaf(id), children })
const serials = sections => sections.flatMap(section => section.rows.filter(row => row.note).map(row => row.note))

test('income notes start at 14 after balance-sheet note 13 and continue across income and expenditure', () => {
  const balance = [root(100000, Array.from({ length: 13 }, (_, index) => leaf(110000 + index)))]
  const income = [root(300000, [leaf(310000)]), root(400000, [leaf(410000)])]
  const result = buildIncomeExpenditureSections(income, income, balance, balance)
  assert.deepEqual(serials(result), ['14', '15'])
  assert.equal(result[0].rows[0].balance, -1)
})

test('uses last visible balance note and skips zero income rows without gaps', () => {
  const balance = [root(100000, [leaf(110000), leaf(120000, 0)])]
  const income = [root(300000, [leaf(310000, 0), leaf(320000)])]
  assert.deepEqual(serials(buildIncomeExpenditureSections(income, income, balance, balance, { hideZeroBalances: true })), ['02'])
  assert.deepEqual(serials(buildIncomeExpenditureSections(income, income, balance, balance)), ['03', '04'])
})

test('recalculates offset at each detail level and includes FY-only income notes', () => {
  const balance = [root(100000, [root(110000, [leaf(111000), leaf(112000)])])]
  const income = [root(300000, [leaf(310000, 0)])]
  const fiscal = [root(300000, [leaf(310000, 10)])]
  assert.deepEqual(serials(buildIncomeExpenditureSections(income, fiscal, balance, balance, { maxDepth: 1, hideZeroBalances: true })), ['02'])
  assert.deepEqual(serials(buildIncomeExpenditureSections(income, fiscal, balance, balance, { maxDepth: 2, hideZeroBalances: true })), ['03'])
  assert.deepEqual(serials(buildIncomeExpenditureSections(income, fiscal, [], [], { hideZeroBalances: true })), ['01'])
})
