<script setup>
import { ref, computed, watch } from 'vue'
import { useRouter } from 'vue-router'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm, formatCurrency, dbDataFormat } from '@/utilities/methods'

const router = useRouter()

const bUrl = 'inventory/purchase-return'
const title = 'Purchase Return'
const selectedSupplier = ref(null)

const {
  customGet,
  create,
  isSubmitting
} = useResourceApiClient(bUrl, title, true)

const { form } = useForm({
  supplier_id: null,
  return_date: new Date(),
  items: [],
  purchase_id: null,
  cash_return: 0,
  supplier_advance: 0,
  note: '',
})

const num = (v) => Number(v || 0)

const clamp = (v, min = 0, max = Infinity) =>
  Math.min(Math.max(num(v), min), max)

/* ----------------------------------
| LOAD Supplier
---------------------------------- */
const loadSupplierBalance = async (id) => {
  return await customGet(
    'inventory/suppliers/balances/' + id,
    {}
  )
}

/* ----------------------------------
| INVOICE STATE
---------------------------------- */
const selectedInvoice = ref(null)

const invoiceExtraParams = computed(() => ({
  supplier_id: form.value.supplier_id
}))

watch(selectedSupplier, (supplier) => {

  form.value.supplier_id = supplier?.id || null

  // ❗ if invoice does not belong to this supplier → reset
  if (
    selectedInvoice.value &&
    selectedInvoice.value.supplier_id !== supplier?.id
  ) {
    selectedInvoice.value = null
    form.value.purchase_id = null
    form.value.items = []
  }
})

/* ----------------------------------
| INVOICE WATCH
---------------------------------- */
watch(selectedInvoice, async (invoice) => {

  form.value.items = []
  form.value.purchase_id = null

  if (!invoice) return

  form.value.purchase_id = invoice.id
  form.value.supplier_id = invoice.supplier_id

  const supplier = await loadSupplierBalance(invoice.supplier_id)
  selectedSupplier.value = supplier[0]

  form.value.items = (invoice.items || []).map(item => {

    const consumed = (invoice.stock_movements || [])
      .filter(m => m.product_id === item.product_id)
      .reduce((s, m) => s + num(m.consumed_quantity), 0)
      item.purchase_item_id = item.id

    return {
      ...item,

      purchase_qty: num(item.quantity),
      consumed_quantity: consumed,

      return_qty: 0,
      wastage_qty: 0,

      unit_price: num(item.unit_price),
      unit_purchase_price: num(item.unit_price),

      return_unit_price: num(item.unit_price),
      refund_total_price: 0,

      _source: null
    }
  })
})

/* ----------------------------------
| SYNC LOGIC
---------------------------------- */
const syncItem = (item, source = null) => {

  const purchase = num(item.purchase_qty)
  const consumed = num(item.consumed_quantity)
  const originalPrice = num(item.unit_price)

  /* -------------------------------
  | RETURN QTY
  ------------------------------- */
  const maxReturnQty =
    Math.max(
      0,
      purchase - (consumed + num(item.wastage_qty))
    )

  item.return_qty = clamp(item.return_qty, 0, maxReturnQty)

  /* -------------------------------
  | WASTAGE QTY
  ------------------------------- */
  const maxWastageQty =
    Math.max(
      0,
      purchase - (consumed + num(item.return_qty))
    )

  item.wastage_qty = clamp(item.wastage_qty, 0, maxWastageQty)

  /* -------------------------------
  | DEFAULT REFUND UNIT PRICE
  ------------------------------- */
  if (!item.return_unit_price) {
    item.return_unit_price = originalPrice
  }

  item.return_unit_price = clamp(
    item.return_unit_price,
    0,
    originalPrice
  )

  const maxRefundTotal =
    num(item.return_qty) * originalPrice

  /* -------------------------------
  | UNIT EDIT
  ------------------------------- */
  if (source === 'unit') {

    item.refund_total_price =
      num(item.return_qty) *
      num(item.return_unit_price)
  }

  /* -------------------------------
  | TOTAL EDIT
  ------------------------------- */
  else if (source === 'total') {

    item.refund_total_price = clamp(
      item.refund_total_price,
      0,
      maxRefundTotal
    )

    item.return_unit_price =
      num(item.return_qty)
        ? num(item.refund_total_price) /
          num(item.return_qty)
        : 0
  }

  /* -------------------------------
  | QTY CHANGE
  ------------------------------- */
  else {

    item.refund_total_price =
      num(item.return_qty) *
      num(item.return_unit_price)
  }

  /* -------------------------------
  | FINAL SAFETY
  ------------------------------- */
  item.refund_total_price = clamp(
    item.refund_total_price,
    0,
    maxRefundTotal
  )
}

