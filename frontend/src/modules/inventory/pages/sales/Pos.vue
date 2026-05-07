<script setup>
import { ref, watch, onMounted, nextTick, computed, defineProps } from 'vue'
import { toast } from 'vue3-toastify'

import "@/modules/inventory/assets/css/pos.css"
import { authenticate } from "@/store/authenticate"
import { useForm, formatCurrency, dbDataFormat } from '@/utilities/methods'
import AddCustomerModal from '@/modules/inventory/pages/sales/AddCustomerModal.vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useRouter } from 'vue-router'

// ───── STATE ─────
const router = useRouter()
const showAddCustomerModal = ref(false)
const selectedProduct = ref(null)
const selectedCustomer = ref(null)

const productSelect = ref(null)
const customerSelect = ref(null)
const isSpinner = ref(false)

const auth = authenticate

const title = 'Pos'
const props = defineProps({
  id: {
    type: [String, Number],
    required: false
  }
})
// ───── API ─────
const { 
  customGet, 
  create, 
  update,
  getOne, 
  isSubmitting, 
  formErrors 
} = useResourceApiClient('inventory/sales', title, true)

// ───── FILTER ─────
const { form: filterForm } = useForm({
  category_id: '',
  isStock: true,
  per_page: 50
})

const productData = ref([])

const fetchProducts = async () => {
  try {
     isSpinner.value= true
    productData.value = await customGet(
      'inventory/products-overview',
      filterForm.value
    )
  } catch {
    toast.error('Failed to load products')
  }
   isSpinner.value= false
}


const isEditMode = !!props.id 

onMounted(async () => {
  fetchProducts()
    if (isEditMode){
    isSpinner.value = true
    const editData = await getOne(props.id)
    form.value = editData
    handleCustomerCreated(editData.customer)
    isSpinner.value =false
  }
})

// FIX: no array wrapper
watch(() => filterForm.value.category_id, fetchProducts)

// ───── MAIN FORM ─────
const { form, reset } = useForm({
  customer_id: '',
  invoice_date: new Date(),
  items: [],
  discount_percent: 0,
  discount_amount: 0,
  tax_percent: 0,
  tax_amount: 0,
  adjustment: 0,
  advance_adjusted: 0,
  paid_amount: 0,
})

// ───── ADD PRODUCT ─────
const addProduct = (p) => {
  if (!p?.id) return

  const existing = form.value.items.find(i => i.id === p.id)
  const stock = p.current_stock || 0

  if (existing) {
    if (existing.quantity < stock) {
      existing.quantity++
    } else {
      toast.error(`Only ${stock} items available`)
    }
    return
  }
form.value.items.push({
  product_id: p.id,
  name: p.name,

  quantity: 1,
  unit_price: Number(p.sale_price || 0),

  cost_price: Number(p.cost_price || 0),
  current_stock: Number(p.current_stock || 0),

})
}

// ───── PRODUCT SELECT ─────
watch(selectedProduct, (val) => {
  if (!val) return

  addProduct(val)
  selectedProduct.value = null

  nextTick(() => productSelect.value?.focus())
})

// ───── QUANTITY ─────
const clampQuantity = (item) => {
  const stock = item.current_stock || 0

  if (item.quantity > stock) {
    item.quantity = stock
    toast.error(`Only ${stock} available`)
  }

  if (item.quantity < 1) {
    item.quantity = 1
  }
}

// REMOVED: deep watcher (performance killer)

// ───── REMOVE ITEM ─────
const removeItem = (i) => form.value.items.splice(i, 1)

// ───── TOTALS ─────
const subtotal = computed(() =>
  form.value.items.reduce(
    (sum, i) => sum + i.quantity * (i.unit_price || 0),
    0
  )
)

const totals = computed(() =>
  form.value.items.reduce(
    (acc, i) => {
      acc.quantity += i.quantity
      acc.amount += i.quantity * (i.unit_price || 0)
      return acc
    },
    { quantity: 0, amount: 0 }
  )
)

// ───── CUSTOMER ─────
function handleCustomerCreated(customer) {
  customerSelect.value?.addOption?.(customer)

  selectedCustomer.value = customer
  form.value.customer_id = customer.id

  showAddCustomerModal.value = false
}

watch(selectedCustomer, (c) => {
  form.value.customer_id = c?.id || ''
})

