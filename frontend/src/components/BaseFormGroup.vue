<template>
  <BFormGroup :label-cols="labelCols" class="mb-2">
    <template #label>
      {{ label }}
      <span v-if="required" style="color: red">*</span>
    </template>
    <slot />
  </BFormGroup>
</template>

<script setup>
defineProps({
  label: String,
  labelCols: {
    type: [Number, String],
    default: 2
  },
  required: {
    type: Boolean,
    default: false
  }
});
</script>
