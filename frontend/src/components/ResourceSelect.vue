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
    ref="selectRef"
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
import {
  ref,
  reactive,
  computed,
  watch,
  nextTick,
  onMounted,
  onBeforeUnmount
} from 'vue'

import vSelect from 'vue-select'
import 'vue-select/dist/vue-select.css'

import { useResourceApiClient } from '@/composables/resourceApiClient'

/* ----------------------------------------------------------
|--------------------------------------------------------------------------
| GLOBAL CACHE
|--------------------------------------------------------------------------
*/

const resourceCache = reactive({})

/* ----------------------------------------------------------
|--------------------------------------------------------------------------
| PROPS
|--------------------------------------------------------------------------
*/

const props = defineProps({
  modelValue: [String, Number, Object, Array],

  bUrl: {
    type: String,
    required: true
  },

  labelField: {
    type: [String, Function],
    default: 'name'
  },

  valueField: {
    type: String,
    default: 'id'
  },

  isBranch: {
    type: Boolean,
    default: false
  },

  multiple: {
    type: Boolean,
    default: false
  },

  isEdit: {
    type: Boolean,
    default: false
  },

  emitObject: {
    type: Boolean,
    default: false
  },

  positional: {
    type: Boolean,
    default: false
  },

  optionsData: {
    type: Array,
    default: () => []
  },

  extraParams: {
    type: Object,
    default: () => ({})
  }
})

const emit = defineEmits([
  'update:modelValue'
])

/* ----------------------------------------------------------
|--------------------------------------------------------------------------
| STATE
|--------------------------------------------------------------------------
*/

const selectRef = ref(null)

const selected = ref(
  props.multiple ? [] : null
)

const options = ref([])

const loading = ref(false)

const page = ref(1)

const lastPage = ref(1)

const searchQuery = ref('')

const loadMoreRef = ref(null)

let observer = null

/* ----------------------------------------------------------
|--------------------------------------------------------------------------
| API
|--------------------------------------------------------------------------
*/

const {
  gePaginationList,
  getOne
} = useResourceApiClient(
  props.bUrl,
  'Resource',
  props.isBranch
)

const hasNextPage = computed(() => {
  return page.value < lastPage.value
})

/* ----------------------------------------------------------
|--------------------------------------------------------------------------
| HELPERS
|--------------------------------------------------------------------------
*/

function debounce(fn, delay = 300) {

  let timer

  return (...args) => {

    clearTimeout(timer)

    timer = setTimeout(() => {
      fn(...args)
    }, delay)
  }
}

const getCacheKey = () => {
  return `${props.bUrl}-${JSON.stringify(props.extraParams || {})}`
}

/* ----------------------------------------------------------
|--------------------------------------------------------------------------
| FETCH DATA
|--------------------------------------------------------------------------
*/

const fetchData = async () => {

  if (loading.value) return

  loading.value = true

  try {

    const res = await gePaginationList({
      page: page.value,
      search: searchQuery.value,
      ...props.extraParams
    })

    const data = res?.data ?? []

    lastPage.value =
      res?.pagination?.last_page || 1

    /*
    |--------------------------------------------------------------------------
    | PAGE 1
    |--------------------------------------------------------------------------
    */

    if (page.value === 1) {

      options.value = data

      // cache
      const cacheKey = getCacheKey()

      resourceCache[cacheKey] = {
        data,
        lastPage: lastPage.value,
        timestamp: Date.now()
      }

    } else {

      /*
      |--------------------------------------------------------------------------
      | PAGINATION APPEND
      |--------------------------------------------------------------------------
      */

      const existingIds = new Set(
        options.value.map(
          opt => opt[props.valueField]
        )
      )

      const newItems = data.filter(item => {
        return !existingIds.has(
          item[props.valueField]
        )
      })

      options.value.push(...newItems)
    }

  } catch (e) {

    console.error('Fetch failed', e)

  } finally {

    loading.value = false
  }
}

/* ----------------------------------------------------------
|--------------------------------------------------------------------------
| OPEN
|--------------------------------------------------------------------------
*/

