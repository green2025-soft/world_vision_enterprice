<!-- ConfirmDelete.vue -->
<template>
  <b-modal
    ref="modalRef"
    :id="modalId"
    :title="title"
    ok-title="Yes, Delete"
    cancel-title="Cancel"
    @ok="onConfirm"
    centered
  >
    <slot>
      Are you sure you want to delete this item?
    </slot>
  </b-modal>
</template>

<script setup>
import { ref } from 'vue'

const props = defineProps({
  modalId: { type: String, default: 'confirm-delete-modal' },
  title: { type: String, default: 'Confirm Delete' }
})

const emit = defineEmits(['confirm'])
const modalRef = ref(null)

function show() {
  modalRef.value?.show?.()
}

function onConfirm() {
  emit('confirm')
}

defineExpose({ show })
</script>
