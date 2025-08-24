<script setup>
import { ref, computed, shallowRef, watch, onMounted } from "vue";
import { printADiv, getNestedValue } from "@/utilities/methods";
import { BTable, BFormInput, BButton, BPagination, BFormSelect, BInputGroup, BCol } from 'bootstrap-vue-next';
import { useResourceApiClient } from '@/composables/resourceApiClient';
import _ from "lodash";

const props = defineProps({
  fields: { type: Array, required: true },
  bUrl: { type: String, required: true },
  paginationLimit: { type: Number, default: 5 },
  hidePrint: { type: Boolean, default: false }
});

const filterText = shallowRef('');
const currentPage = shallowRef(1);
const perPage = ref(10);

let searchTimeout = null;

watch(filterText, () => {
  clearTimeout(searchTimeout);
  searchTimeout = setTimeout(() => {
    currentPage.value = 1; // search করলে first page দেখাও
    fetchData();
  }, 500); // 500ms delay
});

const pageOptions = [5, 10, 15, 20, 30, 50, 100].map(n => ({ value: n, text: n.toString() }));

const tableData = ref([]);
const pagination = ref({ total: 0, per_page: 10, current_page: 1 });

// Composable for API calls
const { gePaginationList} = useResourceApiClient(props.bUrl);

// Fetch data from API
const isLoading = ref(false);
async function fetchData() {
  try {
    isLoading.value = true;
    const response = await gePaginationList({
      page: currentPage.value,
      per_page: perPage.value,
      search: filterText.value
    });
    tableData.value = response.data;
    pagination.value = response.pagination;
  } catch (err) {
    
  } finally {
    isLoading.value = false;
  }
}


// Watch pagination changes
watch([currentPage, perPage], fetchData);
onMounted(fetchData);

// Filtered data
const filteredData = computed(() => {
  const searchText = filterText.value?.toLowerCase()?.trim();
  if (!searchText) return tableData.value;

  return tableData.value.filter(item => {
    return props.fields.some(field => {
      const val = getNestedValue(item, field.key);
      return typeof val === 'string' && val.toLowerCase().includes(searchText);
    });
  });
});


// Computed fields with alignment & width
const computedFields = computed(() => {
  return props.fields.map(field => {
    const newField = { ...field };
    let align = field.align || (field.key === 'sl' || field.key === 'actions' ? 'center' : 'left');
    if (align === 'center') { newField.thClass = 'text-center'; newField.tdClass = 'text-center'; }
    else if (align === 'right') { newField.thClass = 'text-end'; newField.tdClass = 'text-end'; }
    else { newField.thClass = 'text-start'; newField.tdClass = 'text-start'; }
    if ((field.key === 'sl' || field.key === 'actions') && !field.width) {
      newField.thStyle = { width: field.key === 'sl' ? '70px' : '150px' };
      newField.tdStyle = { width: field.key === 'sl' ? '70px' : '150px' };
    }
    if (field.width) { newField.thStyle = { width: field.width }; newField.tdStyle = { width: field.width }; }
    return newField;
  });
});

// Pagination helpers
const totalRows = computed(() => pagination.value?.total || 0);
const startIndex = computed(() => {
  const page = pagination.value?.current_page || 1;
  const per = pagination.value?.per_page || perPage.value;
  return Math.min((page - 1) * per + 1, totalRows.value);
});

const endIndex = computed(() => {
  const page = pagination.value?.current_page || 1;
  const per = pagination.value?.per_page || perPage.value;
  return Math.min(page * per, totalRows.value);
});



defineExpose({
  refresh: fetchData
});
</script>

<template>
  <div>
    <!-- Filter & Print -->
    <div class="row mb-3">
      <BCol lg="5">
        <BInputGroup>
          <BFormInput v-model="filterText" type="search" size="sm" placeholder="Type to Search" />
          <BButton variant="warning" @click="filterText = ''">
            <i class="fas fa-search text-white"></i>
          </BButton>
        </BInputGroup>
      </BCol>

      <BCol lg="7" class="text-end">
        <BButton v-if="!hidePrint" variant="primary" size="sm" @click="printADiv('dataTablePrint')">
          <i class="fas fa-print"></i> Print
        </BButton>
      </BCol>
    </div>

    <CenteredSpinner  v-if="isLoading" />
    <!-- Table -->
    <BTable v-else id="dataTablePrint" bordered hover :items="filteredData" :fields="computedFields">
      <template #cell(sl)="data">
        {{ startIndex + data.index }}
      </template>

      <template #cell()="data">
        <template v-if="$slots[`cell-${data.field.key}`]">
          <slot :name="`cell-${data.field.key}`" :item="data.item"></slot>
        </template>
        <template v-else>{{ getNestedValue(data.item, data.field.key) }}</template>
      </template>

        <template #cell(actions)="data">
        <slot name="actions" :rowItem="data.item" />
      </template>
    </BTable>

    <!-- Pagination -->
    <div class="row align-items-center mt-2">
      <BCol lg="6">
        <BFormSelect v-model="perPage" :options="pageOptions" size="sm" class="w-auto d-inline-block" />
        <span v-if="totalRows > 0" class="ms-2">
          Showing {{ startIndex }} to {{ endIndex }} of {{ totalRows }} entries
        </span>
      </BCol>
      <BCol lg="6">
        <BPagination v-model="currentPage" :total-rows="totalRows" :per-page="perPage" align="end" size="sm" class="my-0" :limit="paginationLimit" />
      </BCol>
    </div>

    <!-- Confirm Delete Modal -->

  </div>
</template>


<style scoped>
:deep(#dataTablePrint th),
:deep(#dataTablePrint td) {
  vertical-align: middle !important;
  white-space: nowrap;
}

@media (max-width: 576px) {
  .closeButn {
    display: none;
  }
}

@page {
  size: A4;
  margin: 0.4in !important;
}
@media print {
  #dataTablePrint th:last-child,
  #dataTablePrint td:last-child,
  #dataTablePrint th svg {
    display: none !important;
  }

  #dataTablePrint th,
  #dataTablePrint td {
    font-size: 12px;
  }
}
</style>
