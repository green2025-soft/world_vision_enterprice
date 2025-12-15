<script setup>
import { ref, onMounted } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm } from '@/utilities/methods'

// Setup
const title = 'Product Set'
const bUrl = 'inventory/product-sets'

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

const isEdit = ref(false)
const showModal = ref(false)
const dataTableRef = ref(null)
const errors = ref([])

// Form Setup
const { form, reset } = useForm({
  name: '',
  discount: '',
  branch_id: '', // required
  items: [
    { product_id: null, qty: 1, price: 0 }
  ]
})

// Add/Remove item rows
function addItem() {
  form.value.items.push({ product_id: null, qty: 1, price: 0 })
}

function removeItem(index) {
  if (form.value.items.length > 1) {
    form.value.items.splice(index, 1)
  }
}

// Modal open for create/edit
function openModal(item = null) {
  errors.value = []
  reset()

  if (item) {
    Object.assign(form.value, item)
    form.value.items = JSON.parse(JSON.stringify(item.items || []))
    isEdit.value = true
  } else {
    isEdit.value = false
    form.value.items = [{ product_id: null, qty: 1, price: 0 }]
  }

  showModal.value = true
}

// Save (create/update)
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

let productData = ref([]);
onMounted(async () => {
  productData.value = await customGet('inventory/products');
})

</script>

<template>
  <!-- Confirm Delete Modal -->
  <ConfirmDelete
    ref="confirmDeleteModal"
    @confirm="() => confirmDelete(() => dataTableRef.refresh())"
  />

  <!-- Main Table -->
  <div class="container-fluid">
    <div class="container">
      <div class="card card-outline card-info">
        <div class="card-header d-flex justify-content-between align-items-center">
          <h2 class="card-title"><i class="fas fa-box"></i> {{ title }}</h2>
          <BButton variant="primary" size="sm" @click="openModal()">
            <i class="fas fa-plus"></i> Add New
          </BButton>
        </div>

        <div class="card-body">
          <DataTable
            ref="dataTableRef"
            :fields="[
              { key: 'sl', label: 'SL' },
              { key: 'name', label: 'Name' },
              { key: 'discount', label: 'Discount', align: 'center' },
              { key: 'products', label: 'Products', isChange: true, align: 'center'},
              { key: 'actions', label: 'Actions' }
            ]"
            :bUrl="bUrl"
            :isBranch="true"
          >

            <template #cell-products="{ item }">
              <BBadge v-for="product in item.products" style="margin-right: 5px;" >
                {{ product.name }} - {{ product.sku }}
              </BBadge>
                  
              </template>
            <template #actions="{ rowItem }">
              <div class="btn-group">
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

  <!-- Modal Form -->
  <FormModal
    v-model="showModal"
    :title="form.id ? `Edit ${title}` : `Add ${title}`"
    :loading="isSubmitting"
    size="lg"
    @submit="saveItem"
  >
    <ValidationErrors :errors="errors" />

    <BaseFormGroup label="Name" labelCols="3" required>
      <BFormInput v-model="form.name" />
    </BaseFormGroup>

    <BaseFormGroup label="Discount (%)" labelCols="3">
      <BFormInput v-model="form.discount" type="number" min="0" />
    </BaseFormGroup>


    <hr />
    <h5 class="mb-3">Product Set Items</h5>
  

    <div
      v-for="(item, index) in form.items"
      :key="index"
      class="border rounded p-2 mb-3 bg-light"
    >
    
      <div class="row align-items-center">
        <div class="col-md-8">
          <BaseFormGroup :label="`Product ${index + 1}`" labelCols="3" required>
            
              <ResourceSelect
              v-model="item.product_id"
              bUrl="inventory/products"
              placeholder="Select product"
              :isBranch="true"
              :isEdit="isEdit"
              :positional="true"
              :optionsData="productData"
            />

            
            
          </BaseFormGroup>
        </div>

        <div class="col-md-3">
          <BaseFormGroup label="Qty" labelCols="4" required>
            <BFormInput v-model="item.qty" type="number" min="1" />
          </BaseFormGroup>
        </div>



        <div class="col-md-1 text-right mt-4">
          <BButton
            variant="danger"
            size="sm"
            @click="removeItem(index)"
            v-if="form.items.length > 1"
          >
            <i class="fa fa-trash"></i>
          </BButton>
        </div>
      </div>
    </div>

    <div class="text-right mt-2">
      <BButton variant="success" size="sm" @click="addItem">
        <i class="fa fa-plus"></i> Add Item
      </BButton>
    </div>
  </FormModal>
</template>
