<template>
  <select v-model="selected">
    <option disabled value="">-- Select an option --</option>
    <option v-for="option in options" :key="option.id" :value="option.id">
      {{ option.text }}
    </option>
  </select>
</template>

<script setup>
import { ref, watch, onMounted } from 'vue';

const props = defineProps({
  modelValue: [String, Number],
  bUrl: {
    type: String,
    required: true
  }
});
const emit = defineEmits(['update:modelValue']);

const selected = ref(props.modelValue || '');
const options = ref([]);

const fetchOptions = async () => {
  try {
    const res = await fetch(props.bUrl);
    const data = await res.json();
    options.value = data; // data should be [{id, text}, ...]
  } catch (error) {
    console.error('Failed to fetch options:', error);
  }
};

onMounted(() => {
  fetchOptions();
});

watch(selected, (newVal) => {
  emit('update:modelValue', newVal);
});

watch(() => props.modelValue, (newVal) => {
  selected.value = newVal;
});
</script>
