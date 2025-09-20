import { createRouter, createWebHistory } from "vue-router";
import NProgress from "nprogress";
import { authenticate } from "../store/authenticate.js";
import { useBranchStore } from '@/store/branch-store'

import coreRoutes from "../modules/core/router";
import inventoryRoutes from "../modules/inventory/router";
import accountingRoutes from "../modules/accounting/router";


// import Logout from "@/views/Logout.vue";
import Login from "@/views/Login.vue";
// import ResetPassword from "@/views/ResetPassword.vue";


const routes = [
  {
    path: "/",
    redirect: "/login"
  },
  // {
  //   path: "/logout",
  //   component: Logout
  // },
  {
    path: "/login",
    component: Login,
     meta: { title: "Login", requiresAuth: false },
  },
  // {
  //   path: "/reset-password",
  //   component: ResetPassword
  // },
  coreRoutes,
  inventoryRoutes,
  accountingRoutes
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

router.beforeEach((to, from, next) => {
  document.title = to.meta.title || "GST ERP";
  NProgress.start();

  const isLoggedIn = authenticate.isAuthenticated
  const needsAuth = to.meta.requiresAuth !== false
  const needsBranch = to.meta.requiresBranch === true

  // Redirect to login if not authenticated
  if (needsAuth && !isLoggedIn) {
    return next("/login");
  }

  // Branch check only after login
  if (needsBranch) {
    const branchStore = useBranchStore()

    if (!branchStore.selectedBranchId) {
      return next("/core/branch-dashboard");
    }
  }

  return next(); // ✅ always call next() once
});


router.afterEach(() => {
  NProgress.done();
});

export default router;
