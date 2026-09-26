import test from 'node:test'
import assert from 'node:assert/strict'
import { receiptsPaymentsGroups } from '../src/modules/accounting/utils/receiptsPayments.js'

test('receipt columns align accounts and retain FY-only movement when hiding zeros', () => {
  const row = (id, amount) => ({ id, code: id, name: `Account ${id}`, amount })
  const report = { current: { groups: { receipts: [row(2, 0), row(3, 15)] } }, fiscal: { groups: { receipts: [row(2, 20), row(3, 25), row(4, 0)] } } }
  const groups = receiptsPaymentsGroups(report, true)
  assert.deepEqual(groups.receipts.map(row => [row.id, row.amount, row.fiscalAmount]), [[2, 0, 20], [3, 15, 25]])
  assert.deepEqual(groups.opening, [])
})
