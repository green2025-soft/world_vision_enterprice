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
  
    <div class="row">
      <div class="col-lg-12">
        <div class="row">
          <div class="col-md-7">
            <div class="card border-0 shadow-sm">
              <div class="card-body">
                
                <ValidationErrors :errors="errors" />
                  <div class="mb-3">
                    <label class="form-label fw-bold">
                      <i class="fas fa-user me-1"></i>Select Customer <code>*</code>
                    </label>
                    <ResourceSelect
                    v-model="selectedCustomer"
                    bUrl="inventory/customers/balances"
                    placeholder="Select Customer"
                    :isBranch="true"
                    :emitObject="true"
                    :labelField="(item) => `${item.name} (${item.phone})`"
                    style="width:100%"
                  />
                </div>
                <div class="row mb-3">
                  <div class="col-md-4">
                    <label class="form-label fw-bold">Payment Amount<code>*</code></label>
                    <BFormInput type="number" v-model="form.payment" :max="customerDue"  @input="syncSplit" placeholder="Enter payment amount" />
                    
                  </div>
                  <div class="col-md-4">
                    <label class="form-label fw-bold">Adjustment</label>
                    <BFormInput type="number" v-model="form.adjustment" @input="syncAdjustment" placeholder="Enter adjustment amount" />
                  </div>
                  <div class="col-md-4">
                    <label class="form-label fw-bold">Payment Date<code>*</code></label>
                    <DatePicker v-model="form.payment_date" />
                  </div>
                </div>
               

                  <label class="form-label fw-bold">
                    Note
                  </label>

                  <textarea
                    class="form-control"
                    rows="3"
                    v-model="form.note"
                  ></textarea>

             
              </div>
              <div class="card-footer text-end">
                <LoadingButton
                :loading="isSubmitting"
                variant="primary"
                @click="submit"
              >
                <i class="fas fa-save me-1"></i> Save Payment
              </LoadingButton>
              </div>
            </div>
          </div>
          <div class="col-md-5">
            
              <div class="current-due-card mb-3 current-due">
                <div>
                    <span class="label">Current Due</span>
                    <h3 class="amount">{{ formatCurrency(customerDue - (num(form.payment) + num(form.adjustment))) }}</h3>
                </div>

                <div class="icon">
                    <i class="fas fa-wallet"></i>
                </div>
              </div>
              <div class="current-due-card mb-3">
                <div>
                    <span class="label">Customer Total  Due</span>
                    <h3 class="amount">{{ formatCurrency(customerDue) }}</h3>
                </div>

                <div class="icon">
                    <i class="fas fa-file-invoice-dollar"></i>
                </div>
              </div>
              <div class="card border-info " v-if="selectedCustomer">
                  <div class="card-body">
                    <div class="row">
                      <div class="col-md-7 mb-1">
                        <small class="text-muted d-block">Customer Name</small>
                        <strong>{{selectedCustomer?.name??''}}</strong>
                      </div>
                      <div class="col-md-5 mb-1">
                        <small class="text-muted d-block">Mobile</small>
                        <strong>
                          <i class="fas fa-phone-alt text-success me-1"></i>{{ selectedCustomer?.phone??'' }}
                        </strong>
                      </div>
                      <div class="col-md-12 mb-1">
                        <small class="text-muted d-block">Address</small>
                        <strong>{{ selectedCustomer?.address??'' }}</strong>
                      </div>
                      
                    </div>
                  </div>
                </div>
          </div>
        </div>
        
      </div>
    </div> 
  
</template>
<style scoped>
.current-due-card{
    background: linear-gradient(135deg,#fff5f5,#ffeaea);
    border: 1px solid #ffb8b8;
    border-left: 5px solid #dc3545;
    border-radius: 10px;
    padding: 15px 18px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.current-due-card .label{
    color:#6c757d;
    font-size:14px;
    display:block;
}

.current-due-card .amount{
    color:#dc3545;
    font-weight:700;
    margin:0;
}

.current-due-card .icon{
    color:#dc3545;
    font-size:28px;
    opacity:.8;
}

.current-due {
    background: linear-gradient(135deg,#f2fff5,#eaffea);
    border: 1px solid #8be28b;
    border-left: 5px solid #28a745;
}

.current-due .amount,
.current-due .icon {
    color: #28a745;
}
</style>
