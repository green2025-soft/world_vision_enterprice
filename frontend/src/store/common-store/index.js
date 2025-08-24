import { defineStore } from 'pinia'
// import { PAGE_TITLE } from 'src/AppConstants'
import actions from './actions'

export const useCommonStore = defineStore('common', {
  state: () => ({
    backButton: null,
    localErrorHandling: false,
    headerAction: null,
    helpAction: false,
    reRenderKey: 1,
    loading: true,
    fetching: false
  }),
  getters: {
    isLocalErrorHandling: (state) => state.localErrorHandling,
    gLoading: (state) => state.loading
  },
  actions
})
