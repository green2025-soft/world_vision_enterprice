import {  ref,  onBeforeMount } from "vue";
import { defineStore } from "pinia";
import { updatePrivateHeaders } from "@/services/axiosInstance";

// import actions from "./actions";
// import { STORAGE_KEY } from "src/AppConstants";

// export const useAuthStore = defineStore('auth', {
//   state: () => ({
//     userAuthInfo: {},
//     permissions: [],
//     roles: []
//   }),
//   getters: {
//     apiToken: (state) => state.userAuthInfo && state.userAuthInfo.access_token,
//     hasPermission: (state) => permissions => permissions?.some(permission => state.permissions.includes(permission))
//   },
//   actions,
//   persist: {
//     key: `${STORAGE_KEY}_auth`,
//     paths: ['userAuthInfo', 'permissions', 'roles']
//   }
// })

export const useAuthStore = defineStore("auth", () => {
  const auth = ref(0);
  const user = ref({});
  const jwtToken = ref("");
  const privilege = ref([]);
  const tokenRefreshedAt = ref(0);

  onBeforeMount(() => {
    refreshStore();
  });

  function resetStore() {
    auth.value = 0;
    user.value = {};
    jwtToken.value = "";
    privilege.value = [];
    tokenRefreshedAt.value = 0;
  }

  function refreshStore() {
    auth.value = localStorage.getItem("auth") || "0";
    user.value = JSON.parse(localStorage.getItem("user") || "{}");
    jwtToken.value = localStorage.getItem("jwtToken") || "";
    privilege.value = JSON.parse(localStorage.getItem("privilege") || "[]");
    tokenRefreshedAt.value = localStorage.getItem("tokenRefreshedAt") || 0;
  }



  function login(data) {
    
    
    
    localStorage.setItem("auth", 1);
    localStorage.setItem("user", JSON.stringify(data.user));
    // localStorage.setItem("jwtToken", jwtToken);
    localStorage.setItem("privilege", '');
    localStorage.setItem("tokenRefreshedAt", Date.now());
    // authenticate.isError = false;
    refreshStore();
    // updatePrivateHeaders();
  }

  function refreshToken(token) {
    const currentTime = Date.now();
    localStorage.setItem("jwtToken", token);
    localStorage.setItem("tokenRefreshedAt", currentTime);
    tokenRefreshedAt.value = currentTime;
    updatePrivateHeaders();
  }

  function logout() {
    // authenticate.isAuthenticated = false;
    localStorage.setItem("auth", 0);
    localStorage.setItem("user", "{}");
    localStorage.setItem("jwtToken", Boolean(false));
    localStorage.setItem("privilege", Boolean(false));
    localStorage.setItem("tokenRefreshedAt", 0);
    resetStore();
    // router.push("/login");
  }

  return {
    login,
    logout,
    refreshToken,
    auth,
    user,
    jwtToken,
    privilege
  };
});
