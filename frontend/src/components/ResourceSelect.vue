<template>
  <v-select
    v-model="selected"
    :options="options"
    :get-option-label="getOptionLabel"
    :filterable="false"
    :loading="loading"
    placeholder="Select..."
    @search="onSearch"
    @open="onOpen"

    :multiple="multiple"
  >
    <template #list-footer>
      <li
        ref="loadMoreRef"
        class="load-item"
        :style="{
          height: hasNextPage ? '1px' : '0',
          opacity: hasNextPage ? 1 : 0,
          pointerEvents: 'none'
        }"
      >
        Loading more...
      </li>
    </template>
  </v-select>
</template>

<script setup>
import { ref, reactive, computed, watch, nextTick, onMounted, onBeforeUnmount } from 'vue'
import vSelect from 'vue-select'
import 'vue-select/dist/vue-select.css'
import { useResourceApiClient } from '@/composables/resourceApiClient'

/* 🔹 Reactive global cache (shared by all ResourceSelect instances) */
const resourceCache = reactive({})

const props = defineProps({
  modelValue: [String, Number, Object, Array],
  bUrl: { type: String, required: true },
  labelField: { type: [String, Function], default: 'name' },
  valueField: { type: String, default: 'id' },
  isBranch: { type: Boolean, default: false },
  multiple: { type: Boolean, default: false },
  isEdit: { type: Boolean, default: false },
  emitObject: { type: Boolean, default: false },
  positional: { type: Boolean, default: false },
  optionsData: { type: Array, default: () => [] },

  extraParams: { type: Object, default: () => ({}) }
})

const emit = defineEmits(['update:modelValue'])

const selected = ref(props.multiple ? [] : null)
const options = ref([])
const loading = ref(false)
const page = ref(1)
const lastPage = ref(1)
const searchQuery = ref('')
const loadMoreRef = ref(null)
let observer = null

const { gePaginationList, getOne } = useResourceApiClient(props.bUrl, 'Resource', props.isBranch)
const hasNextPage = computed(() => page.value < lastPage.value)

function debounce(fn, delay = 300) {
  let timer
  return (...args) => {
    clearTimeout(timer)
    timer = setTimeout(() => fn(...args), delay)
  }
}

/* 🔹 API call function */
const fetchData = async () => {
  if (loading.value) return
  loading.value = true

  try {
    const res = await gePaginationList({ page: page.value, search: searchQuery.value, ...props.extraParams })
    const data = res?.data ?? []
    lastPage.value = res?.pagination?.last_page || lastPage.value

    if (page.value === 1) {
      options.value = data

      // ✅ Save to global cache (reactive)
      resourceCache[props.bUrl] = {
        data,
        lastPage: lastPage.value,
        timestamp: Date.now()
      }
    } else {
      const existingIds = new Set(options.value.map(opt => opt[props.valueField]))
      const newItems = data.filter(item => !existingIds.has(item[props.valueField]))
      options.value.push(...newItems)
    }
  } catch (e) {
    console.error('Fetch failed', e)
  } finally {
    loading.value = false
  }
}

/* 🔹 onOpen — load cached data or call API */
const onOpen = async () => {
  await nextTick()

  // ✅ If optionsData is given, do nothing.
  if (props.optionsData && props.optionsData.length > 0) return

  if (props.positional && options.value.length === 0) {
    const cached = resourceCache[props.bUrl]
    if (cached && cached.data?.length) {
      options.value = cached.data
      lastPage.value = cached.lastPage
    } else {
      await fetchData()
    }
  }

  if (!observer) {
    observer = new IntersectionObserver(infiniteScroll, { rootMargin: '50px', threshold: 0.1 })
  }
  if (hasNextPage.value && loadMoreRef.value) observer.observe(loadMoreRef.value)
}


/* 🔹 Infinite scroll */
const infiniteScroll = async ([entry]) => {
  if (entry.isIntersecting && hasNextPage.value && !loading.value) {
    observer.unobserve(entry.target)
    page.value++
    await fetchData()
    await nextTick()
    if (loadMoreRef.value) observer.observe(loadMoreRef.value)
  }
}

/* 🔹 onSearch — always call API */
const onSearch = async (val) => {
  searchQuery.value = val
  page.value = 1
  observer?.disconnect()
  await fetchData()
  await nextTick()
  if (observer && hasNextPage.value && loadMoreRef.value) observer.observe(loadMoreRef.value)
}

const itemCache = new Map()
const loadSelectedItem = async (id) => {
  if (!id) return null
  if (itemCache.has(id)) return itemCache.get(id)
  const cacheKey = `${props.bUrl}-item-${id}`
  const cached = sessionStorage.getItem(cacheKey)
  if (cached) {
    const parsed = JSON.parse(cached)
    itemCache.set(id, parsed)
    return parsed
  }
  try {
    const item = await getOne(id)
    if (item) {
      itemCache.set(id, item)
      sessionStorage.setItem(cacheKey, JSON.stringify(item))
      return item
    }
  } catch {}
  return null
}

/* 🔹 Edit / Preselected value */
const processModelValue = async (val, isEdit) => {
  if (!isEdit || !val) return
  const id = typeof val === 'object' ? val[props.valueField] : val
  if (selected.value && selected.value[props.valueField] === id) return

  const match = options.value.find(opt => opt[props.valueField] === id)
  if (match) {
    selected.value = match
  } else {
    const item = await loadSelectedItem(id)
    if (item) {
      selected.value = item
      if (!options.value.find(opt => opt[props.valueField] === id)) {
        options.value.unshift(item)
      }
    }
  }
}

const debouncedProcessModelValue = debounce(processModelValue, 300)
watch(() => [props.modelValue, props.isEdit], ([v, e]) => debouncedProcessModelValue(v, e), { immediate: true })

let lastEmitted = null
watch(selected, (val) => {
  let emitVal
  if (props.multiple) {
    emitVal = props.emitObject ? val : val.map(v => v?.[props.valueField])
  } else {
    emitVal = props.emitObject ? val : val?.[props.valueField]
  }
  if (JSON.stringify(emitVal) !== JSON.stringify(lastEmitted)) {
    lastEmitted = emitVal
    emit('update:modelValue', emitVal)
  }
})

/* 🔹 Mounted: use cached if available */
onMounted(async () => {
  // ✅ If optionsData is provided externally, the API will not be called.
  if (props.optionsData && props.optionsData.length > 0) {
    options.value = props.optionsData
    lastPage.value = 1
  } else {
    const cached = resourceCache[props.bUrl]
    if (cached && cached.data?.length) {
      options.value = cached.data
      lastPage.value = cached.lastPage
    } else if (!props.positional) {
      await fetchData()
    }
  }

  if (props.isEdit && props.modelValue) {
    await processModelValue(props.modelValue, true)
  }
})


onBeforeUnmount(() => observer?.disconnect())

const getOptionLabel = (option) => {
  if (!option) return ''
  if (typeof props.labelField === 'function') return props.labelField(option)
  return option[props.labelField] || ''
}

watch(() => props.modelValue, (newVal) => {
  if (!newVal) {
    selected.value = props.multiple ? [] : null
  }
})

const addOption = (item) => {
  const exists = options.value.find(opt => opt[props.valueField] === item[props.valueField])
  if (!exists) {
    options.value.unshift(item)
  }
  selected.value = item
}

defineExpose({
  addOption,
  fetchData, 
  onOpen
})

</script>

<style scoped>
.load-item {
  text-align: center;
  font-style: italic;
  padding: 8px;
}
</style>
