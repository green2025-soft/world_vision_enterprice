<template>
  <b-form-select
    v-model="internalValue"
    :options="statusOptions"
  />
</template>

<script setup>
import { computed } from 'vue'

// ✅ defineProps 
const props = defineProps({
  modelValue: {
    type: [String, Number], // ✅ Accept both
    default: '1',
  },
})

// ✅ Emit event
const emit = defineEmits(['update:modelValue'])

// ✅ Options
const statusOptions = [
  { value: '1', text: 'Active' },
  { value: '0', text: 'In Active' },
]

// ✅ Computed binding
const internalValue = computed({
  get: () => props.modelValue,
  set: (val) => emit('update:modelValue', val),
})
</script>
