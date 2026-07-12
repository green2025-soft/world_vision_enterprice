<script setup>
import { ref, computed, watch, nextTick } from 'vue'
import { useRouter } from 'vue-router'

import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm, dbDataFormat } from '@/utilities/methods'
import { toast } from 'vue3-toastify'
import { BFormInput } from 'bootstrap-vue-next'

const router = useRouter()

const bUrl = 'inventory/product-wastages'
const title = 'Product Wastage'


const {
  create,
  update,
  isSubmitting,
  formErrors
} = useResourceApiClient(
  bUrl,
  title,
  true
)


/*
|--------------------------------------------------------------------------
| Default Form
|--------------------------------------------------------------------------
*/

const { form, reset } = useForm({
  id:null,
  wastage_date:new Date(),
  note:'',
  items:[]
})
const errors = ref([])

/*
|--------------------------------------------------------------------------
| Product Select
|--------------------------------------------------------------------------
*/
const productSelect = ref(null)
const selectedProduct = ref(null)
const productExtraParams = {
  isStock:true
}


watch(selectedProduct,(product)=>{
  if(!product) return
  addProduct(product)
  selectedProduct.value=null
  nextTick(()=>{
    productSelect.value?.focus?.()
  })

})

/*
|--------------------------------------------------------------------------
| Product
|--------------------------------------------------------------------------
*/

const calculateTotal = item => {
  item.total_cost =
    item.quantity *
    item.unit_cost
}

const addProduct = product => {
  if(!product?.id)
    return

  const stock = Number(product.current_stock || 0)
  if(stock <=0){
    toast.error('Stock not available')
    return
  }

  const existing =
    form.value.items.find(
      i=>i.product_id===product.id
    )

  if(existing){
    updateQuantity(
      existing,
      existing.quantity + 1
    )
    return
  }

  form.value.items.push({
    product_id:product.id,
    sku:product.sku,
    name:product.name,
    quantity:1,
    current_stock:stock,
    unit_cost:Number( product.cost_price || 0 ),
    total_cost:Number( product.cost_price || 0 ),
     reason: '',
    remarks: ''
  })
}


const removeProduct=index=>{
  form.value.items.splice(index,1)
}


/*
|--------------------------------------------------------------------------
| Quantity
|--------------------------------------------------------------------------
*/

const updateQuantity=(item,value)=>{
  let qty =
    Number(value)
  qty = Math.max(
    1,
    Math.min(
      qty,
      item.current_stock
    )
  )
  item.quantity = qty
  calculateTotal(item)
}

const increaseQty=item=>{
  updateQuantity(
    item,
    item.quantity + 1
  )
}

const decreaseQty=item=>{
  updateQuantity(
    item,
    item.quantity - 1
  )
}

const quantityChanged=item=>{
  updateQuantity(
    item,
    item.quantity
  )
}

/*
|--------------------------------------------------------------------------
| Summary
|--------------------------------------------------------------------------
*/

const summary = computed(()=>{
  return form.value.items.reduce(
    (acc,item)=>{
      acc.items += item.quantity
      acc.cost += item.total_cost
      return acc
    },
    {
      items:0,
      cost:0
    }
  )

})


const totalItems = computed( ()=>summary.value.items )
const totalCost = computed( ()=>summary.value.cost )

/*
|--------------------------------------------------------------------------
| Validation
|--------------------------------------------------------------------------
*/
const validateForm=()=>{
  const items=form.value.items
  if(!form.value.wastage_date){
    toast.error( 'Wastage date is required')
    return false
  }
  if(!items.length){
    toast.error('Please add product' )
    return false
  }

  const invalid =
    items.find(
      item =>
      item.quantity<=0 ||
      item.quantity>item.current_stock
    )
  if(invalid){
    toast.error( `${invalid.name} quantity invalid` )
    return false
  }
  return true

}


/*
|--------------------------------------------------------------------------
| Submit
|--------------------------------------------------------------------------
*/


const submit=async()=>{
  if(!validateForm()) return
  form.value.wastage_date = dbDataFormat(form.value.wastage_date)
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

    sessionStorage.setItem(
      'productWastageToastMessage',
      JSON.stringify({
        message,
        type:'success'
      })
    )
    router.push(
      '/inventory/product-wastages'
    )
}

/*
|--------------------------------------------------------------------------
| Helpers
|--------------------------------------------------------------------------
*/
const stockClass=stock=>{
  return stock<=0 ? 'text-danger' : stock<=5 ? 'text-warning' : 'text-success'
}