/* ----------------------------------
| REMOVE ITEM
---------------------------------- */
const removeItem = (index) => {

  form.value.items.splice(index, 1)

  if (!form.value.items.length) {
    selectedInvoice.value = null
    form.value.supplier_id = null
  }
}

/* ----------------------------------
| TOTALS
---------------------------------- */
const refundTotal = computed(() =>
  form.value.items.reduce(
    (s, i) => s + num(i.refund_total_price) + ( num(i.wastage_qty) * num(i.unit_price)),
    0
  )
)




/* ----------------------------------
| Supplier DUE
---------------------------------- */
const supplierBalance = computed(() =>
  num(selectedSupplier.value?.balance)
)

const supplierDue = computed(() =>
  supplierBalance.value < 0
    ? -supplierBalance.value
    : 0
)

const supplierDueAdjusted = computed(() => {


  const totalRefund = refundTotal.value;


  const dueAdjust = supplierDue.value >= totalRefund ? totalRefund :  supplierDue.value
  form.value.due_adjusted = dueAdjust;
  

  return  dueAdjust
})

const cashRefund = computed(() => {

  const value =
    refundTotal.value - supplierDueAdjusted.value

  return value > 0 ? value : 0
})



watch(cashRefund, (val) => {

  form.value.cash_return = num(val)
  form.value.supplier_advance = 0

}, { immediate: true })


const syncSplit = (source) => {

  const total = num(cashRefund.value)

  // CASH edited
  if (source === 'cash') {

    let cash = num(form.value.cash_return)

    // clamp instantly
    if (cash > total) cash = total
    if (cash < 0) cash = 0

    form.value.cash_return = cash
    form.value.supplier_advance = total - cash
  }

  // ADVANCE edited
  else {

    let adv = num(form.value.supplier_advance)

    if (adv > total) adv = total
    if (adv < 0) adv = 0

    form.value.supplier_advance = adv
    form.value.cash_return = total - adv
  }
}


/* ----------------------------------
| SUBMIT
---------------------------------- */

const errors = ref([])
const submit = async () => {
  form.value.return_date = dbDataFormat(form.value.return_date)

  let message = `${title} created successfully`

  try {
    if (form.value.id) {
      message = `${title} updated successfully`
      await update(form.value.id, form.value, false, false)
    } else {
      await create(form.value, '', false, false)
    }

    sessionStorage.setItem(
      'purchaseReturnToastMessage',
      JSON.stringify({
        message,
        type: 'success'
      })
    )

    router.push(`/${bUrl}`)
  } catch (error) {
    errors.value = formErrors.value
  }
}



</script>

