import { createApp } from "vue";
import { createPinia } from "pinia";

import Vue3Toastify from "vue3-toastify";
import { createBootstrap } from "bootstrap-vue-next";
import GlobalComponents from "@/plugins/globalComponents.js";
import { updatePrivateHeaders } from "./services/axiosInstance";
import piniaPersistedstate from 'pinia-plugin-persistedstate'

import "bootstrap/dist/css/bootstrap.css";
import 'bootstrap/dist/js/bootstrap.bundle.min.js'

import "vue3-toastify/dist/index.css";
import "nprogress/nprogress.js";
import "nprogress/nprogress.css";
// import "@vuepic/vue-datepicker/dist/main.css";
// import "select2/dist/css/select2.min.css";
// import "select2";

// import "./assets/main.css";

import "bootstrap-vue-next/dist/bootstrap-vue-next.css";

import App from "./App.vue";
import router from "./router/route";
import { authenticate } from "./store/authenticate";
import authService from "./services/auth";

updatePrivateHeaders();

const app = createApp(App);
const pinia = createPinia();
pinia.use(piniaPersistedstate)

app.use(createBootstrap());
app.use(GlobalComponents);

app.use(router);

app.use(pinia);
app.use(Vue3Toastify, {
  theme: "colored"
});


app.mount("#app");



window.onafterprint = function () {
  const appEl = document.getElementById("app");
  const printEl = document.getElementById("print-el");

  appEl.style.display = "block";
  printEl.style.display = "none";
};

// setInterval(() => {
//   if (authenticate.checkLoginStatus()) {
//     // console.log("refreshing token...");

//     const currentToken = localStorage.getItem("jwtToken");

//     authService
//       .refreshToken(currentToken)
//       .then((res) => {
//         // console.log(res.data);
//         localStorage.setItem("jwtToken", res.data.authToken);
//         updatePrivateHeaders();
//         localStorage.setItem("tokenRefreshedAt", Date.now());
//       })
//       .catch((e) => {
//         // console.log(e);
//       })
//       .finally();
//   }
// }, 300000);

