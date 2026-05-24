import Index from "./pages/Index.vue";
import Pos from "./pages/sales/Pos.vue";
import Page404 from "@/components/Page404.vue"; // You can replace if module specific 404

 const lazy = (view) => () => import(`@/modules/inventory/pages/${view}.vue`);


const defaultAuth = true;
const defaultMeta = { requiresAuth: defaultAuth };

const makeRoute = (path, component, title, requiresBranch = true) => ({
  path,
  component,
  meta: { title, ...defaultMeta, requiresBranch },
});

const routes = {
  path: "/inventory",
  component: Index,
  redirect: "/inventory/dashboard",
  children: [
   makeRoute("dashboard", lazy("Dashboard"), "Inventory Dashboard"),
   makeRoute("categories", lazy("Category"), "Category"),
   makeRoute("units", lazy("Unit"), "Unit"),
   makeRoute("brands", lazy("Brand"), "Brand"),
   makeRoute("suppliers", lazy("Supplier"), "Supplier"),
   makeRoute("supplier-advance", lazy("SupplierAdvance"), "Supplier Advance"),
   makeRoute("customers", lazy("Customer"), "Customer"),
   makeRoute("customer-advance", lazy("CustomerAdvance"), "Customer Advance"),
   makeRoute("products", lazy("Product"), "Product"),
   makeRoute("product-sets", lazy("ProductSet"), "Product Set"),
  {
    path: "purchases",
    component: () => import('@/modules/inventory/pages/purchase/Index.vue'),
    meta: { title: "Purchase", ...defaultMeta, requiresBranch: true },
  },
  {
    path: "purchases/create",
    component: () => import('@/modules/inventory/pages/purchase/Create.vue'),
    meta: { title: "Create Purchase", ...defaultMeta, requiresBranch: true },
  },
  {
    path: "purchases/:id/edit",
    component: () => import('@/modules/inventory/pages/purchase/Create.vue'),
    meta: { title: "Edit Purchase", ...defaultMeta, requiresBranch: true },
    props: true
  },

  {
    path: "sales",
    component: () => import('@/modules/inventory/pages/sales/Index.vue'),
    meta: { title: "Sales", ...defaultMeta, requiresBranch: true },
  },

  {
    path: "sales/:id",
    component: () => import('@/modules/inventory/pages/sales/view.vue'),
    meta: { title: "Sales Invoice", ...defaultMeta, requiresBranch: true },
    props: true
  },

  {
    path: "sale-return/create",
    component: () => import('@/modules/inventory/pages/sales_return/Create.vue'),
    meta: { title: "Sale Return", ...defaultMeta, requiresBranch: true },
  },

    {
    path: "sale-return",
    component: () => import('@/modules/inventory/pages/sales_return/Index.vue'),
    meta: { title: "Sale Return", ...defaultMeta, requiresBranch: true },
  },



  
   
    // {
    //   path: ":catchAll(.*)",
    //   component: Page404
    // }
  ]
};

const posRoute = {
  path: "/inventory",
  children:[{
     path: "pos",
    component: Pos,
    meta: { title: "POS", ...defaultMeta, requiresBranch: true }
  },
  {
    path: "pos/:id/edit",
    component: Pos,
    meta: { title: "Edit POS", ...defaultMeta, requiresBranch: true }, 
    props: true
  }
]
};



export { posRoute };

export default routes;
