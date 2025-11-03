<script setup>
import { ref } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { usePurchaseForm } from "@/modules/inventory/composables/usePurchaseForm"
import AddProductModal from '@/modules/inventory/pages/purchase/AddProductModal.vue'
import AddSupplierModal from '@/modules/inventory/pages/purchase/AddSupplierModal.vue'
import { formatCurrency, clampPercent } from '@/utilities/methods'
const showAddProductModal = ref(false)
const showAddSupplierModal = ref(false)

const title = 'Create Purchase'
const bUrl = 'inventory/purchase'
const { 
  create,
  formErrors,
  isSubmitting,
  update,
} = useResourceApiClient(bUrl, title, true)

const {
  form,
  selectedProduct,
  editingIndex,
  productInput,
  selectedSupplier,
  supplierBalance,
  supplierDue,
  supplierAdvance,
  addProduct,
  editItem,
  removeItem,
  resetProductInput,
  calcSubTotal,
  calcTotal,
  totalTotal,
  netPayable

} = usePurchaseForm()

const productSelect = ref(null)

function handleProductCreated(product) {
  // Add new product to ResourceSelect and select it
  if (productSelect.value?.addOption) {
    productSelect.value.addOption(product)
  }

  // Close modal
  showAddProductModal.value = false
}


const supplierSelect = ref(null)
function handleSupplierCreated(supplier) {
  if (supplierSelect.value?.addOption) {
    supplierSelect.value.addOption(supplier)
  }

  selectedSupplier.value = supplier
  form.value.supplier_id = supplier.id

  showAddSupplierModal.value = false
}


</script>

<template>
  <AddProductModal
  v-model:show="showAddProductModal"
  @created="handleProductCreated"
/>

<AddSupplierModal
  v-model:show="showAddSupplierModal"
  @created="handleSupplierCreated"
