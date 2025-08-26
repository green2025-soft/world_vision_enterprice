<script setup>
    import { ref } from 'vue'
    import { useResourceApiClient } from '@/composables/resourceApiClient'
    import { useForm } from '@/utilities/methods'
    
const title = 'Branch'
const bUrl = 'core/branches'

const {
  create,
  askDelete,
  confirmDelete,
  updateWithFile,
  confirmDeleteModal,
  formErrors,
  isSubmitting,

} = useResourceApiClient(bUrl, title)

let errors = ref([])

const { form, reset } = useForm({
  name: '',
  contact_no: '',
  fileLogo: '',
})

const dataTableRef = ref(null)

async function saveItem() {
  try {
    if (form.value.id) {
      await await updateWithFile(form.value.id, form.value);
    } else {
      await create(form.value, '',true)
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
                      { key: 'contact_no', label: 'Contact No' },
                      { key: 'logo', label: 'Logo', isChange: true,  align: 'center' },
                      { key: 'actions', label: 'Actions' }
                    ]"
                    :bUrl="bUrl"
                  >
                    <template #cell-logo="{ item }">
                          <GlobalImage :src="item.logo" wrapperClass="m-auto" :size="50"/>
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

  <BaseFormGroup label="Contact No" labelCols="3" >
    <BFormInput v-model="form.contact_no" />
  </BaseFormGroup>

  <BaseFormGroup label="Logo" labelCols="3"  >
      <FileUpload v-model="form.fileLogo"  preview />
  </BaseFormGroup>

</FormModal>

</template>