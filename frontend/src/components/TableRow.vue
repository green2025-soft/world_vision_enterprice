<template>
  <tr>
    <th :style="width" style=" white-space: nowrap;">{{ label }}</th>
    <td>
      <slot>{{ value ?? '-' }}</slot>
    </td>
  </tr>
</template>

<script setup>
defineProps({
  label: String,
  value: [String, Number],
  width: {  default: '35%' },
})
</script>
