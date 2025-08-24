import { defineStore } from 'pinia'
import { useApiClient } from '@/composables/useApiClient'

export const useSettingsStore = defineStore('settings', {
  state: () => ({
    data: {},
    loaded: false,
    loading: false,
    error: null
  }),

  actions: {
    async fetchSettings() {
      if (this.loaded || this.loading) return

      this.loading = true
      const api = useApiClient()

      try {
        const res = await api.get('core/settings', {
          requiresAuth: false
        })

        this.data = res.data || {}
        this.loaded = true
      } catch (err) {
        this.error = err.message || 'Failed to load settings'
      } finally {
        this.loading = false
      }
    },

    reset() {
      this.data = {}
      this.loaded = false
      this.loading = false
      this.error = null
    }
  },

  persist: true
})
