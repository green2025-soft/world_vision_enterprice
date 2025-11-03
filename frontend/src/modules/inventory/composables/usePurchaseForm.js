import { ref, watch, computed } from 'vue'

// ───── Utility Functions ─────
const baseAmount = (p) => Math.max((p.quantity || 0) * (p.purchase_price || 0), 0)
const percentToAmount = (percent, base) => Math.min(Math.max((percent || 0) / 100 * base, 0), base)
const amountToPercent = (amount, base) => base ? Math.min(Math.max((amount || 0) / base * 100, 0), 100) : 0
const clamp = (val, min, max) => Math.min(Math.max(val, min), max)

// Generic two-way sync for discount/tax
function syncAmountPercent(target, baseFn, keyAmount, keyPercent, flag) {
  watch(
    () => target[keyPercent],
    (val) => {
      if (flag.value) return
      flag.value = true
      const base = baseFn()
      target[keyAmount] = percentToAmount(val, base)
      flag.value = false
    }
  )

  watch(
    () => target[keyAmount],
    (val) => {
      if (flag.value) return
      flag.value = true
      const base = baseFn()
      target[keyAmount] = Math.min(val, base)
      target[keyPercent] = amountToPercent(target[keyAmount], base)
      flag.value = false
    }
  )
}

export function usePurchaseForm() {
  const form = ref({
    supplier_id: '',
    invoice_date: new Date(),
    note: '',
    discount_percent: 0,
    discount_amount: 0,
    tax_percent: 0,
    tax_amount: 0,
    adjustment: 0,
    paid_amount: 0,
    advance_adjusted: 0,
    items: []
  })

  const selectedProduct = ref(null)
  const editingIndex = ref(null)
  const selectedSupplier = ref(null)

  const defaultProductInput = () => ({
    product_id: null,
    name: '',
    sku: '',
    quantity: 1,
    purchase_price: 0,
    unit_price:0,
    cost_price:0,
    sale_price: 0,
    discount_percent: 0,
    discount_amount: 0,
    tax_percent: 0,
    tax_amount: 0,
    stock: 0,
  })

  const productInput = ref(defaultProductInput())

  // ───── Product Select Sync ─────
  watch(selectedProduct, (newVal) => {
    if (!newVal) return
    const baseData = {
      product_id: newVal.id,
      name: newVal.name,
      sku: newVal.sku,
      purchase_price: parseFloat(newVal.purchase_price || 0),
      sale_price: parseFloat(newVal.sale_price || 0),
      stock: newVal.current_stock || 0,
      quantity: productInput.value.quantity || 1,
    }
    productInput.value = editingIndex.value !== null
      ? { ...productInput.value, ...baseData }
      : { ...defaultProductInput(), ...baseData }
  })

  // ───── Product-level Discount/Tax Sync ─────
  const updatingDiscount = ref(false)
  const updatingTax = ref(false)
  syncAmountPercent(
    productInput.value,
    () => baseAmount(productInput.value),
    'discount_amount',
    'discount_percent',
    updatingDiscount
  )
  syncAmountPercent(
    productInput.value,
    () => Math.max(baseAmount(productInput.value) - productInput.value.discount_amount, 0),
    'tax_amount',
    'tax_percent',
    updatingTax
  )

  // ───── Supplier Watch ─────
  watch(selectedSupplier, (s) => form.value.supplier_id = s?.id || '')
  const supplierBalance = computed(() => parseFloat(selectedSupplier.value?.balance || 0))
  const supplierDue = computed(() => Math.max(-supplierBalance.value, 0))
  const supplierAdvance = computed(() => Math.max(supplierBalance.value, 0))

  // ───── Product Functions ─────
  const resetProductInput = () => {
    selectedProduct.value = null
    productInput.value = defaultProductInput()
    editingIndex.value = null
  }

const addProduct = () => {
  const input = { ...productInput.value }
  if (!input.product_id) return

  if (input.purchase_price <= 0 || input.sale_price <= 0) {
    alert('Unit Price and Sale Price are required and must be > 0.')
    return
  }

  // Calculate unit_price and cost_price
  input.unit_price = input.purchase_price
  input.cost_price = input.purchase_price - (input.discount_amount || 0)

  const duplicateIndex = form.value.items.findIndex(
    (i, idx) => i.product_id === input.product_id && idx !== editingIndex.value
  )

  if (duplicateIndex !== -1) {
    const existing = form.value.items[duplicateIndex]
    form.value.items[duplicateIndex] = {
      ...existing,
      ...input,
      quantity: existing.quantity + input.quantity
    }

    if (editingIndex.value !== null && editingIndex.value !== duplicateIndex) {
      form.value.items.splice(editingIndex.value, 1)
    }
  } else {
    if (editingIndex.value !== null) {
      form.value.items[editingIndex.value] = input
    } else {
      form.value.items.push(input)
    }
  }

  resetProductInput()
}


  const editItem = (index) => {
    const item = form.value.items[index]
    selectedProduct.value = { id: item.product_id, name: item.name, sku: item.sku, purchase_price: item.purchase_price, sale_price: item.sale_price, current_stock: item.stock }
    productInput.value = { ...item }
    editingIndex.value = index
  }

  const removeItem = (index) => {
    form.value.items.splice(index, 1)
    if (editingIndex.value === index) resetProductInput()
  }

  // ───── Calculations ─────
  const calcSubTotal = (item) => Math.max(baseAmount(item) - (item.discount_amount || 0), 0)
  const calcTotal = (item) => calcSubTotal(item) + Math.max(item.tax_amount || 0, 0)
  const totalTotal = computed(() => form.value.items.reduce((sum, i) => sum + calcTotal(i), 0))

  // ───── Form-level Discount/Tax Sync ─────
  const updatingFormDiscount = ref(false)
  const updatingFormTax = ref(false)
  syncAmountPercent(form.value, () => totalTotal.value, 'discount_amount', 'discount_percent', updatingFormDiscount)
  syncAmountPercent(form.value, () => Math.max(totalTotal.value - form.value.discount_amount, 0), 'tax_amount', 'tax_percent', updatingFormTax)

  // ───── Net Payable ─────
  const netPayable = computed(() => {
    let amount = Math.max(totalTotal.value - form.value.discount_amount, 0) + Math.max(form.value.tax_amount, 0) - clamp(form.value.adjustment, 0, Infinity)
    const advance = Math.min(amount, supplierAdvance.value)
    form.value.advance_adjusted = advance
    return parseFloat(Math.max(amount - advance, 0).toFixed(2))
  })

  // ───── Clamp Paid/Adjustment ─────
  watch([netPayable, () => form.value.paid_amount], () => {
    form.value.paid_amount = clamp(form.value.paid_amount, 0, netPayable.value)
  })
  watch([netPayable, () => form.value.adjustment], () => {
    form.value.adjustment = clamp(form.value.adjustment, 0, netPayable.value)
  })

  return {
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
    netPayable,
  }
}
