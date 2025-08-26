// @/stores/branch-store.js
import { defineStore } from 'pinia'

export const useBranchStore = defineStore('branch', {
  state: () => ({
    selectedBranchId: null
  }),
  actions: {
    setBranchId(id, data = {}) {
    this.selectedBranchId = id
    this.branch = data?.name ?? ''
    this.logo = data?.logo ?? ''
    this.contact_no = data?.contact_no ?? ''
    },
    clearBranchId() {
      this.selectedBranchId = null,
      this.branch = null,
      this.logo = null,
      this.contact_no = null
    }
  },
  persist: true // 🟢 Make it persisted (localStorage)
})
