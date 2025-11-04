<!-- components/LoadingButton.vue -->
<template>
  <BButton
    :variant="variant"
    :type="type"
    :disabled="disabled || loading"
    @click.prevent="handleClick"
  >
    <!-- Loading state -->
    <span v-if="loading" v-html="loadingText"></span>

    <!-- Default slot for custom content -->
    <span v-else>
      <slot>{{ text }}</slot>
    </span>
  </BButton>
</template>

<script setup>
defineProps({
  text: String,
  loading: Boolean,
  loadingText: {
    type: String,
    default: 'Saving ... <i class="fas fa-spinner fa-spin"></i>'
  },
  variant: {
    type: String,
    default: 'success'
  },
  type: {
    type: String,
    default: 'submit'
  },
  disabled: Boolean
})

const emit = defineEmits(['click'])

function handleClick(e) {
  emit('click', e)
}
</script>
