<script setup>
import { ref, computed, watch } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm, formatCurrency } from '@/utilities/methods'

const bUrl = 'inventory/purchases'
const selectedCustomer = ref(null)

const {
  customGet,
  create,
  isSubmitting
} = useResourceApiClient(bUrl, 'Sale Return', true)

const { form } = useForm({
  customer_id: null,
  return_date: new Date(),
  items: [],
  sale_id: null,
   cash_return: 0,
  customer_advance: 0,
  note: '',
})

const num = (v) => Number(v || 0)

const clamp = (v, min = 0, max = Infinity) =>
  Math.min(Math.max(num(v), min), max)

/* ----------------------------------
| LOAD CUSTOMER
---------------------------------- */
const loadCustomerBalance = async (id) => {
  return await customGet(
    'inventory/customers/balances/' + id,
    {}
  )
}

/* ----------------------------------
| INVOICE STATE
---------------------------------- */
const selectedInvoice = ref(null)

const invoiceExtraParams = computed(() => ({
  customer_id: form.value.customer_id
}))

watch(selectedCustomer, (customer) => {

  form.value.customer_id = customer?.id || null

  // ❗ if invoice does not belong to this customer → reset
  if (
    selectedInvoice.value &&
    selectedInvoice.value.customer_id !== customer?.id
  ) {
    selectedInvoice.value = null
    form.value.sale_id = null
    form.value.items = []
  }
})

/* ----------------------------------
| INVOICE WATCH
---------------------------------- */
watch(selectedInvoice, async (invoice) => {

  form.value.items = []
  form.value.sale_id = null

  if (!invoice) return

  form.value.sale_id = invoice.id
  form.value.customer_id = invoice.customer_id

  const customer = await loadCustomerBalance(invoice.customer_id)
  selectedCustomer.value = customer[0]

  form.value.items = (invoice.items || []).map(item => {

    const consumed = (invoice.stock_movements || [])
      .filter(m => m.product_id === item.product_id)
      .reduce((s, m) => s + num(m.consumed_quantity), 0)

    return {
      ...item,

      sold_qty: num(item.quantity),
      consumed_quantity: consumed,

      return_qty: 0,
      wastage_qty: 0,

      unit_price: num(item.unit_price),
      unit_sale_price: num(item.unit_price),

      refund_unit_price: num(item.unit_price),
      refund_total_price: 0,

      _source: null
    }
  })
})

/* ----------------------------------
| SYNC LOGIC
---------------------------------- */
const syncItem = (item, source = null) => {

  const sold = num(item.sold_qty)
  const consumed = num(item.consumed_quantity)
  const originalPrice = num(item.unit_price)

  /* -------------------------------
  | RETURN QTY
  ------------------------------- */
  const maxReturnQty =
    Math.max(
      0,
      sold - (consumed + num(item.wastage_qty))
    )

  item.return_qty = clamp(item.return_qty, 0, maxReturnQty)

  /* -------------------------------
  | WASTAGE QTY
  ------------------------------- */
  const maxWastageQty =
    Math.max(
      0,
      sold - (consumed + num(item.return_qty))
    )

  item.wastage_qty = clamp(item.wastage_qty, 0, maxWastageQty)

  /* -------------------------------
  | DEFAULT REFUND UNIT PRICE
  ------------------------------- */
  if (!item.refund_unit_price) {
    item.refund_unit_price = originalPrice
  }

  item.refund_unit_price = clamp(
    item.refund_unit_price,
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
      num(item.refund_unit_price)
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

    item.refund_unit_price =
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
      num(item.refund_unit_price)
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
    form.value.sale_id = null
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

const customerDueAdjusted = computed(() => {

  const wastageSaleAmount =
    form.value.items.reduce((s, i) =>
      s +
      num(i.wastage_qty) *
      num(i.unit_sale_price),
    0
  )

  const totalRefund = refundTotal.value + wastageSaleAmount
  
  return  customerDue.value >= totalRefund ? totalRefund :  customerDue.value 
})

const cashRefund = computed(() => {

  const value =
    refundTotal.value - customerDueAdjusted.value

  return value > 0 ? value : 0
})



watch(cashRefund, (val) => {

  form.value.cash_return = num(val)
  form.value.customer_advance = 0

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
    form.value.customer_advance = total - cash
  }

  // ADVANCE edited
  else {

    let adv = num(form.value.customer_advance)

    if (adv > total) adv = total
    if (adv < 0) adv = 0

    form.value.customer_advance = adv
    form.value.cash_return = total - adv
  }
}


/* ----------------------------------
| SUBMIT
---------------------------------- */
const submit = async () => {
  // await create(form.value)
}


</script>

<template>


  

  <!-- CUSTOMER + INVOICE -->
  <div class="card p-3 mb-3">
    

    <div class="row g-3">

      <!-- INVOICE -->
      <div class="col-md-4">

        <label class="form-label">
          Invoice No
          <code>*</code>
        </label>

        <ResourceSelect
          :key="form.customer_id"
          v-model="selectedInvoice"
          bUrl="inventory/sale-invoice-items"
          placeholder="Select Invoice No"
          :isBranch="true"
          :emitObject="true"
          :labelField="(item) => `${item.invoice_no} (${item.invoice_date})`"
          :extraParams="invoiceExtraParams"
          style="width:100%"
        />

      </div>

      <!-- CUSTOMER -->
      <div class="col-md-4">
        

        <label class="form-label">
          Customer
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

            <th class="text-center" width="90">Sold Qty</th>
            <th class="text-center" width="100">Sold Price</th>
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
        <tr v-for="(item, index) in form.items" :key="item.sale_item_id">

            <td>
            <strong>{{ item.product?.name }}</strong>   
            <small v-if="item.product?.sku "> ({{ item.product?.sku }})</small>
          
            </td>

            <!-- SOLD -->
            <td class="text-center">{{ item.sold_qty }}</td>
            <td class="text-center">{{ item.unit_price }}</td>
            <!-- <td class="text-end">{{ item.cost_price }}</td> -->

            <!-- RETURN QTY -->
            <td class="text-center">
            <input
                type="number"
                class="form-control text-center"
                :max="item.sold_qty - ((item.consumed_quantity || 0) + (item.wastage_qty || 0))"
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
                :max="item.sold_qty - ((item.consumed_quantity || 0) + (item.return_qty || 0))"
                @input="syncItem(item)"
            >
            </td>

            <!-- UNIT PRICE -->
            <td class="text-end">
            <input
                type="number"
                class="form-control text-end"
                v-model.number="item.refund_unit_price"
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
        
        <div class="d-flex justify-content-between mb-2" v-if="customerDue >0">
          <span>Customer Due</span>

          <strong>
            {{ formatCurrency(customerDue) }}
          </strong>
        </div>
        <div class="d-flex justify-content-between mb-2" v-if="customerDueAdjusted >0">
          <span>Due Adjusted</span>

          <strong>
            {{ formatCurrency(customerDueAdjusted) }}
          </strong>
        </div>
        <template v-if="cashRefund >0">
          <div class="d-flex justify-content-between mb-2">
            <span>Cash Return </span>

            <strong>
              <BFormInput size="sm" type="number" 
               v-model.number="form.cash_return"
              @input="syncSplit('cash')"
              :max="cashRefund - form.customer_advance"
               />
            </strong>
          </div>
          <div class="d-flex justify-content-between mb-2">
            <span>Customer Advance </span>

            <strong>
              <BFormInput size="sm" type="number"
               v-model.number="form.customer_advance"
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