/>
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
      {{ form }}
    
      <!-- Header Row: Supplier (wide) | Date (small) | Note (wide) -->
      <div class="row g-3 mb-4">
        <!-- Supplier (wide) -->
        <div class="col-lg-5 col-md-5 col-12">
          <label class="form-label fw-semibold">Supplier <code>*</code></label>
          <div class="input-group">
            <!-- inline style forces this instance to stretch inside input-group -->
            <ResourceSelect
             ref="supplierSelect"
             v-model="selectedSupplier"
              bUrl="inventory/suppliers/balances"
              placeholder="Select Supplier"
              :isBranch="true"
              :emitObject="true"
              :labelField="(item) => `${item.name} (${item.phone})`"
              style="flex:1; min-width:0; width:100%; display:block;"
            />
            <BButton variant="outline-primary" @click="showAddSupplierModal = true" size="sm" class="btn">
              <i class="fas fa-plus"></i>
            </BButton>
          </div>
        </div>

        <!-- Invoice Date (small) -->
        <div class="col-lg-2 col-md-3 col-12">
          <label class="form-label fw-semibold">Invoice Date <code>*</code></label>
          <DatePicker v-model="form.invoice_date"  />
        </div>

        <!-- Note (wide) -->
        <div class="col-lg-5 col-md-3 col-12">
          <label class="form-label fw-semibold">Note</label>
          <BFormTextarea rows="1" v-model="form.note" placeholder="Enter note..." />
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
                ref="productSelect"
                  v-model="selectedProduct"
                  bUrl="inventory/products-overview"
                  placeholder="Select Product"
                  :isBranch="true"
                  :labelField="(item) => `${item.name} (${item.sku})`"
                  :emitObject="true"
                  :isEdit="editingIndex !== null"
                  style="flex:1; min-width:0; width:100%; display:block;"
                  
                />

          <BButton variant="outline-success"  @click="showAddProductModal = true" size="sm" class="btn">
            <i class="fas fa-plus"></i>
          </BButton>
        </div>
      </div>

      <!-- Qty -->
      <div class="col-lg-1 col-md-2 col-6">
        <label class="form-label fw-semibold">Qty</label>
        <BFormInput
          type="number"
          v-model="productInput.quantity"
          placeholder="0"
          min="1"
        />
      </div>
      <div class="col-lg-1 col-md-2 col-6">
        <label class="form-label fw-semibold">Unit Price</label>
        <BFormInput
          type="number"
          v-model="productInput.purchase_price"
          placeholder="0.00"
          min="0"
          
        />
      </div>

      <!-- Sale Price -->
      <div class="col-lg-1 col-md-2 col-6">
        <label class="form-label fw-semibold">Sale  Price</label>
        <BFormInput
          type="number"
          v-model="productInput.sale_price"
          placeholder="0.00"
          min="0"
          
        />
      </div>

      <!-- Stock -->
      <div class="col-lg-1 col-md-2 col-6">
        <label class="form-label fw-semibold">Stock</label>
        <BFormInput
          type="number"
          v-model="productInput.stock"
          readonly
          min="0"
        />
      </div>

      <!-- Disc % -->
      <div class="col-lg-1 col-md-2 col-6">
        <label class="form-label fw-semibold">Disc %</label>
        <BFormInput
          type="number"
          v-model="productInput.discount_percent"
          placeholder="0"
          min="0"
          max="100"
          @input="productInput.discount_percent = clampPercent($event)"
        />
      </div>

      <!-- Disc Amt -->
      <div class="col-lg-1 col-md-2 col-6">
        <label class="form-label fw-semibold">Disc Amt</label>
        <BFormInput
          type="number"
          v-model="productInput.discount_amount"
          placeholder="0.00"
        />
      </div>

      <!-- Tax % -->
      <div class="col-lg-1 col-md-2 col-6">
        <label class="form-label fw-semibold">Tax %</label>
        <BFormInput
          type="number"
          v-model="productInput.tax_percent"
          placeholder="0"
          min="0"
          max="100"
           @input="productInput.tax_percent = clampPercent($event)"
        />
      </div>

      <!-- Tax Amt -->
      <div class="col-lg-1 col-md-2 col-6">
        <label class="form-label fw-semibold">Tax Amt</label>
        <BFormInput
          type="number"
          v-model="productInput.tax_amount"
          placeholder="0.00"
        />
      </div>

      <!-- Add Button -->
      <div class="col-12 text-end">
           <BButton :variant="editingIndex !== null ? 'warning' : 'primary'" @click="addProduct">
            <i class="fas" :class="editingIndex !== null ? 'fa-save' : 'fa-plus'"></i>
            {{ editingIndex !== null ? 'Update' : 'Add' }}
          </BButton>
        <BButton v-if="editingIndex !== null" variant="secondary" class="ms-2" @click="resetProductInput">
          Cancel
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
              <th style="width:60px">Qty</th>
              <th style="width:100px">Unit Price</th>
              <th style="width:110px">Sale Price</th>
              <th style="width:65px">Disc %</th>
              <th style="width:90px">Disc Amt</th>
              <th style="width:60px">Tax %</th>
              <th style="width:90px">Tax Amt</th>
              <th style="width:108px" class="text-end">Sub-total</th>
              <th style="width:120px" class="text-end">Total</th>
              <th style="width:90px" class="text-center">Action</th>
            </tr>
          </thead>
           <tbody>
            <tr v-for="(item, index) in form.items" :key="index">
              
              <td class="text-center">{{ index + 1 }}</td>
              <td>{{ item.name }} ({{ item.sku }})</td>
              <td class="text-center">{{ item.quantity }}</td>
              <td class="text-end"> {{ formatCurrency(item.purchase_price) }}</td>
              <td class="text-end"> {{ formatCurrency(item.sale_price) }}</td>
              <td class="text-center">{{ item.discount_percent }}</td>
              <td class="text-end">{{ formatCurrency(item.discount_amount) }}</td>
              <td class="text-center"> {{ item.tax_percent }}</td>
              <td class="text-end"> {{ formatCurrency(item.tax_amount) }}</td>
              <td class="text-end"> {{ formatCurrency(calcSubTotal(item)) }}</td>
              <td class="text-end fw-semibold text-primary">{{ formatCurrency(calcTotal(item)) }}</td>
              <td class="text-center">
                 <div class="btn-group dropleft">
                  <BButton size="sm" variant="outline-primary" @click="editItem(index)">
                    <i class="fa fa-edit"></i>
                  </BButton>
                  <BButton size="sm" variant="outline-danger" @click="removeItem(index)">
                    <i class="fas fa-trash-alt"></i>
                  </BButton>
                </div>
              </td>
            </tr>
          </tbody>
          <tfoot v-if="form.items.length >0">
           <tr class="table-secondary fw-bold text-end">
            <td colspan="2" class="text-end">Grand Total </td>
            <td class="text-center">{{ totalQuantity }}</td>
            <td>{{ formatCurrency(totalUnitPrice) }}</td>
            <td>{{ formatCurrency(totalSalePrice)}}</td>
            <td class="text-center">-</td>
            <td class="text-end">{{ formatCurrency(totalDiscAmount) }}</td>
            <td class="text-center">-</td>
            <td>{{ formatCurrency(totalTaxAmount) }}</td>
            <td>{{ formatCurrency(totalSubTotal) }}</td>
            <td>{{ formatCurrency(totalTotal) }}</td>
            <td></td>
          </tr>


          </tfoot>
        </table>
      </div>

      <!-- Summary -->
      <div class="row g-3">
        <div class="col-lg-2 col-md-4 col-6">
          <label class="form-label fw-semibold">Discount (%)</label>
          <BFormInput v-model.number="form.discount_percent" type="number" />
        </div>
        <div class="col-lg-2 col-md-4 col-6">
          <label class="form-label fw-semibold">Discount Amount</label>
           <BFormInput v-model.number="form.discount_amount" type="number" />
        </div>
        <div class="col-lg-2 col-md-4 col-6">
          <label class="form-label fw-semibold">Tax (%)</label>
          <BFormInput v-model="form.tax_percent" type="number" />
        </div>
          <div class="col-lg-2 col-md-4 col-6">
          <label class="form-label fw-semibold">Tax Amount</label>
          <BFormInput v-model="form.tax_amount" type="number" />
        </div>
        <div class="col-lg-2 col-md-4 col-6">
          <label class="form-label fw-semibold">Adjustment</label>
          <BFormInput v-model.number="form.adjustment" type="number" />
        </div>
     
     
        <div class="col-lg-2 col-md-4 col-6" v-if="supplierBalance < 0">
          <label class="form-label fw-semibold">Supplier Due</label>
          <BFormInput  v-model="supplierDue" readonly />
        </div>
        <div class="col-lg-2 col-md-4 col-6" v-if="supplierBalance > 0">
          <label class="form-label fw-semibold">Supplier Advance</label>
          <BFormInput v-model="supplierAdvance" readonly />
        </div>
            <div class="col-lg-2 col-md-4 col-6" v-if="supplierBalance === 0">
          <label class="form-label fw-semibold">Supplier Balance</label>
          <BFormInput v-model="supplierBalance" readonly />
        </div>
        <div class="col-lg-2 col-md-4 col-6" v-if="supplierBalance > 0">
          <label class="form-label fw-semibold">Supplier Adjusted</label>
          <BFormInput v-model.number="form.advance_adjusted" readonly />
        </div>
        <div class="col-lg-2 col-md-4 col-6">
          <label class="form-label fw-semibold">Paid Amount</label>
          <BFormInput v-model.number="form.paid_amount" type="number" />
        </div>
        
      </div>

      <!-- Totals -->
      <div class="d-flex justify-content-end gap-4 mb-3">
        <div class="text-end">
          <small class="text-muted d-block">Total Payable</small>
          <h5 class="mb-0 text-primary fw-bold">{{ formatCurrency(netPayable) }}</h5>
        </div>
        <div class="text-end">
          <small class="text-muted d-block">Due</small>
          <h5 class="mb-0 text-danger fw-bold">{{ formatCurrency(Math.max(netPayable - form.paid_amount, 0)) }}</h5>
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
