import axios from "axios";
import { toast } from "vue3-toastify";
import { authenticate } from "../store/authenticate";
import { useCommonStore } from "../store/common-store";

/*
external api call change option `client(null, true)`
const response = await client(null, true).get(
  "https:example.com"
);
*/

export default function client(
  serviceName = import.meta.env.VITE_VUE_APP_API_URL,
  isExternal = false
) {
  const accessToken = authenticate.getUserToken();
  const authorization = authenticate.getAuthorization();
  const commonStore = useCommonStore();
  const isLocalErrorHandling = "";
  let showNotification = true;
  let preloader = '<i class="fas fa-spinner fa-spin axiosSpinner"></i>';
  let selector = false;
  let notifyOptions = false;
  let tosterMessage = true;
  let triggerLogoutIfUnauthorized = true;
  const options = {
    baseURL: isExternal ? undefined : serviceName,
    headers: {
      Accept: "application/json",
    },
  };
  const axiosInstance = axios.create(options);

  axiosInstance.interceptors.request.use(
    handleRequestSuccess,
    handleRequestError
  );
  axiosInstance.interceptors.response.use(
    handleResponseSuccess,
    handleResponseError
  );

  function handleRequestSuccess(request) {
    if (request.selector) selector = request.selector;
    if (request.tosterMessage === false) tosterMessage = false;
    // if (request.preloader) preloader = request.preloader
    if (request.showNotification === false) showNotification = false;
    if (request.notifyOptions) notifyOptions = request.notifyOptions;
    if (request.requiresAuth === false) triggerLogoutIfUnauthorized = false;
    // Conditional headers based on requiresAuth
    if (request.requiresAuth && accessToken && accessToken !== "false") {
      request.headers = {
        ...request.headers,
        Authorization: authorization,
        currentusercontext: accessToken,
      };
    }
    if (!accessToken && request.requiresAuth) {
      const CancelToken = axios.CancelToken;
      return {
        ...request,
        cancelToken: new CancelToken((cancel) =>
          cancel("Cancelled unauthorized request")
        ),
      };
    }

    if (request.loading === false) return request;

    if (request.method === "get") {
      commonStore.setFetching(true, selector, preloader);
    } else if (request.method === "post") {
      commonStore.setLoading(true, selector, preloader);
    } else if (request.method === "put") {
      commonStore.setLoading(true, selector, preloader);
    }

    setLoading(true, selector, preloader);
    return request;
  }

  function handleRequestError(error) {
    setLoading(false, selector, preloader);
    commonStore.setLoading(false, selector, preloader);
    return Promise.reject(error);
  }

  function handleResponseSuccess(response) {
    // commonStore.setLoading(false, selector, preloader);
    setLoading(false, selector, preloader);

    if (showNotification) {
      if (response.config.method === "post") {
        toast.success(notifyOptions ? notifyOptions.message : "Created");
      } else if (response.config.method === "put") {
        toast.success(notifyOptions ? notifyOptions.message : "Updated");
      } else if (response.config.method === "delete") {
        toast.success(notifyOptions ? notifyOptions.message : "Deleted");
      } else if (notifyOptions && response.config.method === "get") {
        toast.success(notifyOptions.message);
      }
    }

    return response;
  }

  function handleResponseError(error, res) {
    // commonStore.setLoading(false, );
    if (isLocalErrorHandling || axios.isCancel(error))
      return Promise.reject(error);
    setLoading(false, selector, preloader);
    // Assuming errorHandler is defined elsewhere
    const { message, unauthorized } = errorHandler(error, tosterMessage);

    if (unauthorized && triggerLogoutIfUnauthorized) authStore.logOutUser();
    else if (!unauthorized) commonStore.renderAlertDialog({ message });

    return Promise.reject(error);
  }

  function errorHandler(error, tosterMessage = "") {
    let message = null;
    let unauthorized = false;

    if (error.response) {
      const errStatus = error.response.status || 500;
      unauthorized = errStatus === 401;
      const errFields = error.response.data;
      message = `
        <p class="text-weight-medium q-my-none text-grey-10">
          ${error.response.statusText || "Error"} with status code ${errStatus}.
        </p>
        <p class="q-my-none">
          ${errFields?.message || "No additional information."}
        </p>
      `;
    } else if (error.message) {
      message = `${error.message}. Please check your internet connection.`;
    } else if (error.request) {
      message = "No response received.";
    } else {
      message = "An unexpected error occurred.";
    }

    let errorMessage = error.response?.data?.message ?? error.message;

    if (showNotification && errorMessage) {
      if (Array.isArray(errorMessage)) {
        errorMessage = errorMessage.join(", ");
      }
      if (tosterMessage) {
        toast.error(errorMessage);
      }
    }
    return { errorMessage, unauthorized };
  }

  return axiosInstance;
}

function setLoading(payload = true, selector, preloader) {
  document.querySelectorAll(".axiosSpinner").forEach((el) => el.remove());
  const targetElement = document.querySelector(selector);
  const target = targetElement ? targetElement.innerHTML : "";
  if (selector && payload) {
    if (targetElement) {
      targetElement.disabled = true;
      targetElement.innerHTML = `${preloader} ${target}`;
    }
  } else {
    if (targetElement) {
      targetElement.disabled = false;
    }
  }
}
