
<script setup>

import { ref } from 'vue'
  import { useImageUrl  } from '@/utilities/methods'
const props = defineProps({
  src: String,
  alt: {
    type: String,
    default: 'Image'
  },
  size: {
    type: [Number, String],
    default: 60
  },
  radius: {
    type: [String, Number],
    default: '50%'
  },
  fallbackIcon: {
    type: String,
    default: 'fa-image'
  },
  wrapperClass: {
    type: String,
    default: ''
  },
  imgClass: {
    type: String,
    default: ''
  }
})

const error = ref(false)

function onError() {
  error.value = true
}
</script>
<template>
  <div
    :class="['d-flex align-items-center justify-content-center', wrapperClass]"
    :style="{ width: size + 'px', height: size + 'px',  }"
  >
    <img
      v-if="!error"
      :src="useImageUrl(src)"
      :alt="alt"
      :class="imgClass"
      @error="onError"
      loading="lazy"
      :style="{ maxWidth: '100%', maxHeight: '100%', borderRadius: radius }"
    />
    <div
      v-else
      class="fallback d-flex align-items-center justify-content-center w-100 h-100"
      :style="{ borderRadius: radius }"
    >
      <i :class="['fas', fallbackIcon, 'text-muted']" :style="{ fontSize: size * 0.6 + 'px' }"></i>
    </div>
  </div>
</template>



<style scoped>
img {
  width: 100%;
  height: 100%;
  object-fit: contain;
  border-radius: inherit;
  display: block;
}

</style>
