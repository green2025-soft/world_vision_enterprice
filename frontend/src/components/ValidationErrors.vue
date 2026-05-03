<script setup>
import { computed, ref, watch } from 'vue'

const props = defineProps({
  errors: { type: Object, default: () => ({}) },
  labels: { type: Object, default: () => ({}) },
})

const localErrors = ref({})

watch(
  () => props.errors,
  (val) => {
    localErrors.value = { ...val }
  },
  { immediate: true, deep: true }
)

const hasErrors = computed(() =>
  Object.keys(localErrors.value).length > 0
)

const formattedErrors = computed(() => {
  const output = {}

  for (const field in localErrors.value) {
    const messages = localErrors.value[field]
    output[field] = Array.isArray(messages) ? messages : [messages]
  }

  return output
})

const fieldLabel = (field) => field
  .replace(/_id$/, '')
  .replace(/_/g, ' ')
  .replace(/\b\w/g, l => l.toUpperCase())
</script>

<template>
  <div
    v-if="hasErrors"
    class="alert alert-danger alert-dismissible fade show position-relative"
    role="alert"
  >
    <ul class="mb-0">
      <li v-for="(messages, field) in formattedErrors" :key="field">
        <strong>{{ fieldLabel(field) }}:</strong>
        {{ messages.join(', ') }}
      </li>
    </ul>

    <button
      type="button"
      class="btn-close position-absolute top-0 end-0 m-2"
      @click="localErrors = {}"
    />
  </div>
</template>