<template>


  

  <!-- Supplier + INVOICE -->
  <div class="card p-3 mb-3">
    

    <div class="row g-3">

      <!-- INVOICE -->
      <div class="col-md-4">

        <label class="form-label">
          Invoice No
          <code>*</code>
        </label>

        <ResourceSelect
          :key="form.supplier_id"
          v-model="selectedInvoice"
          bUrl="inventory/purchase-invoice-items"
          placeholder="Select Invoice No"
          :isBranch="true"
          :emitObject="true"
          :labelField="(item) => `${item.invoice_no} (${item.invoice_date})`"
          :extraParams="invoiceExtraParams"
          style="width:100%"
        />

      </div>

      <!-- Supplier -->
      <div class="col-md-4">
        

        <label class="form-label">
          Supplier
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

      <!-- DATE -->
      <div class="col-md-4">

        <label class="form-label">
          Return Date
          <code>*</code>
        </label>

        <DatePicker v-model="form.return_date" />

      </div>

    </div>

  </div>

  <!-- ITEMS -->
  <div class="card">

    <div class="table-responsive">
      
      <table class="table align-middle">

        <thead>
          <tr>
            <th>Product</th>

            <th class="text-center" width="90">Purchase Qty</th>
            <th class="text-center" width="100">Purchase Price</th>
            <!-- <th class="text-end"  width="120">Cost Price</th> -->

            <th class="text-center" width="120">
              Return Qty
            </th>

            <th class="text-center" width="120">
              Wastage Qty
            </th>

            <th class="text-end" width="130">
              Unit Price
            </th>

            <th class="text-end" width="130">
              Refund Price
            </th>


            <th width="60"></th>
          </tr>
        </thead>

        <tbody>
        <tr v-for="(item, index) in form.items" :key="item.purchase_item_id">

            <td>
            <strong>{{ item.product?.name }}</strong>   
            <small v-if="item.product?.sku "> ({{ item.product?.sku }})</small>
          
            </td>

            <!-- Purchase -->
            <td class="text-center">{{ item.purchase_qty }} 
              <span v-if="item.consumed_quantity >0" class="text-danger"> - ({{ item.consumed_quantity }})</span>
              
            </td>
            <td class="text-center">{{ item.unit_price }}</td>
            <!-- <td class="text-end">{{ item.cost_price }}</td> -->

            <!-- RETURN QTY -->
            <td class="text-center">
            <input
                type="number"
                class="form-control text-center"
                :max="item.purchase_qty - ((item.consumed_quantity || 0) + (item.wastage_qty || 0))"
                v-model.number="item.return_qty"
                @input="syncItem(item)"
            >
            </td>

            <!-- WASTAGE -->
            <td class="text-center">
            <input
                type="number"
                class="form-control text-center"
                v-model.number="item.wastage_qty"
                :max="item.purchase_qty - ((item.consumed_quantity || 0) + (item.return_qty || 0))"
                @input="syncItem(item)"
            >
            </td>

            <!-- UNIT PRICE -->
            <td class="text-end">
            <input
                type="number"
                class="form-control text-end"
                v-model.number="item.return_unit_price"
                 :max="item.unit_price"
                @input="
                item._source = 'unit';
                syncItem(item, 'unit')
                "
            >
            </td>

            <!-- REFUND PRICE -->
            <td class="text-end">
            <input
                type="number"
                class="form-control text-end"
                v-model.number="item.refund_total_price"
                :max="item.unit_price * item.wastage_qty"
                @input="
                item._source = 'total';
                syncItem(item, 'total')
                "
            >
            </td>

            <!-- COST -->
            

            <!-- REMOVE -->
            <td>
            <button class="btn btn-sm btn-danger" @click="removeItem(index)">
                x
            </button>
            </td>

        </tr>
        </tbody>

      </table>

    </div>

  </div>

  <!-- SUMMARY -->
  <div class="card p-3 mt-3">

    <div class="row">

      <!-- NOTE -->
      <div class="col-md-6">

        <label class="form-label">
          Note
        </label>

        <textarea
          class="form-control"
          rows="3"
          v-model="form.note"
        ></textarea>

      </div>

      <!-- SUMMARY -->
      <div class="col-md-6">

        <div class="d-flex justify-content-between mb-2">
          <span>Refund Total</span>

          <strong>
            {{ formatCurrency(refundTotal) }}
          </strong>
        </div>
        
        <div class="d-flex justify-content-between mb-2" v-if="supplierDue >0">
          <span>Supplier Due</span>

          <strong>
            {{ formatCurrency(supplierDue) }}
          </strong>
        </div>
        <div class="d-flex justify-content-between mb-2" v-if="supplierDueAdjusted >0">
          <span>Due Adjusted</span>

          <strong>
            {{ formatCurrency(supplierDueAdjusted) }}
          </strong>
        </div>
        <template v-if="cashRefund >0">
          <div class="d-flex justify-content-between mb-2">
            <span>Cash Return </span>

            <strong>
              <BFormInput size="sm" type="number" 
               v-model.number="form.cash_return"
              @input="syncSplit('cash')"
              :max="cashRefund - form.supplier_advance"
               />
            </strong>
          </div>
          <div class="d-flex justify-content-between mb-2">
            <span>Supplier Advance </span>

            <strong>
              <BFormInput size="sm" type="number"
               v-model.number="form.supplier_advance"
               @input="syncSplit('advance')"
                :max="cashRefund- form.cash_return"
               />
            </strong>
          </div>
        </template>





 

      </div>

    </div>
    <div class="bg-white text-end">
        <LoadingButton
        :loading="isSubmitting"
        variant="primary"
        @click="submit"
      >
         <i class="fas fa-save me-1"></i> Save Return
      </LoadingButton>
     
    </div>

  </div>

</template>

<style scoped>
.card {
  border: none;
  border-radius: 12px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.05);
}

.table th {
  background: #f1f3f5;
}

.qty-input {
  width: 90px;
}
</style>