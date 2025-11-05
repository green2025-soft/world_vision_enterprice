import { ref, watch, computed } from 'vue'

// ───── Utility helpers ─────
const baseAmount = (p) => Math.max((p.quantity || 0) * (p.purchase_price || 0), 0)
const percentToAmount = (percent, base) =>
  Math.min(Math.max((percent || 0) / 100 * base, 0), base)
const amountToPercent = (amount, base) =>
  base ? Math.min(Math.max((amount || 0) / base * 100, 0), 100) : 0
const clamp = (val, min, max) => Math.min(Math.max(val, min), max)
const almostEqual = (a, b) => Math.abs(a - b) < 0.0001

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
    unit_price: 0,
    cost_price: 0,
    sale_price: 0,
    discount_percent: 0,
    discount_amount: 0,
    tax_percent: 0,
    tax_amount: 0,
    stock: 0,
  })

  const productInput = ref(defaultProductInput())
  const updatingDiscount = ref(false)
  const updatingTax = ref(false)
  const updatingFormDiscount = ref(false)
  const updatingFormTax = ref(false)

  // ───── Product Select ─────
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
    productInput.value =
      editingIndex.value !== null
        ? { ...productInput.value, ...baseData }
        : { ...defaultProductInput(), ...baseData }
  })

  // ───── Product-level Discount Sync ─────
  const syncProductValue = (field, type) => {
  const base =
    field === 'tax'
      ? Math.max(baseAmount(productInput.value) - productInput.value.discount_amount, 0)
      : baseAmount(productInput.value)

  if (type === 'percent') {

    const amount = (productInput.value[`${field}_percent`] / 100) * base
    productInput.value[`${field}_amount`] = +amount.toFixed(2)
  } else {

    const percent = base ? (productInput.value[`${field}_amount`] / base) * 100 : 0
    productInput.value[`${field}_percent`] = +percent.toFixed(2)
  }
}

  // ───── Supplier Watch ─────
  watch(selectedSupplier, (supplier) => {
    form.value.supplier_id = supplier?.id || ''
  })

  const supplierBalance = computed(() => parseFloat(selectedSupplier.value?.balance || 0))
  const supplierDue = computed(() => supplierBalance.value < 0 ? Math.abs(supplierBalance.value) : 0)
  const supplierAdvance = computed(() => supplierBalance.value > 0 ? supplierBalance.value : 0)

  // ───── Add Product ─────
  const addProduct = () => {
    const input = { ...productInput.value }
    if (!input.product_id) return

    if (input.purchase_price <= 0 || input.sale_price <= 0) {
      alert('Unit Price and Sale Price are required and must be > 0.')
      return
    }

    input.unit_price = input.purchase_price
    input.cost_price =
      (input.purchase_price || 0) - (input.discount_amount || 0) + (input.tax_amount || 0)

    input.discount_amount = parseFloat(Number(input.discount_amount || 0).toFixed(2))
    input.discount_percent = parseFloat(Number(input.discount_percent || 0).toFixed(2))
    input.tax_amount = parseFloat(Number(input.tax_amount || 0).toFixed(2))
    input.tax_percent = parseFloat(Number(input.tax_percent || 0).toFixed(2))


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
    selectedProduct.value = {
      id: item.product_id,
      name: item.name,
      sku: item.sku,
      purchase_price: item.purchase_price,
      sale_price: item.sale_price,
      current_stock: item.stock,
    }
    productInput.value = { ...item }
    editingIndex.value = index
  }

  const removeItem = (index) => {
    form.value.items.splice(index, 1)
    if (editingIndex.value === index) resetProductInput()
  }

  const resetProductInput = () => {
    selectedProduct.value = null
    productInput.value = defaultProductInput()
    editingIndex.value = null
  }

  const calcSubTotal = (item) =>
    Math.max(baseAmount(item) - (item.discount_amount || 0), 0)
  const calcTotal = (item) =>
    calcSubTotal(item) + Math.max(item.tax_amount || 0, 0)

  // ───── Grand Totals ─────
  const totalTotal = computed(() =>
    form.value.items.reduce((sum, i) => sum + calcTotal(i), 0)
  )

  // ───── Form-level Discount / Tax Sync ─────
  

  const syncDiscountTax = (field, type) => {
    const base =
      field === 'tax'
        ? Math.max(totalTotal.value - form.value.discount_amount, 0)
        : totalTotal.value

    if (type === 'percent') {

      const amount = (form.value[`${field}_percent`] / 100) * base
      form.value[`${field}_amount`] = +amount.toFixed(2)
    } else {
      const percent = base ? (form.value[`${field}_amount`] / base) * 100 : 0
      form.value[`${field}_percent`] = +percent.toFixed(2)
    }
  }



  // ───── Net Payable (with supplier advance deduction) ─────
  const netPayable = computed(() => {
    let baseAmount = Math.max(totalTotal.value - form.value.discount_amount, 0) + Math.max(form.value.tax_amount, 0) - clamp(form.value.adjustment, 0, Infinity)

    if (supplierAdvance.value > 0) {
      const adjust = Math.min(baseAmount, supplierAdvance.value)
      form.value.advance_adjusted = adjust
      baseAmount -= adjust
    } else {
      form.value.advance_adjusted = 0
    }

    return parseFloat(Math.max(baseAmount, 0).toFixed(2))
  })

  // ───── Form-level clamps for auto-calculation ─────
  const updateFormClamps = () => {
    form.value.paid_amount = clamp(form.value.paid_amount, 0, netPayable.value)
    form.value.discount_amount = Math.min(form.value.discount_amount, totalTotal.value)
    form.value.tax_amount = Math.min(form.value.tax_amount, totalTotal.value - form.value.discount_amount)
    form.value.adjustment = clamp(form.value.adjustment, 0, totalTotal.value - form.value.discount_amount)
  }

  watch([netPayable, () => form.value.paid_amount, () => form.value.discount_amount, () => form.value.tax_amount, () => form.value.adjustment], updateFormClamps, { flush: 'post' })

  // ───── Totals for footer ─────
  const totalQuantity = computed(() =>
    form.value.items.reduce((sum, i) => sum + parseFloat(i.quantity || 0), 0)
  )
  const totalUnitPrice = computed(() =>
    form.value.items.reduce((sum, i) => sum + parseFloat(i.purchase_price || 0), 0)
  )
  const totalSalePrice = computed(() =>
    form.value.items.reduce((sum, i) => sum + parseFloat(i.sale_price || 0), 0)
  )
  const totalDiscAmount = computed(() =>
    form.value.items.reduce((sum, i) => sum + parseFloat(i.discount_amount || 0), 0)
  )
  const totalTaxAmount = computed(() =>
    form.value.items.reduce((sum, i) => sum + parseFloat(i.tax_amount || 0), 0)
  )
  const totalSubTotal = computed(() =>
    form.value.items.reduce((sum, i) => sum + calcTotal(i), 0)
  )

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
    totalQuantity,
    totalUnitPrice,
    totalSalePrice,
    totalDiscAmount,
    totalTaxAmount,
    totalSubTotal,
    syncDiscountTax,
    syncProductValue
  }
}
