export const trialBalanceFields = ['opening_debit', 'opening_credit', 'period_debit', 'period_credit', 'closing_debit', 'closing_credit']

export function trialBalanceRows(accounts, { maxDepth = 2, hideZeroBalances = false } = {}) {
  const rows = []
  const depth = Math.max(1, Math.min(4, Number(maxDepth) || 2))
  const visible = node => !hideZeroBalances || trialBalanceFields.some(field => Number(node[field]) !== 0)
    || (node.children || []).some(visible)
  function append(node, level) {
    if (!visible(node)) return
    const children = (node.children || []).filter(visible)
    if (children.length && level < depth) {
      if (level > 0) rows.push({ ...node, level, kind: 'heading' })
      children.forEach(child => append(child, level + 1))
      rows.push({ ...node, level, kind: level === 0 ? 'root-total' : 'subtotal' })
    } else {
      rows.push({ ...node, level, kind: level === 0 ? 'root-total' : 'account' })
    }
  }
  ;(accounts || []).forEach(root => append(root, 0))
  return rows
}
