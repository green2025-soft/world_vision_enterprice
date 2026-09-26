const amountFormatter = new Intl.NumberFormat('en-BD', {
  minimumFractionDigits: 2,
  maximumFractionDigits: 2,
})

// API amounts can be decimal strings. Round each amount to cents before arithmetic.
function toCents(value) {
  const amount = Number(value)
  if (!Number.isFinite(amount)) return 0

  const decimal = String(value ?? 0).trim().match(/^([+-]?)(\d+)(?:\.(\d*))?$/)
  if (!decimal) return Math.round(Math.abs(amount) * 100) * (amount < 0 ? -1 : 1)

  const fraction = decimal[3] ?? ''
  const cents = Number(decimal[2]) * 100
    + Number(fraction.padEnd(2, '0').slice(0, 2))
    + (Number(fraction[2] ?? 0) >= 5 ? 1 : 0)

  return cents === 0 ? 0 : cents * (decimal[1] === '-' ? -1 : 1)
}

function sortedAccounts(accounts) {
  return [...(Array.isArray(accounts) ? accounts : [])].sort((left, right) =>
    Number(Boolean(left.is_report_adjustment)) - Number(Boolean(right.is_report_adjustment))
      || String(left.code ?? '').localeCompare(String(right.code ?? ''), 'en', { numeric: true }),
  )
}

function isDebitRoot(root) {
  return (root.root_type ?? root.type) === 'asset'
    || [true, 1, '1', 'true'].includes(root.is_debit)
}

function normalizeAccount(account, debitRoot) {
  const debit = toCents(account.total_debit)
  const credit = toCents(account.total_credit)
  const balance = debitRoot ? debit - credit : credit - debit
  const children = sortedAccounts(account.children).map(child => normalizeAccount(child, debitRoot))

  return {
    id: account.id,
    code: account.code,
    name: account.name,
    balance: balance / 100,
    totalDebit: debit / 100,
    totalCredit: credit / 100,
    earnings: account.earnings ?? null,
    isReportAdjustment: Boolean(account.is_report_adjustment),
    children,
    hasNonzeroBalance: balance !== 0 || children.some(child => child.hasNonzeroBalance),
  }
}

/**
 * Keep API totals at their own level: descendants already belong to their root total.
 * Use the root's normal balance for every row so contra accounts appear as deductions.
 */
export function buildBalanceSheetSections(coa, { maxDepth = 2, hideZeroBalances = false } = {}) {
  const depthLimit = Math.min(4, Math.max(1, Number(maxDepth) || 2))

  return sortedAccounts(coa).map(root => {
    const normalizedRoot = normalizeAccount(root, isDebitRoot(root))
    const rows = []

    function appendRows(accounts, depth) {
      for (const account of accounts) {
        if (hideZeroBalances && !account.hasNonzeroBalance) continue

        rows.push({
          id: account.id,
          code: account.code,
          name: account.name,
          depth,
          balance: account.balance,
          totalDebit: account.totalDebit,
          totalCredit: account.totalCredit,
          hasChildren: account.children.length > 0,
          earnings: account.earnings,
          isReportAdjustment: account.isReportAdjustment,
        })

        if (depth < depthLimit) appendRows(account.children, depth + 1)
      }
    }

    appendRows(normalizedRoot.children, 1)

    return {
      id: normalizedRoot.id,
      code: normalizedRoot.code,
      name: normalizedRoot.name,
      balance: normalizedRoot.balance,
      totalDebit: normalizedRoot.totalDebit,
      totalCredit: normalizedRoot.totalCredit,
      earnings: normalizedRoot.earnings,
      rows,
    }
  })
}

