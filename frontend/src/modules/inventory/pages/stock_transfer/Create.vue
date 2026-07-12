<script setup>
import { ref, computed, watch, nextTick } from 'vue'
import { useRouter } from 'vue-router'
import { useBranchStore } from '@/store/branch-store'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm, dbDataFormat } from '@/utilities/methods'
import { toast } from 'vue3-toastify'
//import { useToast } from 'vue-toastification'

const router = useRouter()


const branchStore = useBranchStore()

const branchId = computed(() => branchStore.selectedBranchId)

const bUrl = 'inventory/stock-transfers'
const title = 'Stock Transfer'

const selectedBranch = ref(null)

const {
  create,
  update,
  isSubmitting,
  formErrors
} = useResourceApiClient(bUrl, title, true)

const { form } = useForm({
  id: null,
  from_branch_id: branchId.value,
  to_branch_id: null,
  transfer_date: new Date(),
  note: '',
  items: [],
})

const errors = ref([])

watch(selectedBranch, (b) => {
  form.value.to_branch_id = b?.id || ''
})

/* -----------------------------
| Product Select
------------------------------*/

const productSelect = ref(null)
const selectedProduct = ref(null)

watch(selectedProduct, (product) => {
  if (!product) return

  addProduct(product)

  selectedProduct.value = null

  nextTick(() => {
    productSelect.value?.focus?.()
  })
})

/* -----------------------------
| Add Product
------------------------------*/

const addProduct = (product) => {

  if (!product?.id) return

  const stock = Number(product.current_stock || 0)

  if (stock <= 0) {
    //toast.error('Stock not available')
    return
  }

  const existing = form.value.items.find(
    item => item.product_id === product.id
  )

  if (existing) {

    if (existing.quantity >= existing.current_stock) {
      //toast.error(`Only ${existing.current_stock} stock available`)
      return
    }

    existing.quantity++

    existing.total_cost =
      existing.quantity * existing.unit_cost

    return
  }

  form.value.items.push({

    product_id: product.id,

    sku: product.sku,

    name: product.name,

    quantity: 1,

    current_stock: stock,

    unit_price: Number(product.sale_price || 0),

    unit_cost: Number(product.cost_price || 0),

    total_cost: Number(product.cost_price || 0),

    consumed_quantity: Number(
      product.consumed_quantity || 0
    )

  })

}

/* -----------------------------
| Remove Product
------------------------------*/

const removeProduct = (index) => {
  form.value.items.splice(index, 1)
}

/* -----------------------------
| Increase Qty
------------------------------*/

const increaseQty = (item) => {

  if (item.quantity >= item.current_stock) {
    toast.error(`Only ${item.current_stock} available`)
    return
  }

  item.quantity++

  item.total_cost =
    item.quantity * item.unit_cost

}

/* -----------------------------
| Decrease Qty
------------------------------*/

const decreaseQty = (item) => {

  if (item.quantity <= 1) return

  item.quantity--

  item.total_cost =
    item.quantity * item.unit_cost

}

/* -----------------------------
| Quantity Change
------------------------------*/

const quantityChanged = (item) => {

  item.quantity = Number(item.quantity)
  item.current_stock = Number(item.current_stock)

  if (item.quantity < 1) {
    item.quantity = 1
  }

  if (item.quantity > item.current_stock) {

    // toast.error(`Only ${item.current_stock} available`)

    item.quantity = item.current_stock
  }

  item.total_cost = item.quantity * item.unit_cost
}

/* -----------------------------
| Total Items
------------------------------*/

const totalItems = computed(() => {

  return form.value.items.reduce((total, item) => {

    return total + item.quantity

  }, 0)

})

/* -----------------------------
| Total Cost
------------------------------*/

const totalCost = computed(() => {

  return form.value.items.reduce((total, item) => {

    return total + item.total_cost

  }, 0)

})

/* ---------------------------------------
| Watch Selected Branch
---------------------------------------*/
watch(branchId, (val) => {
  form.value.from_branch_id = val
})

/* ---------------------------------------
| Form Validation
---------------------------------------*/
const validateForm = () => {
  if (!form.value.to_branch_id) {
    toast.error('Please select destination branch')
    return false
  }

  if (form.value.to_branch_id == form.value.from_branch_id) {
    toast.error('From Branch and To Branch cannot be same')
    return false
  }

  if (!form.value.transfer_date) {
    toast.error('Transfer date is required')
    return false
  }

  if (form.value.items.length === 0) {
    toast.error('Please add at least one product')
    return false
  }

  for (const item of form.value.items) {

    if (item.quantity <= 0) {
      toast.error(`${item.name} quantity is invalid`)
      return false
    }

    if (item.quantity > item.current_stock) {
      toast.error(
        `${item.name} quantity exceeds available stock`
      )
      return false
    }

  }

  return true

}

/* ---------------------------------------
| Submit
---------------------------------------*/
const submit = async () => {

  form.value.transfer_date = dbDataFormat(form.value.transfer_date)

  if (!validateForm()) return


let message = `${title} created successfully`

  try {
    if (form.value.id) {
      message = `${title} updated successfully`
      await update(form.value.id, form.value, false, false)
    } else {
      await create(form.value, '', false, false)
    }

    sessionStorage.setItem(
      'stockTransferToastMessage',
      JSON.stringify({
        message,
        type: 'success'
      })
    )

    router.push('/inventory/stock-transfers')
  } catch (error) {
    errors.value = formErrors.value
  }

}

