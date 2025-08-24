<script setup>
    import { ref } from 'vue'
    import { useResourceApiClient } from '@/composables/resourceApiClient'
    import { useForm } from '@/utilities/methods'
    
const title = 'Module'
const bUrl = 'core/modules'

const {
  update,
  create,
  askDelete,
  confirmDelete,
  confirmDeleteModal,
  formErrors,
  isSubmitting,

} = useResourceApiClient(bUrl, title)

let errors = ref([])

const { form, reset } = useForm({
  name: '',
  slug: '',
  status: 1,
})

const dataTableRef = ref(null)

async function saveItem() {
  try {
    if (form.value.id) {
      await await update(form.value.id, form.value);
    } else {
      await create(form.value)
    }
     // DataTable refresh
   await dataTableRef.value?.refresh();

    showModal.value = false
    reset()
  } catch (error) {
    errors.value = formErrors.value
  }
}

const showModal = ref(false)

function openModal(item = null) {
  errors.value = [];
  reset();              // reset first
  if (item) Object.assign(form.value, item); 
  showModal.value = true;
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
                      { key: 'slug', label: 'Slug' },
                      { key: 'status', label: 'Status', isChange: true, width: '140px',  align: 'center' },
                      { key: 'actions', label: 'Actions' }
                    ]"
                    :bUrl="bUrl"
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
  
  @submit="saveItem"
>
  <ValidationErrors :errors="errors"  />
  <!-- Slot: Input fields -->
  <BaseFormGroup label="Name" labelCols="3"  required>
    <BFormInput v-model="form.name" />
  </BaseFormGroup>

  <BaseFormGroup label="Slug" labelCols="3" required>
    <BFormInput v-model="form.slug" />
  </BaseFormGroup>

  <BaseFormGroup label="Status" labelCols="3"  required>
       <StatusSelect v-model="form.status" />
  </BaseFormGroup>

</FormModal>

</template>