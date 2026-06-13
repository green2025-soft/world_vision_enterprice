<script setup>
import { ref, computed, watch } from 'vue'
import { useRouter } from 'vue-router'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm, formatCurrency, dbDataFormat } from '@/utilities/methods'

const router = useRouter()

const bUrl = 'inventory/supplier-payment'
const title = 'Supplier Payment'
const selectedSupplier = ref(null)

const {

  create,
  isSubmitting,
  formErrors
} = useResourceApiClient(bUrl, title, true)

const { form } = useForm({
  supplier_id: null,
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



watch(selectedSupplier, (supplier) => {

  form.value.supplier_id = supplier?.id || null
  form.value.payment = 0
  form.value.adjustment = 0

  // ❗ if invoice does not belong to this supplier → reset
  if (
    selectedInvoice.value &&
    selectedInvoice.value.supplier_id !== supplier?.id
  ) {
    selectedInvoice.value = null

  }
})








/* ----------------------------------
| Supplier Due
---------------------------------- */
const supplierBalance = computed(() =>
  num(selectedSupplier.value?.balance)
)

const supplierDue = computed(() =>
  supplierBalance.value < 0
    ? -supplierBalance.value
    : 0
)




const syncSplit = (e) => {
  const payment = Math.min(
    num(e.target.value),
    supplierDue.value
  )

  form.value.payment = payment
  e.target.value = payment

  // adjustment 
  const remainingDue = supplierDue.value - payment

  if (form.value.adjustment > remainingDue) {
    form.value.adjustment = remainingDue
  }
}

const syncAdjustment = (e) => {
  const maxAdjustment =
    supplierDue.value - form.value.payment

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
      'supplierPaymentToastMessage',
      JSON.stringify({
        message,
        type: 'success'
      })
    )

    router.push(`/inventory/supplier-due-payment`)
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
                      <i class="fas fa-user me-1"></i>Select Supplier <code>*</code>
                    </label>
                    <ResourceSelect
                    v-model="selectedSupplier"
                    bUrl="inventory/suppliers/balances"
                    placeholder="Select Supplier"
                    :isBranch="true"
                    :emitObject="true"
                    :labelField="(item) => `${item.name} (${item.phone})`"
                    style="width:100%"
                  />
                </div>
                <div class="row mb-3">
                  <div class="col-md-4">
                    <label class="form-label fw-bold">Payment Amount<code>*</code></label>
                    <BFormInput type="number" v-model="form.payment" :max="supplierDue"  @input="syncSplit" placeholder="Enter payment amount" />
                    
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
                    <h3 class="amount">{{ formatCurrency(supplierDue - (num(form.payment) + num(form.adjustment))) }}</h3>
                </div>

                <div class="icon">
                    <i class="fas fa-wallet"></i>
                </div>
              </div>
              <div class="current-due-card mb-3">
                <div>
                    <span class="label">Supplier Total  Due</span>
                    <h3 class="amount">{{ formatCurrency(supplierDue) }}</h3>
                </div>

                <div class="icon">
                    <i class="fas fa-file-invoice-dollar"></i>
                </div>
              </div>
              <div class="card border-info " v-if="selectedSupplier">
                  <div class="card-body">
                    <div class="row">
                      <div class="col-md-7 mb-1">
                        <small class="text-muted d-block">Supplier Name</small>
                        <strong>{{selectedSupplier?.name??''}}</strong>
                      </div>
                      <div class="col-md-5 mb-1">
                        <small class="text-muted d-block">Mobile</small>
                        <strong>
                          <i class="fas fa-phone-alt text-success me-1"></i>{{ selectedSupplier?.phone??'' }}
                        </strong>
                      </div>
                      <div class="col-md-12 mb-1">
                        <small class="text-muted d-block">Address</small>
                        <strong>{{ selectedSupplier?.address??'' }}</strong>
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
