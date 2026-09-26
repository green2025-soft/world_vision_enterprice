import test from 'node:test'
import assert from 'node:assert/strict'
import { cashFlowGroups } from '../src/modules/accounting/utils/cashFlowStatement.js'

test('cash flow retains signed outflows and FY-only activities under zero filtering', () => {
  const report = { current: { groups: { investing: [{ id: 1, code: 110000, amount: -20 }] } }, fiscal: { groups: { investing: [{ id: 1, code: 110000, amount: -30 }], unclassified: [{ id: 2, code: '', amount: 10 }] } } }
  const groups = cashFlowGroups(report, true)
  assert.equal(groups.investing[0].amount, -20)
  assert.equal(groups.investing[0].fiscalAmount, -30)
  assert.equal(groups.unclassified[0].amount, 0)
  assert.equal(groups.unclassified[0].fiscalAmount, 10)
  assert.deepEqual(groups.financing, [])
})
