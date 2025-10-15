import Index from "./pages/Index.vue";
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
   makeRoute("products", lazy("Product"), "Product"),
   makeRoute("product-sets", lazy("ProductSet"), "Product Set"),
  {
    path: "purchase",
    component: () => import('@/modules/inventory/pages/purchase/Index.vue'),
    meta: { title: "Purchase", ...defaultMeta, requiresBranch: true },
  },
  {
    path: "purchase/create",
    component: () => import('@/modules/inventory/pages/purchase/Create.vue'),
    meta: { title: "Create Purchase", ...defaultMeta, requiresBranch: true },
  },



  
   
    {
      path: ":catchAll(.*)",
      component: Page404
    }
  ]
};

export default routes;