const customerBalance = computed(() =>
  Number(selectedCustomer.value?.balance ?? 0)
)

const customerDue = computed(() =>
  customerBalance.value < 0 ? -customerBalance.value : 0
)

const customerAdvance = computed(() =>
  customerBalance.value > 0 ? customerBalance.value : 0
)

// ───── DISCOUNT & TAX ─────
const lastChanged = ref(null)

const syncDiscountTax = (type, mode) => {
  lastChanged.value = `${type}-${mode}`
  const base = subtotal.value
  if(form.value.discount_percent >100){
    form.value.discount_percent =100
  }

  if(form.value.tax_percent >100){
    form.value.tax_percent =100
  }

  if (form.value.discount_amount > maxPayable.value){
      form.value.discount_amount = maxPayable.value
  }
  
  
  if (type === 'discount') {
    form.value.discount_amount =
      mode === 'percent'
        ? (base * form.value.discount_percent) / 100
        : form.value.discount_amount

    form.value.discount_percent =
      mode === 'amount' && base
        ? (form.value.discount_amount / base) * 100
        : form.value.discount_percent
  }

  if (type === 'tax') {
    form.value.tax_amount =
      mode === 'percent'
        ? (base * form.value.tax_percent) / 100
        : form.value.tax_amount

    form.value.tax_percent =
      mode === 'amount' && base
        ? (form.value.tax_amount / base) * 100
        : form.value.tax_percent
  }
}

watch(subtotal, () => {
  syncDiscountTax(
    'discount',
    lastChanged.value === 'discount-amount' ? 'amount' : 'percent'
  )

  syncDiscountTax(
    'tax',
    lastChanged.value === 'tax-amount' ? 'amount' : 'percent'
  )
})

// ───── TOTAL CALC ─────
const grandTotal = computed(() =>
  subtotal.value -
  form.value.discount_amount +
  form.value.tax_amount -
  form.value.adjustment
)

const advanceAdjusted = computed(() =>
  Math.min(customerAdvance.value, grandTotal.value)
)

watch(advanceAdjusted, v => (form.value.advance_adjusted = v), { immediate: true })

const totalDue = computed(() =>
  grandTotal.value + customerDue.value - advanceAdjusted.value
)

const safeTotalDue = computed(() => Math.max(totalDue.value, 0) - form.value.paid_amount)

const finalPayable = computed(() =>
  grandTotal.value - advanceAdjusted.value
)

const remainingDue = computed(() =>
  Math.max(finalPayable.value - (form.value.paid_amount || 0), 0)
)

const maxPayable = computed(() =>
  Math.max(totalDue.value, 0)
)

const clampPaidAmount = () => {
  let val = Number(form.value.paid_amount)
  const max = maxPayable.value

  if (val > max) {
    form.value.paid_amount = max
    toast.error(`Max payable is ${max}`)
    return
  }

  form.value.paid_amount = val
}

const clearAll = () => {
reset({
  invoice_date: new Date(),
  items: []
})
  

  selectedCustomer.value = null
  selectedProduct.value = null

  customerSelect.value?.clear?.()
  productSelect.value?.clear?.()
}




const errors = ref([])
// Save (create/update)
async function saveItem() {
  form.value.invoice_date = dbDataFormat(form.value.invoice_date)
  let message = `${title} created successfully`;
  try {
    let saleId = form.value.id;
    if (form.value.id) {
       message = `${title} updated successfully`;
      await update(form.value.id, form.value, false, false)
    } else {
      const saleData = await create(form.value, '', false, false)
       saleId = saleData.id;
    }

    clearAll()
    // toast.success(message)
    router.push(`/inventory/sales/${saleId}?print=true`)

  } catch (error) {
    errors.value = formErrors.value
  }
}

</script>
<template>
<AddCustomerModal
  v-model:show="showAddCustomerModal"
  @created="handleCustomerCreated"
/>

