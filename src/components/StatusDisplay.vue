<template>
  <span :class="badgeClass">
    <i :class="iconClass" class="me-1"></i>
    {{ statusText }}
  </span>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  value: {
    type: [String, Number],
    required: true,
  },
})

const isActive = computed(() => props.value == 1 || props.value === '1')

const statusText = computed(() => (isActive.value ? 'Active' : 'In Active'))

const badgeClass = computed(() =>
  isActive.value ? 'badge bg-success' : 'badge bg-secondary'
)

const iconClass = computed(() =>
  isActive.value ? 'fas fa-check-circle' : 'fas fa-times-circle'
)
</script>
