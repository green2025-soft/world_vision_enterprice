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

// ✅ Fetch paginated list with deduplication
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

// ✅ Infinite scroll handler
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
    observer = new IntersectionObserver(infiniteScroll, {
      rootMargin: '50px',
      threshold: 0.1,
    })
  }
  if (hasNextPage.value && loadMoreRef.value) {
    observer.observe(loadMoreRef.value)
  }
}

const onClose = () => {
  if (observer) observer.disconnect()
}

const onSearch = async (val) => {
  searchQuery.value = val
  page.value = 1
  if (observer) observer.disconnect()
  await fetchData()
  await nextTick()
  if (observer && hasNextPage.value && loadMoreRef.value) {
    observer.observe(loadMoreRef.value)
  }
}

// ✅ Load selected item by ID (for edit)
const loadSelectedItem = async (id) => {
  if (!id) return
  const exists = options.value.some(opt => opt[props.valueField] === id)
  if (exists) return

  try {
    const item = await getOne(id)
    if (item) {
      options.value.unshift(item)
      // Vue-select uses full object match, so update selected object
      if (!props.multiple) {
        selected.value = item
      } else {
        selected.value = [...selected.value, item]
      }
    }
  } catch (e) {
    console.error('Failed to load selected item:', e)
  }
}

// ✅ Watch for edit mode and modelValue to load selected item
watch(
  () => [props.modelValue, props.isEdit],
  async ([val, isEdit]) => {
    if (!isEdit || !val) return

    if (props.multiple && Array.isArray(val)) {
      selected.value = []
      for (const id of val) {
        const match = options.value.find(opt => opt[props.valueField] === id)
        if (match) {
          selected.value.push(match)
        } else {
          await loadSelectedItem(id)
        }
      }
    } else {
      const match = options.value.find(opt => opt[props.valueField] === val)
      if (match) {
        selected.value = match
      } else {
        await loadSelectedItem(val)
      }
    }
  },
  { immediate: true }
)

// ✅ Sync selected → emit modelValue
watch(selected, (val) => {
  const emitVal = props.multiple
    ? val.map(v => v?.[props.valueField])
    : val?.[props.valueField]
  emit('update:modelValue', emitVal)
})

// ✅ Sync external modelValue → update selected (when not isEdit)
watch(() => props.modelValue, (val) => {
  if (!props.isEdit) {
    if (props.multiple && Array.isArray(val)) {
      selected.value = options.value.filter(opt => val.includes(opt[props.valueField]))
    } else {
      selected.value = options.value.find(opt => opt[props.valueField] === val) ?? null
    }
  }
})

onMounted(fetchData)
onBeforeUnmount(() => observer?.disconnect())

const getOptionLabel = (option) => {
  if (!option) return ''
  if (typeof props.labelField === 'function') {
    return props.labelField(option)
  }
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
