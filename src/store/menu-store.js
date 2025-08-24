import { defineStore } from 'pinia'
import { useApiClient } from '@/composables/useApiClient'

export const useMenuStore = defineStore('menu', {
  state: () => ({
    menus: [],       // module-wise menus
    isLoaded: false, // flag to avoid duplicate fetch
  }),

  actions: {
    async fetchUserMenus() {
      if (this.isLoaded) return

      try {
        const api = useApiClient()
        const res = await api.get('/core/user-menus', {
          requiresAuth: true,
          showNotification: false,
        })

        this.menus = res.data || res
        this.isLoaded = true
      } catch (err) {
        console.error('Failed to load user menus:', err)
      }
    },

    resetMenu() {
      this.menus = []
      this.isLoaded = false
    }
  },

  //  Persist this store
  persist: {
    enabled: true,
    strategies: [
      {
        key: 'user_menu',
        storage: localStorage,
      },
    ],
  },
})
