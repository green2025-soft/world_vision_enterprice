import axios from 'axios'
import { toast } from 'vue3-toastify'
import { authenticate } from '@/store/authenticate'
import { useCommonStore } from '@/store/common-store'

export function useApiClient(isExternal = false) {
  const commonStore = useCommonStore()
  const accessToken = authenticate.getJwtToken()
  const authorization = authenticate.getAuthorization()

  
  

  // Axios Instance
  const axiosInstance = axios.create({
    baseURL: isExternal ? undefined : import.meta.env.VITE_VUE_APP_API_URL,
    headers: {
      Accept: 'application/json',
    },
  })

  // Config flags per request
  let configState = {
    selector: false,
    preloader: '<i class="fas fa-spinner fa-spin axiosSpinner"></i>',
    showNotification: true,
    tosterMessage: true,
    notifyOptions: false,
    triggerLogoutIfUnauthorized: true,
  }

  // Interceptors
  axiosInstance.interceptors.request.use(handleRequestSuccess, handleRequestError)
  axiosInstance.interceptors.response.use(handleResponseSuccess, handleResponseError)

  // Request Success Handler
  function handleRequestSuccess(request) {
    configState = {
      ...configState,
      selector: request.selector || false,
      showNotification: request.showNotification !== false,
      tosterMessage: request.tosterMessage !== false,
      notifyOptions: request.notifyOptions || false,
      triggerLogoutIfUnauthorized: request.requiresAuth !== false,
    }

    // Auth headers
    if (request.requiresAuth && accessToken) {
      request.headers = {
        ...request.headers,
        Authorization: authorization,
        currentusercontext: accessToken,
        // 'Content-Type': 'multipart/form-data'
        
      }
    }

  // ✅ Handle multipart based on custom param
  if (request.multipart === true) {
    request.headers = {
      ...request.headers,
      'Content-Type': 'multipart/form-data'
    }
  }

    // Unauthorized fallback
    if (!accessToken && request.requiresAuth) {
      const CancelToken = axios.CancelToken
      return {
        ...request,
        cancelToken: new CancelToken(cancel => cancel('Cancelled unauthorized request')),
      }
    }

    // Loading state
    if (request.loading !== false) {
      if (['get', 'post', 'put'].includes(request.method)) {
        commonStore.setLoading(true, configState.selector, configState.preloader)
      }
    }

    return request
  }

  // Request Error
  function handleRequestError(error) {
    commonStore.setLoading(false, configState.selector, configState.preloader)
    return Promise.reject(error)
  }

  // Response Success
  function handleResponseSuccess(response) {
    commonStore.setLoading(false, configState.selector, configState.preloader)

    const method = response.config.method
    const data = response.data

    if (configState.showNotification) {
      const msg = configState.notifyOptions?.message
      if (method === 'post') toast.success(msg || 'Created')
      else if (method === 'put') toast.success(msg || 'Updated')
      else if (method === 'delete') toast.success(msg || 'Deleted')
      else if (msg && method === 'get') toast.success(msg)
    }

    // Pagination-aware response
    const isPaginated = data && data.meta && data.data
    if (isPaginated) {
      return {
        items: data.data,
        pagination: {
          page: data.meta.current_page,
          lastPage: data.meta.last_page,
          perPage: data.meta.per_page,
          total: data.meta.total,
          links: data.links,
        },
      }
    }

    return data
  }

  // Response Error
  function handleResponseError(error) {
    commonStore.setLoading(false, configState.selector, configState.preloader)

    if (axios.isCancel(error)) return Promise.reject(error)

    const { message, unauthorized } = parseError(error)

    if (unauthorized && configState.triggerLogoutIfUnauthorized) {
      authenticate.logOutUser?.() // optional chaining
    } else {
      commonStore.renderAlertDialog({ message })
    }

    return Promise.reject(error)
  }

  // Error Formatter
  function parseError(error) {
    let unauthorized = false
    let message = 'An unexpected error occurred.'

    if (error.response) {
      const status = error.response.status
      unauthorized = status === 401
      message =
        error.response?.data?.message ||
        `${error.response.statusText || 'Error'} (status ${status})`
    } else if (error.message) {
      message = error.message
    }

    if (configState.tosterMessage && message) {
      toast.error(message)
    }

    return { message, unauthorized }
  }

  return axiosInstance
}
