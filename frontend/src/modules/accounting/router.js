import Index from "./pages/Index.vue";
import Page404 from "@/components/Page404.vue"; // You can replace if module specific 404

 const lazy = (view) => () => import(`./pages/${view}.vue`);

const defaultAuth = true;
const defaultMeta = { requiresAuth: defaultAuth };

const makeRoute = (path, component, title, requiresBranch = true) => ({
  path,
  component,
  meta: { title, ...defaultMeta, requiresBranch },
});

const routes = {
  path: "/accounting",
  component: Index,
  redirect: "/accounting/dashboard",
  children: [
   makeRoute("dashboard", lazy("Dashboard"), "Accounting Dashboard"),
   makeRoute("chart-of-accounts", lazy("ChartOfAccount"), "Chart Of Account", false),
   makeRoute("voucher-posting", lazy("VoucherPosting"), "Voucher Posting", false),
   makeRoute("account-modules", lazy("AccountModule"), "Account Module", false),
   makeRoute("balance-sheet", lazy("BalanceSheet"), "Balance Sheet", false),
   makeRoute("income-expenditure", lazy("IncomeExpenditure"), "Income & Expenditure", false),
   makeRoute("trial-balance", lazy("TrialBalance"), "Trial Balance", false),
   makeRoute("cash-flow-statement", lazy("CashFlowStatement"), "Cash Flow Statement", false),
   makeRoute("cash-bank-book", lazy("CashBankBook"), "Cash & Bank Book", false),
   makeRoute("changes-in-equity", lazy("ChangesInEquity"), "Changes in Equity", false),
   makeRoute("ledger-report", lazy("LedgerReport"), "Ledger Report", false),
   makeRoute("receipts-payments", lazy("ReceiptsPayments"), "Receipts & Payments", false),
    {
      path: ":catchAll(.*)",
      component: Page404
    }
  ]
};

export default routes;
