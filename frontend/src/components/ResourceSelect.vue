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
    @close="onClose"
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
import { ref, computed, watch, nextTick, onMounted, onBeforeUnmount } from 'vue'
import vSelect from 'vue-select'
import 'vue-select/dist/vue-select.css'
import { useResourceApiClient } from '@/composables/resourceApiClient'

const props = defineProps({
  modelValue: [String, Number, Object, Array],
  bUrl: { type: String, required: true },
  labelField: { type: [String, Function], default: 'name' },
  valueField: { type: String, default: 'id' },
  isBranch: { type: Boolean, default: false },
  multiple: { type: Boolean, default: false },
  isEdit: { type: Boolean, default: false },
  emitObject: { type: Boolean, default: false }
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

// Debounce utility
function debounce(fn, delay = 300) {
  let timer
  return (...args) => {
    clearTimeout(timer)
    timer = setTimeout(() => fn(...args), delay)
  }
}

// Fetch paginated data
const fetchData = async () => {
  if (loading.value) return
  loading.value = true
  await nextTick()

  const dropdown = document.querySelector('.vs__dropdown-menu')
  const prevScrollTop = dropdown?.scrollTop ?? 0
  const prevScrollHeight = dropdown?.scrollHeight ?? 0

  try {
    const res = await gePaginationList({ page: page.value, search: searchQuery.value })
    const data = res?.data ?? []
    lastPage.value = res?.pagination?.last_page || lastPage.value

    if (page.value === 1) {
      options.value = data
    } else {
      const existingIds = new Set(options.value.map(opt => opt[props.valueField]))
      const newItems = data.filter(item => !existingIds.has(item[props.valueField]))
      options.value = [...options.value, ...newItems]
    }

    await nextTick()
    const newScrollHeight = dropdown?.scrollHeight ?? 0
    const heightDiff = newScrollHeight - prevScrollHeight
    if (dropdown && page.value > 1) {
      dropdown.scrollTop = prevScrollTop + heightDiff
    }
  } catch (error) {
    console.error('Failed to fetch data:', error)
  } finally {
    loading.value = false
  }
}

// Infinite scroll
const infiniteScroll = async ([entry]) => {
  if (entry.isIntersecting && hasNextPage.value && !loading.value) {
    observer.unobserve(entry.target)
    page.value++
    await fetchData()
    await nextTick()
    if (loadMoreRef.value) observer.observe(loadMoreRef.value)
  }
}

const onOpen = async () => {
  await nextTick()
  if (!observer) {
    observer = new IntersectionObserver(infiniteScroll, { rootMargin: '50px', threshold: 0.1 })
  }
  if (hasNextPage.value && loadMoreRef.value) observer.observe(loadMoreRef.value)
}

const onClose = () => observer?.disconnect()

const onSearch = async (val) => {
  searchQuery.value = val
  page.value = 1
  observer?.disconnect()
  await fetchData()
  await nextTick()
  if (observer && hasNextPage.value && loadMoreRef.value) observer.observe(loadMoreRef.value)
}

// Cache loaded items
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
  } catch (e) {
    console.error('Failed to load selected item:', e)
  }

  return null
}

// Process modelValue (preselect)
const processModelValue = async (val, isEdit) => {
  if (!isEdit || !val) return

  const currentIds = new Set(
    (Array.isArray(selected.value) ? selected.value : [selected.value])
      .map(i => i?.[props.valueField])
  )
  const incomingIds = props.multiple && Array.isArray(val) ? val : [val]
  const isSame = incomingIds.every(id => currentIds.has(id))
  if (isSame) return

  if (props.multiple && Array.isArray(val)) {
    const matched = options.value.filter(opt => val.includes(opt[props.valueField]))
    const matchedIds = matched.map(opt => opt[props.valueField])
    const missingIds = val.filter(id => !matchedIds.includes(id))

    const fetched = await Promise.all(missingIds.map(id => loadSelectedItem(id)))
    const allSelected = [...matched, ...fetched.filter(Boolean)]

    const seen = new Set()
    selected.value = allSelected.filter(item => {
      const id = item?.[props.valueField]
      if (!id || seen.has(id)) return false
      seen.add(id)
      return true
    })

    for (const item of fetched) {
      if (item && !options.value.find(opt => opt[props.valueField] === item[props.valueField])) {
        options.value.unshift(item)
      }
    }

  } else {
    const match = options.value.find(opt => opt[props.valueField] === val)
    if (match) selected.value = match
    else {
      const item = await loadSelectedItem(val)
      if (item) {
        selected.value = item
        if (!options.value.find(opt => opt[props.valueField] === item[props.valueField])) {
          options.value.unshift(item)
        }
      }
    }
  }
}

const debouncedProcessModelValue = debounce(processModelValue, 300)

watch(
  () => [props.modelValue, props.isEdit],
  ([val, isEdit]) => debouncedProcessModelValue(val, isEdit),
  { immediate: true }
)

watch(selected, (val) => {
  let emitVal
  if (props.multiple) {
    emitVal = props.emitObject ? val : val.map(v => v?.[props.valueField])
  } else {
    emitVal = props.emitObject ? val : val?.[props.valueField]
  }
  emit('update:modelValue', emitVal)
})

watch(() => props.modelValue, (val) => {
  if (!props.isEdit) {
    if (props.multiple && Array.isArray(val)) {
      selected.value = options.value.filter(opt => val.includes(opt[props.valueField]))
    } else {
      selected.value = options.value.find(opt => opt[props.valueField] === val) ?? null
    }
  }
})

onMounted(async () => {
  await fetchData()
  if (props.isEdit && props.modelValue) {
    const ids = props.multiple ? props.modelValue : [props.modelValue]
    await Promise.all(ids.map(id => loadSelectedItem(id)))
  }
})

onBeforeUnmount(() => observer?.disconnect())

const getOptionLabel = (option) => {
  if (!option) return ''
  if (typeof props.labelField === 'function') return props.labelField(option)
  return option[props.labelField] || ''
}
</script>

<style scoped>
.load-item {
  text-align: center;
  font-style: italic;
  padding: 8px;
}
</style>
