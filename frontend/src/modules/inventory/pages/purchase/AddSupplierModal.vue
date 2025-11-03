<script setup>
import { ref, watch } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm } from '@/utilities/methods'

const emit = defineEmits(['created', 'update:show'])

const props = defineProps({
  show: Boolean
})

const title = 'Supplier'
const bUrl = 'inventory/suppliers'

const { create, formErrors, isSubmitting } = useResourceApiClient(bUrl, title, true)

const { form, reset } = useForm({
  name: '',
  phone: '',
  email: '',
  address: '',
  previous_due: '',
  status: 1
})

const errors = ref([])
const showModal = ref(false)

// Sync modal state with parent prop
watch(
  () => props.show,
  (val) => (showModal.value = val)
)

// When modal closes, notify parent to update
watch(showModal, (val) => emit('update:show', val))

// Create and emit new product
async function saveItem() {
  try {
    const newProduct = await create(form.value)
    emit('created', newProduct)
    reset()
    showModal.value = false
  } catch (error) {
    errors.value = formErrors.value
  }
}
</script>

<template>
  <FormModal
    v-model="showModal"
    :title="`Add New ${title}`"
    :loading="isSubmitting"
    size="lg"
    @submit="saveItem"
  >
    <ValidationErrors :errors="errors" />

    <BaseFormGroup label="Supplier Name" labelCols="3" required>
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
