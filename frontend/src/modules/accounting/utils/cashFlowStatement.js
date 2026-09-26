export function cashFlowGroups(report, hideZeroBalances = false) {
  return Object.fromEntries(['opening', 'operating', 'investing', 'financing', 'unclassified', 'closing'].map(key => {
    const current = new Map((report?.current?.groups[key] || []).map(row => [String(row.id), row]))
    const fiscal = new Map((report?.fiscal?.groups[key] || []).map(row => [String(row.id), row]))
    const rows = [...new Set([...current.keys(), ...fiscal.keys()])].map(id => ({
      ...(current.get(id) || fiscal.get(id)),
      amount: current.get(id)?.amount ?? 0,
      fiscalAmount: fiscal.get(id)?.amount ?? 0,
    })).filter(row => !hideZeroBalances || row.amount !== 0 || row.fiscalAmount !== 0)
      .sort((a, b) => String(a.code).localeCompare(String(b.code), 'en', { numeric: true }))
    return [key, rows]
  }))
}
