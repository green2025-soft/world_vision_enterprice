import { createRouter, createWebHistory } from "vue-router";
import NProgress from "nprogress";
import { authenticate } from "../store/authenticate.js";
import coreRoutes from "../modules/core/router";


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

  if (to.meta.requiresAuth && !authenticate.isAuthenticated) {
    next("login");
  } else {
    next();
  }
});

router.afterEach(() => {
  NProgress.done();
});

export default router;
