<!-- src/components/ValidationErrors.vue -->
<template>
  <div v-if="hasErrors" class="alert alert-danger">
    <ul class="mb-0">
      <li v-for="(messages, field) in formattedErrors" :key="field">
        <strong>{{ fieldLabel(field) }}:</strong> {{ messages.join(', ') }}
      </li>
    </ul>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  errors: { type: Object, default: () => ({}) },
  labels: { type: Object, default: () => ({}) },
})

const hasErrors = computed(() => Object.keys(props.errors).length > 0)

const formattedErrors = computed(() => {
  const output = {}
  for (const field in props.errors) {
    const messages = props.errors[field]
    output[field] = Array.isArray(messages) ? messages : [messages]
  }
  return output
})

const fieldLabel = (field) => props.labels[field] || field
</script>
