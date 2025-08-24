<script setup>
    import { shallowRef, onMounted, ref } from 'vue'
    import { useResourceApiClient } from '@/composables/resourceApiClient'
    import { useForm } from '@/utilities/methods'

const title =  'Users'  
const bUrl = 'core/users'
const {
  update,
  create,
  askDelete,
  confirmDelete,
  customGet,
  formErrors,
  isSubmitting,
  confirmDeleteModal,
} = useResourceApiClient(bUrl, title)

let roleLists = shallowRef([])
onMounted(async () => {
      
      roleLists.value =  await customGet('core/roles')
});

let errors = ref([])



const { form, reset } = useForm({
  name: '',
  email: '',
  password: '',
  role: '',
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
        <div class="card card-outline card-info">
            <div class="card-header">
             <h2 class="card-title"><i class="fas fa-tasks"></i> {{ title }}</h2>
            <div class="card-tools">
              <BButton variant="primary" size="sm" @click="openModal()"><i class="fas fa-plus"></i> Add New</BButton>
            </div>
        </div>
         
            <div class="card-body"  >
                <DataTable
                ref="dataTableRef"
                    :fields="[
                      { key: 'sl', label: 'SL' },
                      { key: 'name', label: 'Name' },
                      { key: 'email', label: 'Email' },
                       { key: 'roles', label: 'Role', isChange: true },
                      { key: 'actions', label: 'Actions' }
                    ]"
                   :bUrl="bUrl"
                  >
                    <template #cell-roles="{ item }">
                      {{ item?.roles[0]?.name??'' }}
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
            <div class="card-footer" >
                {{ title }} Manage
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

  <BaseFormGroup label="E-mail" labelCols="3" required>
    <BFormInput type="email" v-model="form.email" />
  </BaseFormGroup>

   <BaseFormGroup label="Role" labelCols="3" required>
       <BFormSelect
              v-model="form.role"
              :options="[
                { value: '', text: 'Select Role' },
                ...roleLists.map(r => ({ value: r.id, text: r.name }))
              ]"
            />
  </BaseFormGroup>

  <BaseFormGroup label="Password" labelCols="3" v-if="!form.id"  required>
        <BFormInput type="password" v-model="form.password" />
  </BaseFormGroup>

</FormModal>
</template>