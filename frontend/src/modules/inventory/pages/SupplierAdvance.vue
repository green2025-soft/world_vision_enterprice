<script setup>
import { ref, watch } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm, userDateFormat, dbDataFormat } from '@/utilities/methods'


//  Setup
const title = 'Supplier Advance'
const bUrl = 'inventory/supplier-advance'

const {
  update,
  create,
  askDelete,
  confirmDelete,
  customGet,
  confirmDeleteModal,
  formErrors,
  isSubmitting,
} = useResourceApiClient(bUrl, title, true)

//  Form Setup
const { form, reset } = useForm({
  supplier_id: '',
  advance_amount: '',
  date: new Date(),
  note: ''
})
const errors = ref([])
const showModal = ref(false)
const dataTableRef = ref(null)
const isEdit = ref(false)

//  Modal Open/Edit
function openModal(item = null) {
  errors.value = []
  reset()
  if (item){ 
    Object.assign(form.value, item)
     isEdit.value = true
  }else{
    isEdit.value = false 
  }
  showModal.value = true
}

//  Save/Create/Update Item
async function saveItem() {
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

const supplierBalance = ref(null)

const fetchSupplierBalance = async (id) => {
  try {
    const res = await customGet(`${bUrl}/${id}/balance`)
     supplierBalance.value = res
  } catch (err) {
    console.error('Failed to fetch supplier balance:', err)
    supplierBalance.value = null
  }
}

watch(
  () => form.value.supplier_id,
  (newId) => {
    if (newId) {
      fetchSupplierBalance(newId)
    } else {
      supplierBalance.value = null
    }
  }
)
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
                      { key: 'reference_no', label: 'Payment No', align: 'center' },
                      { key: 'date', label: 'Date', align: 'center', isChange: true, },
                      { key: 'supplier.name', label: 'Name' },
                      { key: 'supplier.phone', label: 'Phone' },
                      { key: 'note', label: 'Note' },
                      { key: 'advance_amount', label: 'Payment Amount', align: 'right'  },
                      { key: 'actions', label: 'Actions' }
                    ]"
                    :bUrl="bUrl"
                    :isBranch="true"
                  >
                    <template #cell-date="{ item }">
                      {{ userDateFormat(item.date) }}
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
    :button-disabled="supplierBalance?.status === 'due'"
  
  @submit="saveItem"
>
  <ValidationErrors :errors="errors"  />
  <!-- Slot: Input fields -->
  <BaseFormGroup label="Supplier Name" labelCols="3"  required>
  
     <ResourceSelect
              v-model="form.supplier_id"
              bUrl="inventory/suppliers"
              :clearable="false"
              :labelField="(item) => `${item.name} (${item.phone})`"
              :isEdit="isEdit"
              :isBranch="true"
            />
        <div v-if="supplierBalance" class="text-muted mt-2">
      <span v-if="supplierBalance.status === 'advance'" class="text-success">
        Advance: {{ supplierBalance.total_balance }}
      </span>
      <span v-else class="text-danger">
        Due: {{ Math.abs(supplierBalance.total_balance) }}
      </span>
    </div>
  </BaseFormGroup>

  <BaseFormGroup label="Date" labelCols="3" required>
     <DatePicker v-model="form.date" :max-date="new Date()" />
  </BaseFormGroup>

  <BaseFormGroup label="Advance Amount" labelCols="3" required >
     <BFormInput v-model="form.advance_amount" />
  </BaseFormGroup>
    <BaseFormGroup label="Note" labelCols="3" >
    <BFormTextarea v-model="form.note" />
  </BaseFormGroup>


</FormModal>

</template>