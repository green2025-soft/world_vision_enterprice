import test from 'node:test'
import assert from 'node:assert/strict'
import { trialBalanceRows, trialBalanceFields } from '../src/modules/accounting/utils/trialBalance.js'

const node = (id, children = [], value = 10) => ({ id, children, ...Object.fromEntries(trialBalanceFields.map(field => [field, value])) })
test('trial balance displays group subtotal and root total once in sample order', () => {
  const rows = trialBalanceRows([node(1, [node(2, [node(3), node(4)])])])
  assert.deepEqual(rows.map(row => [row.id, row.kind]), [[2, 'heading'], [3, 'account'], [4, 'account'], [2, 'subtotal'], [1, 'root-total']])
  assert.equal(rows.at(-1).closing_debit, 10)
})
test('depth and zero filters retain period activity even when closing is zero', () => {
  const moving = { ...node(3, [], 0), period_debit: 50, period_credit: 50 }
  const tree = [node(1, [node(2, [moving, node(4, [], 0)])])]
  assert.deepEqual(trialBalanceRows(tree, { maxDepth: 1 }).map(row => row.id), [2, 1])
  assert.deepEqual(trialBalanceRows(tree, { hideZeroBalances: true }).map(row => row.id), [2, 3, 2, 1])
  assert.deepEqual(trialBalanceRows([node(1, [], 0)], { hideZeroBalances: true }), [])
})
