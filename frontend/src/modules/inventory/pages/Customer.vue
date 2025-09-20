<script setup>
import { ref } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm } from '@/utilities/methods'


//  Setup
const title = 'Customer'
const bUrl = 'inventory/customers'

const {
  update,
  create,
  askDelete,
  confirmDelete,
  confirmDeleteModal,
  formErrors,
  isSubmitting,
} = useResourceApiClient(bUrl, title, true)

//  Form Setup
const { form, reset } = useForm({
  name: '',
  phone: '',
  email: '',
  address: '',
  previous_due: '',
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

    await dataTableRef.value?.refresh()
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
            <div class="card-tools">
              <BButton variant="primary" size="sm" @click="openModal()"><i class="fas fa-plus"></i> Add New</BButton>
            </div>
        </div>
        <div class="card-body">
          <DataTable
           ref="dataTableRef"
                    :fields="[
                      { key: 'sl', label: 'SL' },
                      { key: 'name', label: 'Name' },
                      { key: 'phone', label: 'Phone' },
                      { key: 'address', label: 'Address' },
                      { key: 'previous_due', label: 'Previous Due' },
                      { key: 'status', label: 'Status', isChange: true, width: '140px',  align: 'center' },
                      { key: 'actions', label: 'Actions' }
                    ]"
                    :bUrl="bUrl"
                    :isBranch="true"
                  >
                    <template #cell-status="{ item }">
                      <StatusDisplay :value="item.status" />
                    </template>
                   <template #actions="{ rowItem }">
                         <div class="btn-group dropleft">
                            <BButton variant="outline-primary"  @click="openModal(rowItem)">
                              <i class="fa fa-edit"></i>
                            </BButton>
                            <BButton variant="outline-danger"  @click="askDelete(rowItem.id)">
                              <i class="fa fa-trash"></i>
                            </BButton>
                        </div>
                   </template>
            </DataTable>
        </div>
      

    </div>

  </div>
    </div>

    <FormModal
  v-model="showModal"
  :title="form.id ? `Edit ${title}` : `Add ${title}`"
  :loading="isSubmitting"
  size="lg"
  
  @submit="saveItem"
>
  <ValidationErrors :errors="errors"  />
  <!-- Slot: Input fields -->
  <BaseFormGroup label="Name" labelCols="3"  required>
    <BFormInput v-model="form.name" />
  </BaseFormGroup>

  <BaseFormGroup label="Phone" labelCols="3">
    <BFormInput v-model="form.phone" />
  </BaseFormGroup>
    <BaseFormGroup label="Email" labelCols="3" >
    <BFormInput v-model="form.email" type="email" />
  </BaseFormGroup>
    <BaseFormGroup label="Address" labelCols="3" >
    <BFormInput v-model="form.address" />
  </BaseFormGroup>
    <BaseFormGroup label="Previous Due" labelCols="3" >
    <BFormInput v-model="form.previous_due" />
  </BaseFormGroup>

  <BaseFormGroup label="Status" labelCols="3"  required>
       <StatusSelect v-model="form.status" />
  </BaseFormGroup>

</FormModal>

</template>