<script setup>
import { ref, watch } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm } from '@/utilities/methods'

const emit = defineEmits(['created', 'update:show'])

const props = defineProps({
  show: Boolean
})

const title = 'Product'
const bUrl = 'inventory/products'

const { create, formErrors, isSubmitting } = useResourceApiClient(bUrl, title, true)

const { form, reset } = useForm({
  name: '',
  category_id: '',
  unit_id: '',
  purchase_price: '',
  selling_price: '',
  re_order: '',
  made_by: '',
  upload_image: '',
  image: '',
  specification: '',
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
    :title="`Add New Product`"
    :loading="isSubmitting"
    size="lg"
    @submit="saveItem"
  >
    <ValidationErrors :errors="errors" />

    <BaseFormGroup label="Product Name" labelCols="3" required>
      <BFormInput v-model="form.name" />
    </BaseFormGroup>

    <BaseFormGroup label="Category" labelCols="3" required>
      <ResourceSelect
        v-model="form.category_id"
        bUrl="inventory/categories"
        :isBranch="true"
        placeholder="Select Category"
      />
    </BaseFormGroup>

    <BaseFormGroup label="Unit" labelCols="3" required>
      <ResourceSelect
        v-model="form.unit_id"
        bUrl="inventory/units"
        :isBranch="true"
        placeholder="Select Unit"
      />
    </BaseFormGroup>

    <BaseFormGroup label="Purchase Price" labelCols="3">
      <PriceInput v-model="form.purchase_price" />
    </BaseFormGroup>

    <BaseFormGroup label="Selling Price" labelCols="3">
      <PriceInput v-model="form.selling_price" />
    </BaseFormGroup>

    <BaseFormGroup label="Reorder Level" labelCols="3">
      <BFormInput v-model="form.re_order" />
    </BaseFormGroup>

    <BaseFormGroup label="Made By" labelCols="3">
      <BFormInput v-model="form.made_by" />
    </BaseFormGroup>

    <BaseFormGroup label="Product Image" labelCols="3">
      <FileUpload v-model="form.upload_image" preview />
    </BaseFormGroup>
  </FormModal>
</template>