const onOpen = async () => {

  await nextTick()

  /*
  |--------------------------------------------------------------------------
  | STATIC OPTIONS
  |--------------------------------------------------------------------------
  */

  if (
    props.optionsData &&
    props.optionsData.length > 0
  ) {
    return
  }

  /*
  |--------------------------------------------------------------------------
  | CACHE
  |--------------------------------------------------------------------------
  */

  const cacheKey = getCacheKey()

  const cached = resourceCache[cacheKey]

  if (cached?.data?.length) {

    options.value = cached.data

    lastPage.value = cached.lastPage

  } else {

    await fetchData()
  }

  /*
  |--------------------------------------------------------------------------
  | OBSERVER
  |--------------------------------------------------------------------------
  */

  if (!observer) {

    observer = new IntersectionObserver(
      infiniteScroll,
      {
        rootMargin: '50px',
        threshold: 0.1
      }
    )
  }

  if (
    hasNextPage.value &&
    loadMoreRef.value
  ) {
    observer.observe(loadMoreRef.value)
  }
}

/* ----------------------------------------------------------
|--------------------------------------------------------------------------
| INFINITE SCROLL
|--------------------------------------------------------------------------
*/

const infiniteScroll = async ([entry]) => {

  if (
    entry.isIntersecting &&
    hasNextPage.value &&
    !loading.value
  ) {

    observer.unobserve(entry.target)

    page.value++

    await fetchData()

    await nextTick()

    if (loadMoreRef.value) {
      observer.observe(loadMoreRef.value)
    }
  }
}

/* ----------------------------------------------------------
|--------------------------------------------------------------------------
| SEARCH
|--------------------------------------------------------------------------
*/

const onSearch = async (val) => {

  searchQuery.value = val

  page.value = 1

  observer?.disconnect()

  await fetchData()

  await nextTick()

  if (
    observer &&
    hasNextPage.value &&
    loadMoreRef.value
  ) {
    observer.observe(loadMoreRef.value)
  }
}

/* ----------------------------------------------------------
|--------------------------------------------------------------------------
| LOAD SELECTED ITEM
|--------------------------------------------------------------------------
*/

const itemCache = new Map()

const loadSelectedItem = async (id) => {

  if (!id) return null

  if (itemCache.has(id)) {
    return itemCache.get(id)
  }

  const cacheKey =
    `${props.bUrl}-item-${id}`

  const cached =
    sessionStorage.getItem(cacheKey)

  if (cached) {

    const parsed = JSON.parse(cached)

    itemCache.set(id, parsed)

    return parsed
  }

  try {

    const item = await getOne(id)

    if (item) {

      itemCache.set(id, item)

      sessionStorage.setItem(
        cacheKey,
        JSON.stringify(item)
      )

      return item
    }

  } catch {}

  return null
}

/* ----------------------------------------------------------
|--------------------------------------------------------------------------
| EDIT MODE
|--------------------------------------------------------------------------
*/

const processModelValue = async (
  val,
  isEdit
) => {

  if (!isEdit || !val) return

  const id =
    typeof val === 'object'
      ? val[props.valueField]
      : val

  if (
    selected.value &&
    selected.value[props.valueField] === id
  ) {
    return
  }

  const match = options.value.find(opt => {
    return opt[props.valueField] === id
  })

  if (match) {

    selected.value = match

  } else {

    const item = await loadSelectedItem(id)

    if (item) {

      selected.value = item

      if (
        !options.value.find(
          opt => opt[props.valueField] === id
        )
      ) {
        options.value.unshift(item)
      }
    }
  }
}

const debouncedProcessModelValue =
  debounce(processModelValue, 300)

watch(
  () => [props.modelValue, props.isEdit],
  ([v, e]) => {
    debouncedProcessModelValue(v, e)
  },
  {
    immediate: true
  }
)

/* ----------------------------------------------------------
|--------------------------------------------------------------------------
| EMIT
|--------------------------------------------------------------------------
*/

let lastEmitted = null

