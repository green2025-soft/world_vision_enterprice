import { useApiClient } from '@/composables/useApiClient'
    import { ref } from 'vue'

export function useResourceApiClient(baseUrl, title = 'Resource') {
  const api = useApiClient()

   const formErrors = ref({})
   const isLoading = ref(false)
   const isSubmitting = ref(false)

  const confirmDeleteModal = ref(null)
  const itemToDeleteId = ref(null)
   

  const getList = async (params = {}) => {
    isLoading.value = true
    try {
      const res = await api.get(baseUrl, { requiresAuth: true, params, tosterMessage: false })
      return res.data
    } catch (err) {
      throw err
    } finally {
      isLoading.value = false
    }
  }


  const gePaginationList = async (params = {}) => {
    isLoading.value = true
    try {
      const res = await api.get(baseUrl, { requiresAuth: true, params, tosterMessage: false })
      return res
    } catch (err) {
      throw err
    } finally {
      isLoading.value = false
    }
  }
    

  const getOne = async (id) => {
    isLoading.value = true
    try {
      const res = await api.get(`${baseUrl}/${id}`, { requiresAuth: true, tosterMessage: false })
      return res.data
    } catch (err) {
      throw err
    } finally {
      isLoading.value = false
    }
  }


 const create = async (data, $message = `${title} created successfully`, multipart=false ) => {
    formErrors.value = {}
    isSubmitting.value = true
    try {
      const res = await api.post(baseUrl, data, {
        notifyOptions: { message: $message },
         requiresAuth: true, 
         multipart:multipart
      })
      return res.data
    } catch (err) {
      if (err.response?.status === 422) {
        formErrors.value = err.response.data.errors
      }
      throw err
    } finally {
      isSubmitting.value = false
    }
  }

  const update = async (id, data, multipart=false) => {
    formErrors.value = {}
    isSubmitting.value = true
    
    try {
      const res = await api.put(`${baseUrl}/${id}`, data, {
        notifyOptions: { message: `${title} updated successfully`},
        requiresAuth: true,
        multipart:multipart
      })
      return res.data
    } catch (err) {
      if (err.response?.status === 422) {
        formErrors.value = err.response.data.errors
      }
      throw err
    } finally {
      isSubmitting.value = false
    }
  }

 const remove = async (id) => {
    isLoading.value = true
    try {
      const res = await api.delete(`${baseUrl}/${id}`, {
        notifyOptions: { message: `${title} deleted successfully` },
         requiresAuth: true,
      })
      return res.data
    } catch (err) {
      throw err
    } finally {
      isLoading.value = false
    }
  }

const customGet = async (customUrl, params = {} ) => {
  isLoading.value = true
  try {
    const res = await api.get(customUrl, {
      requiresAuth: true,
      params,
      tosterMessage: false,
    })
    return res.data
  } catch (err) {
    throw err
  } finally {
    isLoading.value = false
  }
}

const customPost = async (customUrl, data = {}, message=false) => {
  
  
  isLoading.value = true
 const showNotification = message?true:false
  try {
    const res = await api.post(customUrl, data, {
      notifyOptions: { message: message },
      requiresAuth: true,
      tosterMessage: false,
      showNotification:showNotification
    })
    return res.data
  } catch (err) {
    throw err
  } finally {
    isLoading.value = false
  }
}

  // ============================
  //  Confirm Delete Integration
  // ============================
  const askDelete = (id) => {
    itemToDeleteId.value = id
    confirmDeleteModal.value?.show()
  }

  const confirmDelete = async (refreshCallback = null) => {
    if (!itemToDeleteId.value) return
    await remove(itemToDeleteId.value)
    itemToDeleteId.value = null
    if (refreshCallback && typeof refreshCallback === 'function') {
      await refreshCallback()
    }
  }
  

    return {
    getList,
    gePaginationList,
    getOne,
    create,
    update,
    remove,
    customGet,
    customPost,
    formErrors,
    isLoading,
    isSubmitting,

    confirmDeleteModal,
    askDelete,
    confirmDelete,
  }
}
