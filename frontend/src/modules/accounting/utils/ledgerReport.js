export const ledgerLevels = [
  { key: 'account_type_id', label: 'Accounts Type' },
  { key: 'account_category_id', label: 'Accounts Category' },
  { key: 'control_group_id', label: 'Control Group' },
  { key: 'ledger_group_id', label: 'General Ledger', optional: true },
  { key: 'ledger_account_id', label: 'Ledger Account', optional: true },
]

export function ledgerOptions(accounts, filters, index) {
  const parent = index ? Number(filters[ledgerLevels[index - 1].key]) : null
  if (index && !parent) return []
  return accounts.filter(account => index ? Number(account.parent_id) === parent : account.parent_id == null)
}

export function resetLedgerChildren(filters, index) {
  ledgerLevels.slice(index + 1).forEach(level => { filters[level.key] = '' })
}
