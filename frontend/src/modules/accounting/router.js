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
    {
      path: ":catchAll(.*)",
      component: Page404
    }
  ]
};

export default routes;