// Align both periods by account ID, retaining accounts that only exist in one period.
export function buildComparativeBalanceSheetSections(currentCoa, comparisonCoa, { maxDepth = 2, hideZeroBalances = false } = {}) {
  function alignAccounts(primary = [], secondary = []) {
    const primaryById = new Map(primary.map(account => [String(account.id), account]))
    const secondaryById = new Map(secondary.map(account => [String(account.id), account]))
    return [...new Set([...primaryById.keys(), ...secondaryById.keys()])].map(id => {
      const current = primaryById.get(id)
      const other = secondaryById.get(id)
      return {
        ...other, ...current,
        total_debit: current?.total_debit ?? 0,
        total_credit: current?.total_credit ?? 0,
        earnings: current?.earnings ?? null,
        children: alignAccounts(current?.children || [], other?.children || []),
      }
    })
  }

  const current = buildBalanceSheetSections(alignAccounts(currentCoa || [], comparisonCoa || []), { maxDepth: 4 })
  const previous = new Map(buildBalanceSheetSections(alignAccounts(comparisonCoa || [], currentCoa || []), { maxDepth: 4 })
    .map(section => [String(section.id), section]))
  let noteNumber = 0

  return current.map(section => {
    const comparison = previous.get(String(section.id))
    const comparisonRows = new Map(comparison.rows.map(row => [String(row.id), row]))
    const rows = section.rows.map(row => ({
      ...row,
      comparisonBalance: comparisonRows.get(String(row.id))?.balance ?? 0,
      comparisonDebit: comparisonRows.get(String(row.id))?.totalDebit ?? 0,
      comparisonCredit: comparisonRows.get(String(row.id))?.totalCredit ?? 0,
      comparisonEarnings: comparisonRows.get(String(row.id))?.earnings ?? null,
      note: !row.isReportAdjustment && row.depth <= Number(maxDepth) && (row.earnings || row.depth === Number(maxDepth) || !row.hasChildren)
        ? String(++noteNumber).padStart(2, '0') : '',
    }))
    return {
      ...section,
      comparisonBalance: comparison.balance,
      comparisonDebit: comparison.totalDebit,
      comparisonCredit: comparison.totalCredit,
      comparisonEarnings: comparison.earnings,
      rows: rows.filter((row, index) => {
        if (row.depth > Number(maxDepth)) return false
        if (!hideZeroBalances || row.balance !== 0 || row.comparisonBalance !== 0) return true
        for (let child = index + 1; child < rows.length && rows[child].depth > row.depth; child++) {
          if (rows[child].balance !== 0 || rows[child].comparisonBalance !== 0) return true
        }
        return false
      }),
    }
  })
}

// The July-June financial year compares against the closing balance before July 1.
export function fiscalYearComparisonMonth(month) {
  if (!/^\d{4}-(0[1-9]|1[0-2])$/.test(month || '')) return ''
  const [year, selectedMonth] = month.split('-').map(Number)
  return `${selectedMonth >= 7 ? year : year - 1}-06`
}

export function findAccountPath(accounts, accountId) {
  for (const account of accounts || []) {
    if (String(account.id) === String(accountId)) return [account]
    const childPath = findAccountPath(account.children, accountId)
    if (childPath.length) return [account, ...childPath]
  }
  return []
}

export function buildBalanceSheetNote(currentCoa, comparisonCoa, accountId) {
  const currentPath = findAccountPath(currentCoa, accountId)
  const previousPath = findAccountPath(comparisonCoa, accountId)
  if (!currentPath.length && !previousPath.length) return null
  const root = currentPath[0] || previousPath[0]
  const forSection = path => path.length ? [{
    ...path.at(-1), is_debit: isDebitRoot(root), root_type: root.root_type ?? root.type,
  }] : []
  return {
    ...buildComparativeBalanceSheetSections(forSection(currentPath), forSection(previousPath), { maxDepth: 4 })[0],
    path: (currentPath.length ? currentPath : previousPath).map(account => account.name),
  }
}

export function formatBalanceAmount(value) {
  const cents = toCents(value)
  const formatted = amountFormatter.format(Math.abs(cents) / 100)
  return cents < 0 ? `(${formatted})` : formatted
}
