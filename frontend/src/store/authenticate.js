
import { reactive, ref } from "vue";
import router from "@/router/route";
import client from "@/services/mainService";
import { useAuthStore } from "./auth-store";
import { showErrorMessage } from "@/utilities/methods";

import { useApiClient } from '@/composables/useApiClient'
import { useMenuStore } from '@/store/menu-store'

const authenticate = reactive({
  isAuthenticated: localStorage.getItem("auth") == 1,
  isError: false,


  async authenticate(userName, password) {
    try {
      const response = await client().post(
        "core/login",
        { email: userName, password },
        {
          requiresAuth: false,
          selector: "#submit",
          showNotification: false
        }
      );
      const data = response.data;

      // console.log(data);

      // if (data.isAuthorized) {
      const user = data;

      authenticate.isAuthenticated = true;

      // localStorage.setItem("auth", 1);
      // localStorage.setItem(
      //   "user",
      //   JSON.stringify({ ...user, privilege: data.privilege })
      // );
      // localStorage.setItem("userToken", userToken);

      const jwtToken = data.data.token
      
      localStorage.setItem("jwtToken", jwtToken);
      // localStorage.setItem("privilege", data.privilege);
      const authStore = useAuthStore();

      authStore.login({
        user: { ...user },
        auth: 1,
        // userToken,
        jwtToken: jwtToken
        // privilege: data.privilege
      });

      authenticate.isError = false;

      router.push("core/branch-dashboard");
    } catch (errors) {

  
      showErrorMessage(errors);
      return errors.response.status;
    }
  },

  // user logout
  async logout() {
    const menuStore = useMenuStore()
  
     try {
        const api = useApiClient()
      await api.post("core/logout", null, {
        requiresAuth: true, 
      });
      const authStore = useAuthStore();
      authenticate.isAuthenticated = false;
      authStore.logout();
      menuStore.resetMenu()
      router.push("/login");
     }catch (errors) {
   
      
     }

  },

  getUserToken() {
    return localStorage.getItem("userToken") ?? false;
  },

  getJwtToken() {
    return localStorage.getItem("jwtToken") ?? false;
  },
  getAuthorization() {
    const jwtToken = this.getJwtToken();
    if (jwtToken && jwtToken != "false") {
      return `Bearer ${jwtToken}`;
    }
    return false;
  },

  getUser() {
    const userString = localStorage.getItem("user");
    return JSON.parse(userString);
  },
  checkLoginStatus() {
    return (
      localStorage.getItem("auth") == 1 &&
      Date.now() - parseInt(localStorage.getItem("tokenRefreshedAt")) <
        1000 * 60 * 30
    );
  }
});

export { authenticate };
