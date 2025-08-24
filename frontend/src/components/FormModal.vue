<!-- components/FormModal.vue -->
<template>
  <b-modal
    :model-value="modelValue"
    @update:model-value="$emit('update:modelValue', $event)"
    :title="title"
    :size="size"
    :hide-footer="true"
  >
    <!-- Main form inputs from parent -->
    <slot />

    <!-- Validation errors -->
    <ValidationErrors :errors="errors" class="my-2" />

    <!-- Footer button -->
    <div class="text-end mt-3">
      <LoadingButton
        :text="buttonText"
        :variant="buttonVariant"
        :loading="loading"
        @click.prevent="$emit('submit')"
      />
    </div>
  </b-modal>
</template>

<script setup>
defineProps({
  modelValue: Boolean,
  title: {
    type: String,
    default: 'Add Item',
  },
  size: {
    type: String,
    default: 'md',
  },
  loading: Boolean,
  errors: {
    type: Object,
    default: () => ({}),
  },
  buttonText: {
    type: String,
    default: 'Save',
  },
  buttonVariant: {
    type: String,
    default: 'success',
  },
})

defineEmits(['update:modelValue', 'submit'])
</script>
