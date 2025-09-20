<script setup>
import { ref, onMounted, computed } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm } from '@/utilities/methods'
import ChartRow from '@/modules/accounting/components/ChartRow.vue'


//  Setup
const title = 'Chart Of Account'
const bUrl = 'accounting/chart-of-accounts'

const {
  getList,
  update,
  create,
  confirmDelete,
  confirmDeleteModal,
  formErrors,
  isSubmitting,
} = useResourceApiClient(bUrl, title)

let allData = ref([])
onMounted(async () => {
  allData.value = await getList()
})

//  Form Setup
const { form, reset } = useForm({
  name: '',
  parent_id: '',
  remarks: '',
  status: 1,
})
const errors = ref([])
const showModal = ref(false)
const dataTableRef = ref(null)

//  Modal Open/Edit
function openModal(item = null) {
  errors.value = []
  reset()
  if (item) Object.assign(form.value, item)
  showModal.value = true
}

//  Save/Create/Update Item
async function saveItem() {
  try {
    if (form.value.id) {
      await update(form.value.id, form.value)
    } else {
      await create(form.value)
    }
    allData.value = await getList()
    reset()
    showModal.value = false
  } catch (error) {
    errors.value = formErrors.value
  }
}


</script>

<template>
     <ConfirmDelete ref="confirmDeleteModal"  @confirm="() => confirmDelete(() => dataTableRef.refresh())" />
     <div class="container-fluid">
        <div class="container ">
    <div class="card card-outline card-info">
        <div class="card-header">
             <h2 class="card-title"><i class="fas fa-tasks"></i> {{ title }}</h2>
    
        </div>
        <div class="card-body">
           <table class="table table-bordered">
            <thead class="thead-light">
              <tr>
                <th>Accounts Code</th>
                <th>Head of Accounts</th>
                <th class="text-center">Is Debit</th>
                <th class="text-center">Status</th>
                <th class="text-center">Option</th>
              </tr>
            </thead>
            <tbody>
              
              <template v-for="item in allData" :key="item.id">
                <ChartRow
                  :item="item"
                  :depth="0"
                  @edit="openModal"
                  @add-child="(parent) => openModal({ parent_id: parent.id })"
                />
              </template>
            </tbody>
          </table>
          
        </div>
      

    </div>

  </div>
    </div>

    <FormModal
  v-model="showModal"
  :title="form.id ? `Edit ${title}` : `Add ${title}`"
  :loading="isSubmitting"

  
  @submit="saveItem"
>
  <ValidationErrors :errors="errors"  />
  <!-- Slot: Input fields -->
  <BaseFormGroup label="Name" labelCols="3"  required>
    <BFormInput v-model="form.name" />
  </BaseFormGroup>
  <BaseFormGroup label="Remarks" labelCols="3" >
    <BFormTextarea v-model="form.remarks" />
  </BaseFormGroup>
  <BaseFormGroup label="Status" labelCols="3"  required>
       <StatusSelect v-model="form.status" />
  </BaseFormGroup>



</FormModal>

</template>