</script>
<template>
  <div class="wastage-form">
    <div class="card shadow-sm">
      <div class="card-header d-flex justify-content-between align-items-center bg-danger text-white">
        <h5 class="mb-0 fw-semibold"><i class="fas fa-trash-alt me-2"></i>Product Wastage</h5>
        <RouterLink  class="btn btn-light btn-sm" to="/inventory/product-wastages">
          <i class="fas fa-list me-1"></i> Wastage List
        </RouterLink>
      </div>

      <div class="card-body p-4">

        <!-- Date + Note -->

        <div class="row g-3 mb-3">
          <div class="col-md-3">
            <label class="form-label">Wastage Date <code>*</code></label>
            <DatePicker v-model="form.wastage_date" />
          </div>
          <div class="col-md-7">
            <label class="form-label"> Note </label>
            <BFormTextarea v-model="form.note"  rows="2" placeholder="Write wastage note..." />
          </div>
        </div>
        <!-- Product Select -->
        <div class="row g-3">
          <div class="col-md-10">
            <label class="form-label"> Product </label>
            <ResourceSelect 
            ref="productSelect" 
              v-model="selectedProduct"
              bUrl="inventory/products-overview"
              :emitObject="true"
              :isBranch="true"
              placeholder="Search Product..."
              :extraParams="productExtraParams"
              :labelField="
                item => `${item.name} (${item.sku})`
              "
            />
          </div>
        </div>
        <hr class="my-4">

        <!-- PRODUCT TABLE -->


        <div v-if="form.items.length" class="table-responsive" >
          <table class="table table-bordered align-middle" >
            <thead class="table-light">
              <tr>
                <th> Product </th>
                <th  width="120" class="text-center" > Stock </th>
                <th width="180" class="text-center" > Quantity </th>
                <th width="200"> Reason </th>
                <!-- <th width="250"> Remarks </th> -->
                <th width="140" class="text-end" > Unit Cost </th>
                <th  width="140" class="text-end" > Total </th>
                <th width="80" class="text-center" > Action </th>
              </tr>
            </thead>

            <tbody>
              <tr v-for="(item,index) in form.items" :key="item.product_id" >
                <!-- Product -->
                <td> 
                  <strong> {{ item.name }} </strong>
                  <small v-if="item.sku" >({{ item.sku }}) </small>
                </td>
                <!-- Stock -->

                <td class="text-center">
                  <span :class="stockClass(item.current_stock)" > {{ item.current_stock }}</span>
                </td>
                <!-- Quantity -->
                <td>
                  <div class="d-flex align-items-center gap-2" >
                    <BButton variant="outline-secondary"  size="sm" @click="decreaseQty(item)" > - </BButton>
                    <BFormInput type="number" size="sm" class="text-center"
                      v-model.number="item.quantity"
                      @input="quantityChanged(item)"
                      min="1"
                      :max="item.current_stock" />
                    <BButton variant="outline-secondary"  size="sm"@click="increaseQty(item)" > + </BButton>
                  </div>
                </td>
                <td>
                  <BFormInput v-model="item.reason" placeholder="Reason" />
                </td>
                <!-- <td>
                  <BFormTextarea v-model="item.remarks"  rows="1" placeholder="Remarks"/>
                </td> -->
                <!-- Unit Cost -->
                <td class="text-end"> {{ item.unit_cost }} </td>
                <!-- Total -->
                <td class="text-end"> {{ item.total_cost }} </td>
                <!-- Action -->
                <td class="text-center">
                  <BButton  variant="danger" size="sm" @click="removeProduct(index)" >
                    <i class="fa fa-trash"></i>
                  </BButton>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <!-- EMPTY -->
        <div v-else class="text-center text-muted py-4" > No products added yet </div>
        <!-- SUMMARY -->
        <div class="row mt-4">
          <div class="col-md-6">
            <div class="p-3 bg-light rounded" >
              <p class="mb-1"> Total Items:
                <strong> {{ totalItems }} </strong>
              </p>
              <p class="mb-0">
                Total Cost:
                <strong> {{ totalCost }} </strong>
              </p>
            </div>
          </div>
          <div class="col-md-6 text-end">
            
            <BButton  variant="danger" :disabled="isSubmitting" @click="submit" >
              <i class="fa fa-save me-1"></i>  Save Wastage
            </BButton>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>