watch(selected, (val) => {

  let emitVal

  if (props.multiple) {

    emitVal = props.emitObject
      ? val
      : val.map(v => v?.[props.valueField])

  } else {

    emitVal = props.emitObject
      ? val
      : val?.[props.valueField]
  }

  if (
    JSON.stringify(emitVal) !==
    JSON.stringify(lastEmitted)
  ) {

    lastEmitted = emitVal

    emit('update:modelValue', emitVal)
  }
})

/* ----------------------------------------------------------
|--------------------------------------------------------------------------
| MODEL SYNC
|--------------------------------------------------------------------------
*/

watch(
  () => props.modelValue,
  (val) => {

    // empty
    if (!val) {

      selected.value =
        props.multiple ? [] : null

      return
    }

    // object
    if (props.emitObject) {

      selected.value = val

      return
    }

    // primitive
    const match = options.value.find(opt => {
      return (
        opt?.[props.valueField] === val
      )
    })

    if (match) {
      selected.value = match
    }
  },
  {
    immediate: true,
    deep: true
  }
)

/* ----------------------------------------------------------
|--------------------------------------------------------------------------
| EXTRA PARAMS WATCH
|--------------------------------------------------------------------------
*/

watch(
  () => props.extraParams,
  async () => {

    page.value = 1

    options.value = []

    observer?.disconnect()

    await fetchData()

    await nextTick()

    if (
      observer &&
      hasNextPage.value &&
      loadMoreRef.value
    ) {
      observer.observe(loadMoreRef.value)
    }
  },
  {
    deep: true
  }
)

/* ----------------------------------------------------------
|--------------------------------------------------------------------------
| MOUNTED
|--------------------------------------------------------------------------
*/

onMounted(async () => {

  /*
  |--------------------------------------------------------------------------
  | STATIC DATA
  |--------------------------------------------------------------------------
  */

  if (
    props.optionsData &&
    props.optionsData.length > 0
  ) {

    options.value = props.optionsData

    lastPage.value = 1

    return
  }

  /*
  |--------------------------------------------------------------------------
  | CACHE
  |--------------------------------------------------------------------------
  */

  const cacheKey = getCacheKey()

  const cached = resourceCache[cacheKey]

  if (cached?.data?.length) {

    options.value = cached.data

    lastPage.value = cached.lastPage

  } else if (
    !props.positional &&
    (
      !props.extraParams ||
      Object.keys(props.extraParams).length
    )
  ) {

    await fetchData()
  }

  /*
  |--------------------------------------------------------------------------
  | EDIT MODE
  |--------------------------------------------------------------------------
  */

  if (
    props.isEdit &&
    props.modelValue
  ) {
    await processModelValue(
      props.modelValue,
      true
    )
  }
})

/* ----------------------------------------------------------
|--------------------------------------------------------------------------
| BEFORE UNMOUNT
|--------------------------------------------------------------------------
*/

onBeforeUnmount(() => {
  observer?.disconnect()
})

/* ----------------------------------------------------------
|--------------------------------------------------------------------------
| LABEL
|--------------------------------------------------------------------------
*/

const getOptionLabel = (option) => {

  if (!option) return ''

  if (
    typeof props.labelField === 'function'
  ) {
    return props.labelField(option)
  }

  return option[props.labelField] || ''
}

/* ----------------------------------------------------------
|--------------------------------------------------------------------------
| METHODS
|--------------------------------------------------------------------------
*/

const addOption = (item) => {

  const exists = options.value.find(opt => {
    return (
      opt[props.valueField] ===
      item[props.valueField]
    )
  })

  if (!exists) {
    options.value.unshift(item)
  }

  selected.value = item
}

const focus = () => {

  const el = selectRef.value

  if (!el) return

  // focus input
  el.$el
    ?.querySelector('input')
    ?.focus()

  // open dropdown
  if (el.openDropdown) {

    el.openDropdown()

  } else {

    el.$el
      ?.querySelector('.vs__dropdown-toggle')
      ?.click()
  }
}

/* ----------------------------------------------------------
|--------------------------------------------------------------------------
| EXPOSE
|--------------------------------------------------------------------------
*/

defineExpose({
  addOption,
  fetchData,
  onOpen,
  focus
})
</script>

<style scoped>
.load-item {
  text-align: center;
  font-style: italic;
  padding: 8px;
}
</style>