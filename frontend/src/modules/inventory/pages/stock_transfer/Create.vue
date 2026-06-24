<script setup>
import { ref, computed, watch } from 'vue'
import { useRouter } from 'vue-router'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm, formatCurrency, dbDataFormat } from '@/utilities/methods'

const router = useRouter()

const bUrl = 'inventory/customer-payment'
const title = 'Customer Payment'
const selectedCustomer = ref(null)

const {

  create,
  isSubmitting,
  formErrors
} = useResourceApiClient(bUrl, title, true)

const { form } = useForm({
  customer_id: null,
  payment_date: new Date(),
  payment: 0,
  adjustment: 0,
  note: '',
})

const num = (v) => Number(v || 0)





/* ----------------------------------
| INVOICE STATE
---------------------------------- */
const selectedInvoice = ref(null)



watch(selectedCustomer, (customer) => {

  form.value.customer_id = customer?.id || null
  form.value.payment = 0
  form.value.adjustment = 0

  // ❗ if invoice does not belong to this customer → reset
  if (
    selectedInvoice.value &&
    selectedInvoice.value.customer_id !== customer?.id
  ) {
    selectedInvoice.value = null

  }
})








/* ----------------------------------
| CUSTOMER DUE
---------------------------------- */
const customerBalance = computed(() =>
  num(selectedCustomer.value?.balance)
)

const customerDue = computed(() =>
  customerBalance.value < 0
    ? -customerBalance.value
    : 0
)




const syncSplit = (e) => {
  const payment = Math.min(
    num(e.target.value),
    customerDue.value
  )

  form.value.payment = payment
  e.target.value = payment

  // adjustment 
  const remainingDue = customerDue.value - payment

  if (form.value.adjustment > remainingDue) {
    form.value.adjustment = remainingDue
  }
}

const syncAdjustment = (e) => {
  const maxAdjustment =
    customerDue.value - form.value.payment

  const adjustment = Math.min(
    Number(e.target.value || 0),
    maxAdjustment
  )

  form.value.adjustment = adjustment
  e.target.value = adjustment
}





/* ----------------------------------
| SUBMIT
---------------------------------- */
const errors = ref([])
const submit = async () => {
  form.value.payment_date = dbDataFormat(form.value.payment_date)

  let message = `${title} created successfully`

  try {
    if (form.value.id) {
      message = `${title} updated successfully`
      await update(form.value.id, form.value, false, false)
    } else {
      await create(form.value, '', false, false)
    }

    sessionStorage.setItem(
      'customerPaymentToastMessage',
      JSON.stringify({
        message,
        type: 'success'
      })
    )

    router.push(`/inventory/customer-due-payment`)
  } catch (error) {
    errors.value = formErrors.value
  }
}


</script>

<template>
  <div class="transfer-form">
    <div class="card shadow-sm">
      <div class="header d-flex align-items-center gap-2">
            <div class="icon-box">
                <i class="fas fa-random"></i>
            </div>
            <div>
                <h5 class="mb-0">Branch Transfer</h5>
                <small>Product Transfer</small>
            </div>
        </div>
        <div class="card-body p-4">
           <!-- TOP SECTION -->
            <div class="row g-3 mb-4">

               

                <!-- To Branch -->
                <div class="col-md-6">
                    <label class="form-label">
                        <i class="fas fa-hospital-user"></i> To Branch
                    </label>
                    <select class="form-select">
                        <option>Select Branch</option>
                        <option>Branch B</option>
                        <option>Branch C</option>
                    </select>
                </div>

                <!-- Date -->
                <div class="col-md-4">
                    <label class="form-label">
                        <i class="fas fa-calendar"></i> Transfer Date
                    </label>
                    <input type="date" class="form-control">
                </div>

            </div>
             <!-- PRODUCT TABLE -->
            <div class="table-responsive">

                <table class="table table-bordered align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Product</th>
                            <th width="200">Stock</th>
                            <th width="200">Qty</th>
                            <th width="100" class="text-center">Remove</th>
                        </tr>
                    </thead>

                    <tbody id="productTable">
                        <tr>
                            <td>
                                <select class="form-select">
                                    <option>Select Product</option>
                                    <option>Product A</option>
                                    <option>Product B</option>
                                </select>
                            </td>

                            <td>
                                <input type="text" class="form-control" disabled placeholder="Stock">
                            </td>

                            <td>
                                <input type="number" class="form-control" placeholder="Qty">
                            </td>

                            <td class="text-center">
                                <button class="btn btn-sm btn-danger m-auto">
                                    <i class="fa fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>

            </div>
             <!-- ACTION BUTTONS -->
            <div class="d-flex justify-content-between mt-3">

                <button class="btn btn-add">
                    <i class="fa fa-plus"></i> Add Product
                </button>

                <button class="btn btn-transfer px-4">
                    <i class="fa fa-paper-plane"></i> Transfer Stock
                </button>

            </div>
        </div>
    </div>
  </div>


  
</template>
<style scoped>
  .transfer-form{
      background:#f4f6f9;
  }

  .transfer-form .card{
      border:0;
      border-radius:12px;
      box-shadow:0 2px 10px rgba(0,0,0,0.05);
  }

  .transfer-form .header{
      background:linear-gradient(135deg,#0d6efd,#0a58ca);
      color:#fff;
      padding:14px 16px;
      border-radius:12px 12px 0 0;
  }

  .transfer-form .icon-box{
      width:36px;
      height:36px;
      background:#e9f2ff;
      display:flex;
      align-items:center;
      justify-content:center;
      border-radius:8px;
      color:#0d6efd;
  }

  .transfer-form .btn-add{
      background:#198754;
      color:#fff;
      border:0;
  }

  .transfer-form .btn-transfer{
      background:linear-gradient(135deg,#0d6efd,#0a58ca);
      color:#fff;
      border:0;
  }
</style>
