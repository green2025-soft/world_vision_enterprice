import { createRouter, createWebHistory } from "vue-router";
import NProgress from "nprogress";
import { authenticate } from "../store/authenticate.js";
import coreRoutes from "../modules/core/router";
import { useBranchStore } from '@/store/branch-store'


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
  coreRoutes
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

router.beforeEach((to, from, next) => {
  document.title = to.meta.title || "GST ERP";
  NProgress.start();

  const isLoggedIn = authenticate.isAuthenticated
  if (to.meta.requiresAuth && !isLoggedIn) {
    next("login");
  }

  const branchStore = useBranchStore()
  const needsBranch = to.meta.requiresBranch === true
  console.log('Branch '+branchStore.selectedBranchId);
  

  if (needsBranch && !branchStore.selectedBranchId) {
    return next("/core/branch-dashboard")
  }
  next()
});

router.afterEach(() => {
  NProgress.done();
});

export default router;
