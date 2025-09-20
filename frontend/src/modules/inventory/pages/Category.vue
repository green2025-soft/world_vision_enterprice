<script setup>
import { ref } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm } from '@/utilities/methods'

//  Setup
const title = 'Category'
const bUrl = 'inventory/categories'

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
    <!-- Delete Confirmation -->
  <ConfirmDelete
    ref="confirmDeleteModal"
    @confirm="() => confirmDelete(() => dataTableRef.refresh())"
  />


  <div class="px-3">
    <div class="mx-auto w-100" style="max-width: 900px;">
      <div class="card card-outline card-info">
        <!-- Header -->
        <div class="card-header d-flex justify-content-between align-items-center">
          <h2 class="card-title m-0">
            <i class="fas fa-tasks"></i> {{ title }}
          </h2>
          <BButton variant="primary" size="sm" @click="openModal()">
            <i class="fas fa-plus"></i> Add New
          </BButton>
        </div>

        <!-- Data Table -->
        <div class="card-body">
          <DataTable
            ref="dataTableRef"
            :fields="[
              { key: 'sl', label: 'SL' },
              { key: 'name', label: 'Name' },
              { key: 'actions', label: 'Actions' }
            ]"
            :bUrl="bUrl"
            :isBranch="true"
          >
            <!-- Actions -->
            <template #actions="{ rowItem }">
              <div class="btn-group dropleft">
                <BButton variant="outline-primary" @click="openModal(rowItem)">
                  <i class="fa fa-edit"></i>
                </BButton>
                <BButton variant="outline-danger" @click="askDelete(rowItem.id)">
                  <i class="fa fa-trash"></i>
                </BButton>
              </div>
            </template>
          </DataTable>
        </div>
      </div>
    </div>
  </div>




    <!-- Form Modal -->
  <FormModal
    v-model="showModal"
    :title="form.id ? `Edit ${title}` : `Add ${title}`"
    :loading="isSubmitting"
    @submit="saveItem"
  >
    <ValidationErrors :errors="errors" />

    <BaseFormGroup label="Name" labelCols="3" required>
      <BFormInput v-model="form.name" />
    </BaseFormGroup>


  </FormModal>

</template>