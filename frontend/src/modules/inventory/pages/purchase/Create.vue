<script setup>
import { ref, watch, computed  } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm, formatDate } from '@/utilities/methods'


//  Setup
const title = 'Create Purchase'
const bUrl = 'inventory/purchase'

const {
  updateWithFile,
  create,
  askDelete,
  confirmDelete,
  getOne,
  confirmDeleteModal,
  formErrors,
  isSubmitting,
} = useResourceApiClient(bUrl, title, true)

//  Form Setup
const { form, reset } = useForm({
  supplier_id: '',
  invoice_date: new Date(),
  note: '',
  discount_percent: '',
  discount_amount: '',
  tax_percent: '',
  adjustment: '',
  paid_amount: '',
  advance_adjusted: '',
 items:[
  {product_id:null,  quantity: 1, unit_price: 0, cost_price:0, sale_price:0, discount_percent:0, discount_amount:0, tax_percent:0, tax_amount:0 }
 ]

})
const errors = ref([])
const showModal = ref(false)
const dataTableRef = ref(null)
const isEdit = ref(false)

//  Modal Open/Edit
function openModal(item = null) {
  errors.value = []
  reset()
  if (item) {
    Object.assign(form.value, item)
    isEdit.value = true
  } else {
    isEdit.value = false
  }

  showModal.value = true
}

