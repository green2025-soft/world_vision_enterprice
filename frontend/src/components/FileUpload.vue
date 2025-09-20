<template>
  <div>
    <label v-if="label" class="form-label">{{ label }}</label>
    <input
      type="file"
      class="form-control"
      :accept="accept"
      @change="handleChange"
    />

    <!--  Image Preview -->
    <div v-if="preview && fileUrl" class="mt-2">
      <img
        :src="fileUrl"
        :alt="label || 'Preview'"
        style="max-width: 150px; max-height: 150px; object-fit: contain;"
      />
    </div>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue'

//  Load base URL from .env
const rawBaseUrl = import.meta.env.VITE_BASE_URL
const baseUrl = rawBaseUrl.replace(/\/+$/, '')

// Props
const props = defineProps({
  modelValue: [File, String],
  label: String,
  accept: {
    type: String,
    default: ''
  },
  dbImage: {
    type: String,
    default: ''
  },
  preview: {
    type: Boolean,
    default: false
  }
})

// Emit event
const emit = defineEmits(['update:modelValue'])

// Preview image URL
const fileUrl = ref(null)

// Handle file input change
function handleChange(event) {
  const file = event.target.files[0]
  emit('update:modelValue', file)

  if (props.preview && file) {
    fileUrl.value = URL.createObjectURL(file)
  }
}
// Watch modelValue to show initial preview if it's a string URL
watch(
  () => props.dbImage,
  (newVal) => {
    if (!newVal) {
      fileUrl.value = null
    } else if (typeof newVal === 'string') {
      // Use full URL for relative paths
      fileUrl.value = newVal.startsWith('http')
        ? newVal
        : `${baseUrl}${newVal}`
    } else if (newVal instanceof File) {
      fileUrl.value = URL.createObjectURL(newVal)
    }
  },
  { immediate: true }
)
</script>