<div class="pos">
    <div class="container-fluid">
      <div class="row topbar p-2 align-items-center g-2">
        <div class="col-md-1">
          <router-link to="/inventory/dashboard" class="btn btn-outline-primary w-100 px-0">
            <i class="fas fa-arrow-left"></i> Dashboard
          </router-link>
        </div>
        <div class="col-md-1">
          <BButton variant="outline-secondary" @click.prevent="clearAll()" class="w-100">
            <i class="fas fa-eraser"></i> Clear All
          </BButton>
        </div>
         <div class="col-md-5">
          <!-- <div class="search-wrapper"> -->
            <!-- <i class="fas fa-search"></i>
            <BFormInput autocomplete="off"
             placeholder="Enter Product name / SKU / Scan bar code" 
             id="product_search"
             /> -->
            
            <!-- Popover -->
           <ResourceSelect
                ref="productSelect"
                v-model="selectedProduct"
                bUrl="inventory/products-overview?"
                placeholder="Select Product"
                :isBranch="true"
                :labelField="(item) => `${item.name} (${item.sku})`"
                :emitObject="true" 
                
                style="flex:1; min-width:0; width:100%; display:block;"
                :extraParams="{isStock: true}"
                  @select="addProduct"
                  
                />
          <!-- </div> -->
        </div>
        <div class="col-md-4">
          
             <ResourceSelect
              v-model="filterForm.category_id"
                bUrl="inventory/categories"
                :isBranch="true"

                placeholder="Select Category" />

       
        </div>
        <div class="col-md-1 text-end">

           <BButton variant="outline-primary" @click.prevent="auth.logout()" >
             <i class="fas fa-sign-out-alt me-2"></i> Logout
          </BButton>
        </div>        
      </div>


      <div class="row" style="height: 86vh;">
        <div class="col-md-2 category overflow-auto d-none">
          
        </div>


        <div class="col-md-7 p-0 products overflow-auto">
          <div class="col-md-12 px-3">
             
              <ValidationErrors :errors="errors" />
            </div>
            
          
            <CenteredSpinner v-if="isSpinner"  />
          
          
          <div class="row row-cols-3 row-cols-md-6 g-2 py-3" v-else>
            
            
            <div v-for="(productItem, index) in productData" :key="index" class="col">
              <div class="product-card"  @click="() => addProduct(productItem)">
                <GlobalImage :src="productItem.image" wrapperClass="m-auto" />

                <div class="pt-2">
                  <h6 class="mb-1">{{ productItem.name }}</h6>
                  <p class="text-muted mb-2">{{ productItem.sale_price }}</p>
                  <button  @click.stop="addProduct(productItem)"  class="btn btn-sm btn-primary w-100">Add</button>
                </div>
              </div>
            </div>
            
            
            
            
            
            

            <!-- Repeat for more products -->
          </div>
        </div>

        <div class="col-md-5 order-summary d-flex flex-column p-0" >
          <div class="order-summary-container d-flex flex-column flex-grow-1 bg-white pr-0" style="padding-right: 5px;">

            <!-- POS Header -->
            <!-- <div class="row g-2 order-summary-header mb-3 px-2 pt-2">
              <div class="col-md-3 col-sm-6">
                <button class="btn btn-outline-primary w-100">Dine In</button>
              </div>
              <div class="col-md-3 col-sm-6">
                <button class="btn btn-outline-primary w-100">Take Away</button>
              </div>
              <div class="col-md-3 col-sm-6">
                <button class="btn btn-outline-primary w-100">Delivery</button>
              </div>
              <div class="col-md-3 col-sm-6">
                <button class="btn btn-outline-primary w-100">Table</button>
              </div>
            </div> -->

            <!-- Select Section -->
            <div class="row g-2 mb-3 px-2">
              <div class="col-md-8">
                <div class="custom-customer-component">
                  <div class="customer-selection-wrapper">
                    <div class="customer-selection">
                        <div class="input-group">
                             <ResourceSelect
                                v-model="selectedCustomer"
                                bUrl="inventory/customers/balances"
                                placeholder="Select Customer"
                                :isBranch="true"
                                :emitObject="true"
                                :labelField="(item) => `${item.name} (${item.phone})`"
                                style="flex:1; min-width:0; width:100%; display:block;"
                                :isEdit="isEditMode"
                                />
                                <BButton variant="primary" @click="showAddCustomerModal = true" size="sm" class="btn">
                                <i class="fas fa-plus"></i>
                                </BButton>
                                

                        </div>
                      
            
                    
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-md-4">
                <DatePicker v-model="form.invoice_date"  />
                <!-- <select class="form-select">
                  <option selected>Waiter</option>                  
                </select> -->
              </div>
            </div>

            <!-- Items Table -->
            <div class="table-responsive order-summary-scroll mb-3 flex-grow-1 overflow-auto p-0">
              <table class="table order-summary-table align-middle" id="orderTable">
                <thead class="table-light">
                  <tr>
                    <th>Item</th>
                    <th class="text-end">Price</th>
                    <th width="110" class="text-center">Qty</th>
                    <th class="text-end">Total</th>
                    <th width="20"></th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(item, index) in form.items" :key="index">
                    <td class="p-2"><i class="bi bi-pencil"></i> {{ item.name }} ({{ item.sku }})</td>
                    <td class="text-end p-0" style="padding-right: 8px !important;">{{ item.unit_price }} </td>
                    <!-- Quantity Control -->
                    <td class="p-0">
                      <div class="order-summary-qty-box d-flex align-items-center justify-content-center">
                         <BInputGroup>
                        <BButton variant="outline-primary" size="sm" class="qty-btn" @click="item.quantity--" :disabled="item.quantity <= 1">-</BButton>
            
                        <BFormInput
                            type="number"
                            class="qty-input text-center p-0"
                            v-model.number="item.quantity"
                            @input="clampQuantity(item)"
                            :min="1"
                            :max="item.current_stock"
                          />
                        <BButton variant="outline-primary" size="sm" class="qty-btn"   @click="item.quantity < item.current_stock ? item.quantity++ : null"
  :disabled="item.quantity >= item.current_stock" >+</BButton>
                        </BInputGroup>
                      </div>
                    </td>
                    <td class="item-total text-end p-0">{{ item.unit_price*item.quantity  }}</td>
                    <td class="p-0"><button @click="removeItem(index)" class="btn btn-remove"><i class="fas fa-trash-alt"></i></button></td>
                  </tr>
                 
                 
                
           
             
               
                  
                </tbody>
              </table>
            </div>

            <div class="order-summary-footer mt-auto px-2 pb-3 pt-2"
              style="background-color: #f8f9fa; border-top: 1px solid #dee2e6;">

              <!-- SubTotal, Tax, Discount, Total -->
              <div class="mb-3">
                <div class="d-flex justify-content-between py-1">
                  <span>Sub Total</span>
                  <span>{{ formatCurrency(totals.amount) }}</span>
                </div>
                <hr class="m-2">
                <div class="row">
                  <div class="col-sm-2 mb-2" style="padding-right: 0px;">
                    <label class="fw-semibold" >Disc%</label>
                    <BFormInput type="number" v-model.number="form.discount_percent"   @keyup="syncDiscountTax('discount', 'percent')" size="sm" class="px-0 text-center" />
                  </div>
                  <div class="col-sm-4  mb-2">
                      <label class="fw-semibold">Disc Amt</label>
                      <BFormInput size="sm"  v-model.number="form.discount_amount"  type="number" @keyup="syncDiscountTax('discount', 'amount')"  />
                  </div>
                  <div class="col-sm-2 p-0  mb-2">
                    <label class=" fw-semibold">Tex%</label>
                    <BFormInput v-model.number="form.tax_percent" @keyup="syncDiscountTax('tax', 'percent')" size="sm" type="number" class="px-0 text-center" />
                  </div>
                  <div class="col-sm-4  mb-2">
                      <label class="fw-semibold">Tex Amt</label>
                      <BFormInput v-model.number="form.tax_amount" @keyup="syncDiscountTax('tax', 'amount')" size="sm" type="number" />
                  </div>
                  <!-- <div class="col-sm-9 " style="padding-right: 0;"> -->
                    
                   
                  <!-- </div> -->
                  
                   <div class="col-sm-4">
                      <label class="fw-semibold">Adjustment</label>
                      <BFormInput size="sm" v-model="form.adjustment" type="number" />
                   </div>
                   
                   <div class="col-sm-4" v-if="customerBalance === 0 || customerBalance < 0">
                      <template  v-if="customerBalance === 0">
                        <label class=" fw-semibold">Customer Balance</label>
                        <BFormInput size="sm" v-model="customerBalance" type="number" readonly />
                      </template>
                       <template  v-if="customerBalance < 0">
                        <label class="fw-semibold">Customer Due</label>
                        <BFormInput size="sm" type="number" v-model="customerDue" readonly />
                      </template>
                   </div>
                   <div class="col-sm-4 p-0"  v-if="customerBalance > 0">
                    <div class="row">
                        <div class="col-sm-6" style="padding-right: 5px;">
                          <label class="fw-semibold">C. Advance</label>
                          <BFormInput size="sm" type="number" v-model="customerAdvance" readonly />
                        </div>
                        <div class="col-sm-6" style="padding-left: 5px;">
                          <label class="fw-semibold">C. Adjusted</label>
                          <BFormInput size="sm" type="number" v-model="form.advance_adjusted" readonly />
                        </div>
                    </div>
                    
                   </div>
                   <div class="col-sm-4">
                    <label class="fw-semibold">Paid Amount</label>
                      <BFormInput size="sm" type="number" @input="clampPaidAmount()" v-model="form.paid_amount" />
                   </div>

                </div>
                
                <div class="d-flex justify-content-between fw-bold fs-5 border-top pt-2 mt-2">
                  <span>Grand Total</span>
                  <span>{{ formatCurrency(finalPayable) }}</span>
                </div>
                <div class="mb-3">
                  <div class="d-flex justify-content-between py-1">
                    <span>Remaining Due</span>
                    <span>{{ formatCurrency(remainingDue ) }}</span>
                  </div>
                  <div class="d-flex justify-content-between py-1" >
                    <span>Total Due</span>
                    <span>{{ formatCurrency(safeTotalDue  ) }}</span>
                  </div>
                </div>
              </div>

              <!-- Action Buttons -->
              <div class="row g-2 order-summary-actions d-none">
                <div class="col-md-3 col-sm-6">
                  <BButton size="sm" variant="danger" class="w-100">Cancel</BButton>
                </div>
                <div class="col-md-3 col-sm-6">
                  <button class="btn btn-purple w-100" style="background-color: #6f42c1; color: white;">Draft</button>
                </div>
                <div class="col-md-3 col-sm-6">
                   <BButton size="sm" variant="primary" class="w-100">Quick Invoice</BButton>
                </div>
                <div class="col-md-3 col-sm-6">
                  <BButton size="sm" variant="success" class="w-100">Place Order</BButton>
                </div>
              </div>
            </div>


          </div>
        </div>


      </div>
    </div>
  </div>

  <!-- POS Footer Fixed Action Bar -->
  <footer class="pos-action-footer fixed-bottom py-2 px-3 ">
    <div class="container-fluid">
      <div class="d-flex flex-wrap align-items-center justify-content-between gap-2">


        <div class="d-flex flex-wrap gap-2 align-items-center">
          <!-- <button class="btn btn-md btn-outline-primary">
            <i class="fas fa-edit me-1"></i> Draft
          </button>
          <button class="btn btn-md btn-outline-warning">
            <i class="fas fa-pen-alt me-1"></i> Quotation
          </button>
          <button class="btn btn-md btn-outline-danger">
            <i class="fas fa-pause-circle me-1"></i> Suspend
          </button>
          <button class="btn btn-md btn-outline-success">
            <i class="fas fa-check-circle me-1"></i> Credit Sale
          </button>
          <button class="btn btn-md btn-outline-pink">
            <i class="fas fa-credit-card me-1"></i> Card
          </button> -->
        </div>


        <div class="d-flex flex-wrap gap-2 align-items-center">
          <div class="total-payable ms-3">
            Total Payable: <span class="amount">{{ formatCurrency(finalPayable) }}</span>
          </div>
          <!-- <button class="btn btn-md btn-dark">
            <i class="fas fa-money-check-alt me-1"></i> Multiple Pay
          </button> -->
          <LoadingButton size="md" variant="success"
          :loading="isSubmitting"
           @click="saveItem"
          >
            <i class="fas fa-money-bill-wave me-1"></i> Cash Payment
          </LoadingButton>
          <!-- <button class="btn btn-md btn-danger">
            <i class="fas fa-times-circle me-1"></i> Cancel
          </button> -->
          
        </div>


        <!-- <div>
          <button class="btn btn-md btn-primary rounded-pill px-4">
            <i class="fas fa-history me-1"></i> Recent Transactions
          </button>
        </div> -->
      </div>
    </div>
  </footer>

</template>
