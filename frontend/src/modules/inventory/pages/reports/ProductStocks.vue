<script setup>
import { ref, onMounted, watch, computed, shallowRef } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { userDateFormat, useForm, dbDataFormat, printADiv, getNestedValue } from '@/utilities/methods'
import { BTable, BFormInput, BButton, BPagination, BFormSelect, BInputGroup, BCol } from 'bootstrap-vue-next';



//  Setup
const title = 'Product Stock'
const bUrl = 'inventory/reports/product-stocks'

const {
gePaginationList,
formErrors
} = useResourceApiClient(bUrl, title, true)


const currentPage = shallowRef(1);
const perPage = ref(10);

const { form } = useForm({
  product_id: null,
  from_date: new Date(),
  to_date: new Date(),
})

const pageOptions = [5,10, 15, 20, 30, 50, 100,500,1000,2000,3000,5000,10000, 20000, 30000].map(n => ({ value: n, text: n.toString() }));
const tableData = ref([]);
const pagination = ref({ total: 0, per_page: 10, current_page: 1 });
const isLoading = ref(false);


const summary = ref({
  opening_qty: 0,
  stock_in: 0,
  stock_out: 0,
  closing_qty: 0
});

const perpageSummary = ref({
  opening_qty: 0,
  stock_in: 0,
  stock_out: 0,
  closing_qty: 0
});

async function fetchData() {
  try {
    isLoading.value = true;
    const response = await gePaginationList({
      page: currentPage.value,
      per_page: perPage.value,
      product_id:form.value.product_id,
      from_date:dbDataFormat(form.value.from_date),
      to_date:dbDataFormat(form.value.to_date),
    });
    const responseData = response.data
    tableData.value = responseData.items;
    pagination.value = responseData.pagination;

    summary.value = responseData.summary;
    perpageSummary.value = responseData.perpageSummary;
  } catch (errors) {
    
  } finally {
    isLoading.value = false;
  }
}

watch([currentPage, perPage], fetchData);

onMounted(fetchData);

const search = ()=>fetchData()

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

const fields = [
  { key: 'sl', label: 'SL' },
  { key: 'name', label: 'Product' },
  { key: 'category.name', label: 'Category' },
  { key: 'brand.name', label: 'Brand' },
  { key: 'opening_qty', label: 'Opening',align:'center'},
  { key: 'stock_in', label: 'Stock In', align:'center' },
  { key: 'stock_out', label: 'Stock Out', align:'center' },
  { key: 'balance', label: 'Closing Blance', align:'center' }
]


const computedFields = computed(() => {
  return fields.map(field => {
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


</script>

<template>
    
     <div class="container-fluid">
        <div class="container ">
    <div class="card card-outline card-info">
        <div class="card-header">
             <h2 class="card-title"><i class="fas fa-tasks"></i> {{ title }}</h2>
            <div class="card-tools">
              <!-- <RouterLink class="btn btn-primary btn-sm" :to="`/${bUrl}/create`"><i class="fas fa-plus"></i> Add New</RouterLink> -->
            </div>
        </div>
        <div class="card-body">
          <div class="row">
            <div class="col-md-4">
              <BaseFormGroup label="Product " labelCols="12">
                  <ResourceSelect
                  v-model="form.product_id"
                  bUrl="inventory/products"
                  :labelField="(item) => `${item.name} (${item.sku})`"
                  placeholder="Select product"
                />
                 </BaseFormGroup>
            </div>
            <div class="col-md-3">
              <BaseFormGroup label="From Date " labelCols="12" required>
                  <DatePicker v-model="form.from_date" />
              </BaseFormGroup>
            </div>
            <div class="col-md-3">
              <BaseFormGroup label="To Date " labelCols="12" required>
                  <DatePicker v-model="form.to_date" />
              </BaseFormGroup>
            </div>
            <div class="col-md-2 mb-2 d-flex align-items-end">

              <LoadingButton :loading="isLoading"  @click="search()">
                <i class="fas fa-search"></i> Search
              </LoadingButton>
             
            </div>

    

    



</div>



    <div class="row mb-3">
        <BCol lg="12" class="text-end">
        <BButton  variant="primary" size="sm" @click="printADiv('dataTablePrint', 'landscape')">
          <i class="fas fa-print"></i> Print
        </BButton>
      </BCol>
    </div>
    
    <ValidationErrors :errors="formErrors" />
    <CenteredSpinner  v-if="isLoading" />
    

     <BTable
  v-else
  id="dataTablePrint"
  bordered
  hover
  :items="tableData"
  :fields="computedFields"
>
  <template #cell(sl)="data">
    {{ startIndex + data.index }}
  </template>

  <template #cell(name)="data">
    {{ data.item.name }} ({{ data.item.sku }})
  </template>

  <template #custom-foot>
    <tr class="table-info fw-bold">
      <td colspan="4" class="text-end">
        Current Page Total
      </td>
      <td class="text-center">
        {{ perpageSummary.opening_qty }}
      </td>
      <td class="text-center">
        {{ perpageSummary.stock_in }}
      </td>
      <td class="text-center">
        {{ perpageSummary.stock_out }}
      </td>
      <td class="text-center">
        {{ perpageSummary.closing_qty }}
      </td>
    </tr>

    <tr class="table-success fw-bold">
      <td colspan="4" class="text-end">
        Grand Total
      </td>
      <td class="text-center">
        {{ summary.opening_qty }}
      </td>
      <td class="text-center">
        {{ summary.stock_in }}
      </td>
      <td class="text-center">
        {{ summary.stock_out }}
      </td>
      <td class="text-center">
        {{ summary.closing_qty }}
      </td>
    </tr>
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
        <BPagination v-model="currentPage" :total-rows="totalRows" :per-page="perPage" align="end" size="sm" class="my-0" :limit="10" />
      </BCol>
    </div>
          
         
        </div>
      

    </div>

  </div>
    </div>

    


</template>
