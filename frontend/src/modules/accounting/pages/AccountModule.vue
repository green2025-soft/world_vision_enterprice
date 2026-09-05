<script setup>
import { ref, onMounted } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm, dbDataFormat } from '@/utilities/methods'



// Setup
const title = 'Account Module'
const bUrl = 'accounting/account-modules'

const {
  update,
  getOne,
  create,
  confirmDelete,
  customGet,
  confirmDeleteModal,
  gePaginationOptions,
  formErrors,
  isSubmitting,
} = useResourceApiClient(bUrl, title, true)

const isEdit = ref(false)
const showModal = ref(false)
const dataTableRef = ref(null)
const errors = ref([])

// Form Setup
const { form, reset } = useForm({
  module_name: '',
  feature:'',
  entry_type: '',
  description: '',
  status:1,
  components:[],
  accounts: [
    { account_head_id: null, component: '', description: '', is_debit:false }
  ]
})

// Modal open for create/edit
async function openModal(item) {
  errors.value = []
  reset()
  const resData = await  customGet('accounting/account-modules/'+item.feature)
  form.value = {
    module_name: resData.name,
    entry_type: resData.entry_type,
    feature: resData.feature,
    feature_key: resData.feature,
    module_key: resData.module_key,

      accounts: (resData.components ?? []).map(component => ({
      ...component,
      component:component.key,
      account_head_id: component.account_head_id ?? null
    }))
  }
  // // form.value.accounts = 
  if(resData.account){
   isEdit.value = true 
   form.value.id = resData.account.id
  }else{
    isEdit.value = false
  }



  showModal.value = true
}

// Add/Remove Lines
function addAccount() {
  form.value.accounts.push({
    component: '',
    account_head_id: null,
    is_debit: false,
    description: '',
  })
}

function removeAccount(index) {
  if (form.value.accounts.length > 1) {
    form.value.accounts.splice(index, 1)
  }
}






// Validate before submit
async function saveItem() {
  // if (totalDebit.value !== totalCredit.value) {
  //   errors.value = ['Total Debit and Credit must be equal.']
  //   return
  // }



  try {
    form.value.date = dbDataFormat(form.value.date)
    if (form.value.id) {
      await update(form.value.id, form.value)
    } else {
      await create(form.value)
    }

    await dataTableRef.value?.refresh()
    reset()
    showModal.value = false
  } catch (error) {
    errors.value = formErrors.value
  }
}


const viewOpenModal = ref(false)
const viewItem = ref(null)
const isLoading = ref(false)

// Function to open modal & load data
async function openViewModal(id) {
  isLoading.value = true
  try {
    const data = await getOne(id)
    viewItem.value = data
    viewOpenModal.value = true
  } catch (err) {
    console.error('Failed to load item', err)
  } finally {
    isLoading.value = false
  }
}


let accountHeads = ref([]);
onMounted(async () => {
  accountHeads.value = await customGet('accounting/account-heads');
})

</script>

<template>
  <!-- Confirm Delete Modal -->
  <ConfirmDelete
    ref="confirmDeleteModal"
    @confirm="() => confirmDelete(() => dataTableRef.refresh())"
  />

  <!-- Main Table -->
  <div class="container-fluid">
    <div class="">
      <div class="card card-outline card-info">
        <div class="card-header d-flex justify-content-between align-items-center">
          <h2 class="card-title"><i class="fas fa-box"></i> {{ title }}</h2>
       
        </div>

        <div class="card-body table-responsive">
          <DataTable
            ref="dataTableRef"
            :fields="[
              { key: 'sl', label: 'SL' },
              { key: 'feature', label: 'feature' },
              { key: 'entry_type', label: 'Voucher Type' },
              { key: 'name', label: 'Narration' },
              { key: 'accountHeads', label: 'Accounts', isChange: true, align: 'center'},
              { key: 'status', label: 'Status', isChange: true, width: '140px',  align: 'center' },
              { key: 'actions', label: 'Actions' }
            ]"
            :bUrl="bUrl"
            :isBranch="true"
          >

           <template #cell-accountHeads="{ item }">
            
              <BBadge variant="primary"  v-for="account in (item.account?.account_heads || [])"   :key="account.id" style="margin-right: 5px;" >

                ({{ account.code }}) {{ account.name }} ({{ account.type }})
              </BBadge>
                  
          </template>
            <template #cell-status="{ item }">

             <StatusDisplay v-if="item.account" :value="item.account.status ? 1 : 0" />

              <BBadge v-else variant="warning">
                 Not Added
              </BBadge>
            </template>

            <template #actions="{ rowItem }">
              <div class="btn-group">
        
                <BButton variant="outline-info" @click="openModal(rowItem)">
                  <i class="fa fa-edit"></i>
                </BButton>
              
              </div>
            </template>
          </DataTable>
        </div>
      </div>
    </div>
  </div>

  <!-- Modal Form -->
  <FormModal
    v-model="showModal"
    :title="form.id ? `Edit ${title}` : `Add ${title}`"
    :loading="isSubmitting"
    size="xl"
    @submit="saveItem"
    class="voucher-posting-modal"
  >
    <ValidationErrors :errors="errors" />

    
    <BaseFormGroup label="Module Name" required>
  <BFormInput v-model="form.module_name" placeholder="e.g. Sales Invoice" />
</BaseFormGroup>

<BaseFormGroup label="Entry Type" required>
  <BFormInput v-model="form.entry_type" placeholder="e.g. sales" />
</BaseFormGroup>

<BaseFormGroup label="Description">
  <BFormTextarea v-model="form.description" rows="3" />
</BaseFormGroup>

<BaseFormGroup label="Status">
  <BFormCheckbox v-model="form.status"   :true-value="1"
  :false-value="0">Active</BFormCheckbox>
</BaseFormGroup>
<!-- Account Entries Table -->
 
<div class="table-responsive lines-table mt-4">
  <table class="table table-bordered mb-0">
    <thead class="thead-light">
      <tr>
        <th>Name</th>
        <th>Account Head</th>
        <th style="width: 100px;" class="text-center">Is Debit</th>
        <th  width="25%">Description</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="(acc, index) in form.accounts" :key="index" class="line-row">
        <td>
          {{acc.name}}
        </td>
        <td class="account-head-cell">
          <ResourceSelect
            v-model="acc.account_head_id"
            bUrl="accounting/account-heads"
             :clearable="false"
              :labelField="(item) => `(${item.code}) ${item.name} (${item.type})`"
              :isEdit="isEdit"
              :optionsData="accountHeads"
              :positional="true"
          />
        </td>
        <td class="text-center">
          <template v-if="acc.is_debit"> ✅ Yes</template>
          <template v-else>❌ No</template>
        </td>
        <td>
          <BFormInput v-model="acc.description" placeholder="Line description" />
        </td>
       
      </tr>
    </tbody>
  </table>
</div>
</FormModal>




</template>

<style scoped>
.voucher-posting-modal .modal-body {
  overflow: visible !important; /* Make modal body overflow visible */
  max-height: calc(100vh - 150px);
  overflow-y: auto; /* Allow scrolling if content is large */
}

.lines-table {
  overflow: visible !important; /* Important so dropdowns can overflow */
}

.line-row .account-head-cell {
  position: relative; /* Make sure dropdown positions relative to this cell */
}

.resource-select {
  width: 100%;
  /* Ensure dropdowns can overflow parent */
  overflow: visible !important;
  position: relative !important;
  z-index: 1050; /* Should be above modal */
}
.col-form-label{
  padding: 0;
}
.modal-body {
  max-height: 70vh; /* Adjust as needed */
  overflow-y: auto;
}

</style>
