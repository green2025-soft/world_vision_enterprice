import { useApiClient } from '@/composables/useApiClient'
import { ref, computed, isRef } from 'vue'
import { prepareFormData } from '@/utilities/methods'
import { useBranchStore } from '@/store/branch-store'


export function useResourceApiClient(baseUrl, title = 'Resource', isBranch = false) {
  
  const api = useApiClient()
   const branchStore = useBranchStore()

   const formErrors = ref({})
   const isLoading = ref(false)
   const isSubmitting = ref(false)

  const confirmDeleteModal = ref(null)
  const itemToDeleteId = ref(null)
  const branchId = computed(() => branchStore.selectedBranchId)
  
  

   
  const fullBaseUrl = isBranch ? `${baseUrl}?branch_id=${branchId.value}` : baseUrl

  const getList = async (params = {}) => {
    isLoading.value = true

    
  
    try {
      const res = await api.get(fullBaseUrl, { requiresAuth: true, params, tosterMessage: false })
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
      const res = await api.get(fullBaseUrl, { requiresAuth: true, params, tosterMessage: false })
      return res
    } catch (err) {
      throw err
    } finally {
      isLoading.value = false
    }
  }


  const gePaginationOptions = async (customUrl, params = {}, isCBranchId=true) => {
    isLoading.value = true
    customUrl = isCBranchId?customUrl+`?branch_id=${branchId}`:customUrl
    try {
      const res = await api.get(customUrl, { 
        requiresAuth: true, 
        params, 
        tosterMessage: false 
      })
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


 const create = async (data, $message = '', multipart=false, showNotification=true ) => {
    formErrors.value = {}
    isSubmitting.value = true
    const message = $message==''?`${title} created successfully`:$message
    
      if(isBranch){
        data.branch_id = branchId
      }
    try {
      const res = await api.post(baseUrl, data, {
        showNotification:showNotification,
        notifyOptions: { message: message },
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

const update = async (id, data,  $message = '', showNotification=true) => {
  formErrors.value = {}
  isSubmitting.value = true
  const message = $message==''?`${title}  updated successfully`:$message
   if(isBranch){
      data.branch_id = branchId
    }
  try {
    // If not multipart, use regular PUT
    const res = await api.put(`${baseUrl}/${id}`, data, {
      notifyOptions: { message: message },
      showNotification:showNotification,
      requiresAuth: true
    })
    return res
  } catch (err) {
    if (err.response?.status === 422) {
      formErrors.value = err.response.data.errors
    }
    throw err
  } finally {
    isSubmitting.value = false
  }
}




const updateWithFile = async (id, data, $message = '') => {
  formErrors.value = {}
  isSubmitting.value = true
  const message = $message==''?`${title}  updated successfully`:$message
  let formData = data instanceof FormData ? data : prepareFormData(data)
   try {
  const res = await api.post(`${baseUrl}/${id}`, formData, {
        notifyOptions: { message: message },
        requiresAuth: true,
        multipart: true,
      })
    return res
     } catch (err) {

      if (err.response?.status === 422) {
        formErrors.value = err.response.data.errors
      }
      throw err
    }finally {
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

const customGet = async (customUrl, params = {}, isCBranchId=true ) => {
  isLoading.value = true

  customUrl = isCBranchId?customUrl+`?branch_id=${branchId}`:customUrl
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

const customPost = async (customUrl, data = {}, message=false, isCBranchId=true) => {
  
    if(isCBranchId){
      data.branch_id = isRef(branchId) ? branchId.value : branchId
    }

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
    updateWithFile,
    gePaginationOptions,
    formErrors,
    isLoading,
    isSubmitting,

    confirmDeleteModal,
    askDelete,
    confirmDelete,
  }
}
