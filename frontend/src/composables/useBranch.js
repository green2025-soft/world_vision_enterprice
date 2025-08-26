import { useBranchStore } from '@/store/branch-store'

export function useBranch() {
  const store = useBranchStore()
  return {
    branchId: store.selectedBranchId,
    branch: store.branch,
    logo: store.logo,
    contact_no: store.contact_no
  }
}