/* ---------------------------------------
| Reset Form
---------------------------------------*/
const resetForm = () => {

  form.value = {

    id: null,

    from_branch_id: branchId.value,

    to_branch_id: null,

    transfer_date: new Date(),

    note: '',

    items: []

  }

}

/* ---------------------------------------
| Helpers
---------------------------------------*/
const stockClass = (stock) => {

  if (stock <= 0) return 'text-danger'

  if (stock <= 5) return 'text-warning'

  return 'text-success'

}


watch(
  () => form.value.items,
  (items) => {
    items.forEach(item => {
      if (item.quantity > item.current_stock) {
        item.quantity = item.current_stock
      }

      item.total_cost = item.quantity * item.unit_cost
    })
  },
  { deep: true }
)

const productExtraParams = ref({
    isStock: true
})


</script>
<template>
  <div class="transfer-form">
    <div class="card shadow-sm">
      <div class="card-header d-flex justify-content-between align-items-center bg-primary text-white">
      <h5 class="mb-0 fw-semibold">
        <i class="fas fa-random"></i> Transfer products between branches
      </h5>
      <RouterLink class="btn btn-light btn-sm" :to="`/${bUrl}`"><i class="fas fa-list me-1"></i>Transfer List</RouterLink>
    </div>
      <div class="card-body p-4">

        <!-- Top Section -->
        <div class="row g-3">

          

          <!-- To Branch -->
          <div class="col-md-4">
            <label class="form-label">
              To Branch <code>*</code>
            </label>

            <ResourceSelect
              v-model="selectedBranch"
              bUrl="core/branches"
              :emitObject="true"
              :isBranch="false"
              placeholder="Select Branch"
              :optionFilter="item => item.id !== form.from_branch_id"
              :labelField="item => item.name"
            />
          </div>

          <!-- Transfer Date -->
          <div class="col-md-3">
            <label class="form-label">
              Transfer Date <code>*</code>
            </label>

            <DatePicker
              v-model="form.transfer_date"
            />
          </div>
          <div class="col-md-5">
            <label class="form-label">Note</label>
            <BFormTextarea
              v-model="form.note"
              rows="2"
              placeholder="Write transfer note..."
            />
          </div>

       

        </div>



        <!-- Product Select -->
        <div class="row align-items-end g-3">

          <div class="col-md-10">

            <label class="form-label">
              Product
            </label>

            <ResourceSelect
              ref="productSelect"
              v-model="selectedProduct"
              bUrl="inventory/products-overview"
              :emitObject="true"
              :isBranch="true"
              placeholder="Search Product..."
              :extraParams="productExtraParams"
              :labelField="item => `${item.name} (${item.sku})`"
            />

          </div>


        </div>

        <hr class="my-4">
                <!-- PRODUCT TABLE -->
        <div v-if="form.items.length > 0" class="table-responsive">

          <table class="table table-bordered align-middle">

            <thead class="table-light">
              <tr>
                <th>Product</th>
                <th width="120" class="text-center">Stock</th>
                <th width="180" class="text-center">Quantity</th>
                <th width="140" class="text-end">Unit Cost</th>
                <th width="140" class="text-end">Total</th>
                <th width="80" class="text-center">Action</th>
              </tr>
            </thead>

            <tbody>

              <tr v-for="(item, index) in form.items" :key="item.product_id">

                <!-- Product -->
                <td>
                  <div>
                    
                     <strong>{{ item.name }}</strong>   
                   <small v-if="item.sku "> ({{ item.sku }})</small>
                  </div>
                </td>

                <!-- Stock -->
                <td class="text-center">
                  <span :class="stockClass(item.current_stock)">
                    {{ item.current_stock }}
                  </span>
                </td>

                <!-- Quantity -->
                <td>
                  <div class="d-flex align-items-center gap-2">

                    <button
                      class="btn btn-sm btn-outline-secondary"
                      @click="decreaseQty(item)"
                    >
                      -
                    </button>

                    <input
                      type="number"
                      class="form-control form-control-sm text-center"
                      v-model.number="item.quantity"
                      @input="quantityChanged(item)"
                      min="1"
                      :max="item.current_stock"
                    />

                    <button
                      class="btn btn-sm btn-outline-secondary"
                      @click="increaseQty(item)"
                    >
                      +
                    </button>

                  </div>
                </td>

                <!-- Unit Cost -->
                <td class="text-end">
                  {{ item.unit_cost }}
                </td>

                <!-- Total -->
                <td class="text-end">
                  {{ item.total_cost }}
                </td>

                <!-- Action -->
                <td class="text-center">
                  <button
                    class="btn btn-sm btn-danger m-auto"
                    @click="removeProduct(index)"
                  >
                    <i class="fa fa-trash"></i>
                  </button>
                </td>

              </tr>

            </tbody>

          </table>

        </div>

        <!-- EMPTY STATE -->
        <div v-else class="text-center text-muted py-4">
          No products added yet
        </div>

        <!-- SUMMARY -->
        <div class="row mt-4">

          <div class="col-md-6">

            <div class="p-3 bg-light rounded">

              <p class="mb-1">
                Total Items:
                <strong>{{ totalItems }}</strong>
              </p>

              <p class="mb-0">
                Total Cost:
                <strong>{{ totalCost }}</strong>
              </p>

            </div>

          </div>

          <div class="col-md-6 text-end">

            <button
              class="btn btn-secondary me-2"
              @click="resetForm"
            >
              Reset
            </button>

            <button
              class="btn btn-primary"
              :disabled="isSubmitting"
              @click="submit"
            >
              <i class="fa fa-paper-plane"></i>
              Transfer Stock
            </button>

          </div>

        </div>

      </div>
    </div>
  </div>
</template>