<script setup>
  import {ref, watch, onMounted } from 'vue'
  
    import "@/modules/inventory/assets/css/pos.css";
    import { authenticate } from "@/store/authenticate";
    import { useForm, formatDate } from '@/utilities/methods';
    const auth = authenticate;

const title = 'Pos'
const bUrl = 'inventory/categories'

import { useResourceApiClient } from '@/composables/resourceApiClient'

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


const { form: filterForm, reset:filterReset } = useForm({
  category_id: '',
  isStock: true,
  per_page:50
})


let productData = ref([]);
onMounted(async () => {
  await fetchProducts()
})


const fetchProducts = async () => {
  productData.value = await customGet(
    'inventory/products-overview',
    filterForm.value 
  )
}


watch(
  () => [filterForm.value.category_id],
  () => {
    fetchProducts()
  }
)
    
const { form, reset } = useForm({
  customer_id:'',
  invoice_date:new Date(),
  items: []
})

  // ───── Add Product ─────
  const addProduct = (input) => {
    
    const productId =input.id
    if (!productId) return
    input.unit_price = input.purchase_price
    input.cost_price =
      (input.purchase_price || 0) - (input.discount_amount || 0) + (input.tax_amount || 0)
    const duplicateIndex = form.value.items.findIndex(
      (i, idx) => i.id === input.id
    )

    if (duplicateIndex !== -1) {

    }else{
      input.quantity = 1;
       form.value.items.push(input)
    }

  }

  const removeItem = (index) => {
    form.value.items.splice(index, 1)
   
  }



</script>
<template>
<div class="pos">
    <div class="container-fluid">
      <div class="row topbar p-2 align-items-center g-2">
        <div class="col-md-1">
          <button class="btn btn-outline-primary w-100">
            <i class="fas fa-arrow-left"></i> Dashboard
          </button>
        </div>
        <div class="col-md-1">
          <button class="btn btn-outline-secondary w-100">
            <i class="fas fa-eraser"></i> Clear All
          </button>
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
                
                bUrl="inventory/products-overview?"
                placeholder="Select Product"
                :isBranch="true"
                :labelField="(item) => `${item.name} (${item.sku})`"
                :emitObject="true" 
                
                style="flex:1; min-width:0; width:100%; display:block;"
                :extraParams="{isStock: true}"
                  
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
          {{ form.items }}
          
          <div class="row row-cols-3 row-cols-md-6 g-2 py-3">
            <div v-for="(productItem, index) in productData" :key="index" class="col">
              <div class="product-card"  @click="() => addProduct(productItem)">
                <img src="https://i.postimg.cc/SK1RJzw2/Qcp8h-TLke9-HWc-LIhxn-GGx-CKp3-R3num-R79-ZQG5r-MR.jpg"
                  class="w-100 product-img" alt="product">
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

        <div class="col-md-5 order-summary d-flex flex-column pr-0">
          <div class="order-summary-container d-flex flex-column flex-grow-1 bg-white">

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
                                ref="supplierSelect"
                           
                                bUrl="inventory/suppliers/balances"
                                placeholder="Select Supplier"
                                :isBranch="true"
                                :emitObject="true"
                                :labelField="(item) => `${item.name} (${item.phone})`"
                                style="flex:1; min-width:0; width:100%; display:block;"
                                />
                                <BButton variant="primary" @click="showAddSupplierModal = true" size="sm" class="btn">
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
            <div class="table-responsive order-summary-scroll mb-3 flex-grow-1 overflow-auto px-2">
              <table class="table table-bordered order-summary-table align-middle" id="orderTable">
                <thead class="table-light">
                  <tr>
                    <th>Item</th>
                    <th>Price</th>
                    <th width="110" class="text-center">Qty</th>
                    <th>Total</th>
                    <th width="20"></th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(item, index) in form.items" :key="index">
                    <td><i class="bi bi-pencil"></i> {{ item.name }}</td>
                    <td>{{ item.sale_price }}</td>
                    <!-- Quantity Control -->
                    <td>
                      <div class="order-summary-qty-box d-flex align-items-center justify-content-center">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">-</button>
                        <input type="number" class="form-control qty-input text-center" v-model="item.quantity" value="" min="1">
                        <button class="btn btn-outline-secondary btn-sm qty-btn" type="button">+</button>
                      </div>
                    </td>
                    <td class="item-total">{{ item.sale_price*item.quantity  }}</td>
                    <td><button @click="removeItem(index)" class="btn btn-remove"><i class="fas fa-trash-alt"></i></button></td>
                  </tr>
                 
                 
                
           
             
               
                  
                </tbody>
              </table>
            </div>

            <div class="order-summary-footer mt-auto px-2 pb-3 pt-2"
              style="background-color: #f8f9fa; border-top: 1px solid #dee2e6;">

              <!-- SubTotal, Tax, Discount, Total -->
              <div class="mb-3">
                <div class="d-flex justify-content-between py-1">
                  <span>SubTotal</span>
                  <span>$64.00</span>
                </div>
                <div class="d-flex justify-content-between py-1">
                  <span>Tax</span>
                  <span>$9.60</span>
                </div>
                <div class="d-flex justify-content-between py-1">
                  <span>Discount</span>
                  <span>$0.00</span>
                </div>
                <div class="d-flex justify-content-between fw-bold fs-5 border-top pt-2 mt-2">
                  <span>Total</span>
                  <span>$73.60</span>
                </div>
              </div>

              <!-- Action Buttons -->
              <div class="row g-2 order-summary-actions">
                <div class="col-md-3 col-sm-6">
                  <button class="btn btn-danger w-100">Cancel</button>
                </div>
                <div class="col-md-3 col-sm-6">
                  <button class="btn btn-purple w-100" style="background-color: #6f42c1; color: white;">Draft</button>
                </div>
                <div class="col-md-3 col-sm-6">
                  <button class="btn btn-primary w-100">Quick Invoice</button>
                </div>
                <div class="col-md-3 col-sm-6">
                  <button class="btn btn-success w-100">Place Order</button>
                </div>
              </div>
            </div>


          </div>
        </div>


      </div>
    </div>
  </div>

  <!-- POS Footer Fixed Action Bar -->
  <footer class="pos-action-footer fixed-bottom py-2 px-3 d-none">
    <div class="container-fluid">
      <div class="d-flex flex-wrap align-items-center justify-content-between gap-2">


        <div class="d-flex flex-wrap gap-2 align-items-center">
          <button class="btn btn-md btn-outline-primary">
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
          </button>
        </div>


        <div class="d-flex flex-wrap gap-2 align-items-center">
          <button class="btn btn-md btn-dark">
            <i class="fas fa-money-check-alt me-1"></i> Multiple Pay
          </button>
          <button class="btn btn-md btn-success">
            <i class="fas fa-money-bill-wave me-1"></i> Cash
          </button>
          <button class="btn btn-md btn-danger">
            <i class="fas fa-times-circle me-1"></i> Cancel
          </button>
          <div class="total-payable ms-3">
            Total Payable: <span class="amount">690.00</span>
          </div>
        </div>


        <div>
          <button class="btn btn-md btn-primary rounded-pill px-4">
            <i class="fas fa-history me-1"></i> Recent Transactions
          </button>
        </div>
      </div>
    </div>
  </footer>

</template>
