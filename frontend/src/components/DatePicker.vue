<template>
  <VueDatePicker
    v-model="internalValue"
    :format="pickerDateFormat"
    :enable-time-picker="false"
    :placeholder="pickerDateFormat()"
    :min-date="minDate"
    :class="datepickerClasses"
    auto-apply
    text-input
    @update:modelValue="
      (value) => emit('update:modelValue', formatValue(value))
    "
  />
</template>

<script setup>
import '@vuepic/vue-datepicker/dist/main.css';
import { ref, defineEmits, watch } from "vue";
import VueDatePicker from "@vuepic/vue-datepicker";
import { dbDataFormat, pickerDateFormat } from "@/utilities/methods";

const props = defineProps({
  modelValue: {
    type: [String, Array, Date], // Allow Date objects as well
    required: false
  },
  minDate: {
    type: Date,
    default: null
  },
  datepickerClasses: {
    type: String,
    required: false
  }
});

const emit = defineEmits(["update:modelValue"]);

// Local state to bind to VueDatePicker
const internalValue = ref(props.modelValue);

// Watch for prop changes
watch(
  () => props.modelValue,
  (newValue) => {
    internalValue.value = newValue; // Sync the internal state with the prop
  }
);

// Watch for internal state changes and emit them
watch(internalValue, (newValue) => {
  emit("update:modelValue", formatValue(newValue));
});

// Function to format the value using the existing pickerDateFormat
const formatValue = (value) => {
  if (Array.isArray(value)) {
    return value.map((date) =>
      date instanceof Date ? dbDataFormat(date) : date
    );
  }

  return value instanceof Date ? dbDataFormat(value) : value;
};
</script>
