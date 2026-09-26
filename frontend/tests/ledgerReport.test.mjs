import test from 'node:test'
import assert from 'node:assert/strict'
import { ledgerOptions, resetLedgerChildren } from '../src/modules/accounting/utils/ledgerReport.js'

test('ledger filter options follow parents and reset stale descendants', () => {
  const accounts = [{ id: 1, parent_id: null }, { id: 2, parent_id: null }, { id: 3, parent_id: 1 }, { id: 4, parent_id: 2 }]
  const filters = { account_type_id: 1, account_category_id: 3, control_group_id: 5, ledger_group_id: 6, ledger_account_id: 7, branchId: 2 }
  assert.deepEqual(ledgerOptions(accounts, filters, 0).map(row => row.id), [1, 2])
  assert.deepEqual(ledgerOptions(accounts, filters, 1).map(row => row.id), [3])
  resetLedgerChildren(filters, 0)
  assert.equal(filters.account_category_id, '')
  assert.equal(filters.ledger_account_id, '')
  assert.equal(filters.branchId, 2)
  assert.deepEqual(ledgerOptions(accounts, filters, 2), [])
})