//  Save/Create/Update Item
async function saveItem() {
  try {
    if (form.value.id) {
      await updateWithFile(form.value.id, form.value)
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

const viewOpenModal = ref(false)
const viewItem = ref(null)
const isLoading = ref(false)

// Function to open modal & load data
async function openViewModal(id) {
  isLoading.value = true
  try {
    const data = await getOne(id)
    viewItem.value = data
    viewOpenModal.value = true
  } catch (err) {
    console.error('Failed to load item', err)
  } finally {
    isLoading.value = false
  }
}


const selectedProduct = ref(null)

watch(selectedProduct, (newVal) => {
  
  
if (!newVal) return

  form.value.items[0].product_id = newVal.id
  form.value.items[0].purchase_price = parseFloat(newVal.purchase_price) || 0
  form.value.items[0].sale_price = parseFloat(newVal.sale_price) || 0
  form.value.items[0].stock = newVal.current_stock || 0
  
})









</script>
<template>
  <div class="card shadow-sm rounded-3">
    <!-- Header -->
    <div class="card-header d-flex justify-content-between align-items-center bg-primary text-white">
      <h5 class="mb-0 fw-semibold">
        <i class="fas fa-tasks me-2"></i>{{ title }}
      </h5>

      <BButton variant="light" size="sm">
        <i class="fas fa-list me-1"></i> Purchase List
      </BButton>
    </div>

    <div class="card-body bg-light">
      <!-- Header Row: Supplier (wide) | Date (small) | Note (wide) -->
      <div class="row g-3 mb-4">
        <!-- Supplier (wide) -->
        <div class="col-lg-5 col-md-5 col-12">
          <label class="form-label fw-semibold">Supplier</label>
          <div class="input-group">
            <!-- inline style forces this instance to stretch inside input-group -->
            <ResourceSelect
              v-model="form.items[0].product"
              bUrl="inventory/suppliers/balances"
              placeholder="Select Supplier"
              :isBranch="true"
              :labelField="(item) => `${item.name} (${item.phone})`"
              style="flex:1; min-width:0; width:100%; display:block;"
            />
            <BButton variant="outline-primary" size="sm" class="btn">
              <i class="fas fa-plus"></i>
            </BButton>
          </div>
        </div>

        <!-- Invoice Date (small) -->
        <div class="col-lg-2 col-md-3 col-12">
          <label class="form-label fw-semibold">Invoice Date</label>
          <DatePicker v-model="form.invoice_date"  />
        </div>

        <!-- Note (wide) -->
        <div class="col-lg-5 col-md-3 col-12">
          <label class="form-label fw-semibold">Note</label>
          <BFormTextarea rows="2" v-model="form.note" placeholder="Enter note..." />
        </div>
      </div>


      <!-- Product Entry Section -->
<div class="card mb-4">
  <div class="card-body">
    <div class="row g-3 align-items-end">
      <!-- Product -->
      <div class="col-lg-4 col-md-6 col-12">
        <label class="form-label fw-semibold">Product</label>
        <div class="input-group">
          <ResourceSelect
             v-model="selectedProduct"
            bUrl="inventory/products-overview"
            placeholder="Select Product"
          :isBranch="true"
            :labelField="(item) => `${item.name} (${item.sku})`"
            :emitObject="true"
            :isEdit="true"
            style="flex:1; min-width:0; width:100%; display:block;"
            
          />

          <BButton variant="outline-success" size="sm" class="btn">
            <i class="fas fa-plus"></i>
          </BButton>
        </div>
      </div>

      <!-- Qty -->
      <div class="col-lg-1 col-md-2 col-6">
        <label class="form-label fw-semibold">Qty</label>
        <BFormInput
          type="number"
          v-model="form.items[0].quantity"
          placeholder="0"
          min="1"
        />
      </div>
      <div class="col-lg-1 col-md-2 col-6">
        <label class="form-label fw-semibold">Purchase Price</label>
        <BFormInput
          type="number"
          v-model="form.items[0].purchase_price"
          placeholder="0.00"
          readonly
        />
      </div>

      <!-- Sale Price -->
      <div class="col-lg-1 col-md-2 col-6">
        <label class="form-label fw-semibold">Sale  Price</label>
        <BFormInput
          type="number"
          v-model="form.items[0].sale_price"
          placeholder="0.00"
          readonly
        />
      </div>

      <!-- Stock -->
      <div class="col-lg-1 col-md-2 col-6">
        <label class="form-label fw-semibold">Stock</label>
        <BFormInput
          type="number"
          v-model="form.items[0].stock"
          readonly
        />
      </div>

      <!-- Disc % -->
      <div class="col-lg-1 col-md-2 col-6">
        <label class="form-label fw-semibold">Disc %</label>
        <BFormInput
          type="number"
          v-model="form.items[0].discount_percent"
          placeholder="0"
        />
      </div>

      <!-- Disc Amt -->
      <div class="col-lg-1 col-md-2 col-6">
        <label class="form-label fw-semibold">Disc Amt</label>
        <BFormInput
          type="number"
          v-model="form.items[0].discount_amount"
          placeholder="0.00"
        />
      </div>

      <!-- Tax % -->
      <div class="col-lg-1 col-md-2 col-6">
        <label class="form-label fw-semibold">Tax %</label>
        <BFormInput
          type="number"
          v-model="form.items[0].tax_percent"
          placeholder="0"
        />
      </div>

      <!-- Tax Amt -->
      <div class="col-lg-1 col-md-2 col-6">
        <label class="form-label fw-semibold">Tax Amt</label>
        <BFormInput
          type="number"
          v-model="form.items[0].tax_amount"
          placeholder="0.00"
        />
      </div>

      <!-- Add Button -->
      <div class="col-12 text-end">
        <BButton variant="primary">
          <i class="fas fa-plus me-1"></i> Add
        </BButton>
      </div>
    </div>
  </div>
</div>


      <!-- Product List (classic bordered table) -->
      <div class="table-responsive mb-4">
        <table class="table table-bordered table-striped mb-0">
          <thead class="table-light text-center">
            <tr>
              <th style="width:40px">#</th>
              <th>Product</th>
              <th style="width:80px">Qty</th>
              <th style="width:110px">Sale</th>
              <th style="width:100px">Disc %</th>
              <th style="width:110px">Tax Amt</th>
              <th style="width:140px" class="text-end">Subtotal</th>
              <th style="width:90px" class="text-center">Action</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>1</td>
              <td>Product A</td>
              <td class="text-center">10</td>
              <td class="text-end">120.00</td>
              <td class="text-center">5</td>
              <td class="text-end">75.00</td>
              <td class="text-end fw-semibold">৳ 1,125.00</td>
              <td class="text-center">
                <BButton size="sm" variant="outline-danger">
                  <i class="fas fa-trash-alt"></i>
                </BButton>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Summary -->
      <div class="row g-3 mb-4">
        <div class="col-lg-2 col-md-4 col-6">
          <label class="form-label fw-semibold">Discount (%)</label>
          <BFormInput />
        </div>
        <div class="col-lg-2 col-md-4 col-6">
          <label class="form-label fw-semibold">Discount Amount</label>
          <BFormInput />
        </div>
        <div class="col-lg-2 col-md-4 col-6">
          <label class="form-label fw-semibold">Tax (%)</label>
          <BFormInput />
        </div>
        <div class="col-lg-2 col-md-4 col-6">
          <label class="form-label fw-semibold">Adjustment</label>
          <BFormInput />
        </div>
        <div class="col-lg-2 col-md-4 col-6">
          <label class="form-label fw-semibold">Paid Amount</label>
          <BFormInput />
        </div>
        <div class="col-lg-2 col-md-4 col-6">
          <label class="form-label fw-semibold">Advance Adjusted</label>
          <BFormInput />
        </div>
      </div>

      <!-- Totals -->
      <div class="d-flex justify-content-end gap-4 mb-3">
        <div class="text-end">
          <small class="text-muted d-block">Total Payable</small>
          <h5 class="mb-0 text-primary fw-bold">৳ 0.00</h5>
        </div>
        <div class="text-end">
          <small class="text-muted d-block">Due</small>
          <h5 class="mb-0 text-danger fw-bold">৳ 0.00</h5>
        </div>
      </div>
    </div>

    <div class="card-footer bg-white text-end">
      <BButton variant="primary">
        <i class="fas fa-save me-1"></i> Save Purchase
      </BButton>
    </div>
  </div>
</template>



<style scoped>
/* Minimal scoped styles only */

/* keep ResourceSelect inline-stretch fallback appearance smooth */
.input-group .btn {
  border-top-left-radius: 0;
  border-bottom-left-radius: 0;
}

/* ensure DatePicker / textareas use full width when class used */
.card-body .w-100 {
  width: 100%;
}
</style>
