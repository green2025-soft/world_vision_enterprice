<template>
  <div>
    <BFormInput
      :model-value="modelValue"
      :placeholder="placeholder"
      @update:modelValue="updateValue"
      @keypress="onKeyPress"
      @blur="validate"
    />
    <small v-if="errorMessage" class="text-danger">{{ errorMessage }}</small>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue'

// Props
const props = defineProps({
  modelValue: [String, Number],
  placeholder: { type: String, default: '' },
  required: { type: Boolean, default: false },
})

// Emit
const emit = defineEmits(['update:modelValue'])

// Local state and error message
const errorMessage = ref('')
const localValue = ref(props.modelValue ?? '')

// Watch for external modelValue changes
watch(() => props.modelValue, (val) => {
  localValue.value = val
})

// Emit updated value
const updateValue = (val) => {
  localValue.value = val
  emit('update:modelValue', val)
}

// Keypress validation (same as jQuery version)
const onKeyPress = (event) => {
  const charCode = event.which ?? event.keyCode
  const charStr = String.fromCharCode(charCode)
  const currentVal = event.target.value

  const isDecimal = charStr === '.'
  const alreadyHasDecimal = currentVal.includes('.')
  const isDigit = /[0-9]/.test(charStr)

  if (
    (!isDigit && !isDecimal) ||
    (isDecimal && alreadyHasDecimal)
  ) {
    event.preventDefault()
  }
}

// Validate only on blur or manual call
const validate = () => {
  const val = localValue.value.toString().trim()
  const numberPattern = /^[0-9]+(\.[0-9]{1,2})?$/

  if (props.required && !val) {
    errorMessage.value = 'This field is required'
    return
  }

  if (val && !numberPattern.test(val)) {
    errorMessage.value = 'Enter a valid amount (e.g. 100.50)'
    return
  }

  if (parseFloat(val) < 0) {
    errorMessage.value = 'Amount must be positive'
    return
  }

  errorMessage.value = ''
}
</script>
