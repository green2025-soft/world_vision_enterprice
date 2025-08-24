<script setup>
    import { ref } from 'vue'
    import { useResourceApiClient } from '@/composables/resourceApiClient'
    import { useForm } from '@/utilities/methods'
    

const title = 'Role'
const bUrl = 'core/roles'

const {
  update,
  create,
  askDelete,
  confirmDelete,
  formErrors,
  isSubmitting,
  confirmDeleteModal,
} = useResourceApiClient(bUrl, title)

let errors = ref([])



const { form, reset } = useForm({
  name: '',
  redirect_url: '',
  direction: '',
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
    if (dataTableRef.value && dataTableRef.value.refresh) {
      await dataTableRef.value.refresh();
    }
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
                      { key: 'redirect_url', label: 'redirect Url' },
                      { key: 'direction', label: 'direction ' },
                      { key: 'actions', label: 'Actions' }
                    ]"
                       :bUrl="bUrl"
                  >
            
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
  :title="form.id ? 'Edit Role' : 'Add Role'"
  :loading="isSubmitting"
  
  @submit="saveItem"
>
  <ValidationErrors :errors="errors"  />
  <!-- Slot: Input fields -->
  <BaseFormGroup label="Name" labelCols="12" required>
    <BFormInput v-model="form.name" />
  </BaseFormGroup>

  <BFormGroup label="Redirect URL">
    <BFormInput v-model="form.redirect_url" />
  </BFormGroup>

  <BFormGroup label="Direction">
    <BFormInput v-model="form.direction" />
  </BFormGroup>
</FormModal>

</template>