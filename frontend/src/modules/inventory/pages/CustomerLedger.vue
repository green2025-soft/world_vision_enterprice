<script setup>
import { ref, watch } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm, userDateFormat,formatDateWithFormat, dbDataFormat, formatCurrency } from '@/utilities/methods'
import PrintHeader from '@/modules/inventory/components/print_header.vue'


//  Setup
const title = 'Customer Ledger'
const bUrl = 'inventory/customers/ledger'

const {
  confirmDelete,
  customGet,
  formErrors,
  isLoading
} = useResourceApiClient(bUrl, title, true)

//  Form Setup
const { form, reset } = useForm({
  customer_id: '',
  from_date: new Date(),
  to_date: new Date(),
  
})

const ledgerData = ref({
  openingBalance: 0,
  ledgers: [],
  closingBalance: 0
})
const errors = ref([])

const searchLedger = async () => {
  try{
    form.value.from_date = dbDataFormat(form.value.from_date)
    form.value.to_date = dbDataFormat(form.value.to_date)
    const res = await customGet(bUrl, form.value)
    console.log(res);
    
    ledgerData.value = res

  }catch(error){
    errors.value = formErrors.value
  }
}

</script>

<template>
<div class="container-fluid">
  <div class="card card-outline card-info">
    <div class="card card-outline card-info">
       <div class="card-header">
          <h2 class="card-title"><i class="fas fa-tasks"></i> {{ title }}</h2>
       </div>
    </div>
    <div class="card-body">
      <div class="row mb-3">
        <div class="col-md-4">
          <BaseFormGroup label="Customer Name" labelCols="12"  required>
            <ResourceSelect
                v-model="form.customer_id"
                bUrl="inventory/customers"
                :clearable="false"
                :labelField="(item) => `${item.name} (${item.phone})`"
                
                :isBranch="true"
              />
            </BaseFormGroup>
        </div>
        <div class="col-md-3">
          <BaseFormGroup label="form Date" labelCols="12" required>
              <DatePicker v-model="form.from_date" :max-date="new Date()" />
            </BaseFormGroup>
        </div>
        <div class="col-md-3">
          <BaseFormGroup label="To Date" labelCols="12" required>
              <DatePicker v-model="form.to_date" :max-date="new Date()" />
            </BaseFormGroup>
        </div>
        <div class="col-md-2 ">
          <legend class="col-form-label">&nbsp;</legend>
           <LoadingButton
            :loading="isLoading"
            variant="primary"
            @click="searchLedger"
          >
          <i class="fas fa-search"></i>Search
           </LoadingButton>
        </div>
      </div>
    </div>
  </div>

  <div class="card mt-3">
    <CenteredSpinner v-if="isLoading" />
    <div v-else class="card-body table-responsive">
      

      <table class="table table-bordered table-striped text-center">
        <thead class="">
          <tr>
              <th>#</th>
              <th>Date</th>
              <th>Reference</th>
              <th>Transaction</th>
              <th class="text-end">Debit</th>
              <th class="text-end">Credit</th>
              <th class="text-end">Balance</th>
          </tr>
        </thead>
        <tbody>
            <!-- Opening Balance Row -->
          <tr class="table-warning fw-bold">
              <td colspan="6" class="text-end">Opening Balance</td>
              <td class="text-end">
                
                  {{ formatCurrency(ledgerData.openingBalance, 2,'') }}
              </td>
          </tr>
          <tr
              v-for="(item,index) in ledgerData.ledgers"
              :key="item.id"
          >
            <td>{{index+1}}</td>
            <td>{{userDateFormat(item.date)}} </td>
            <td>{{ item.reference_no }}</td>
            <td>{{ item.particular  }}</td>
            <td class="text-end">{{ formatCurrency(item.debit,2,'')}}</td>
            <td class="text-end">{{ formatCurrency(item.credit, 2,'')  }}</td>
            <td class="text-end fw-bold">
              {{ formatCurrency(item.running_balance, 2,'') }}
          </td>
          </tr>
        </tbody>
        <tfoot>
          <tr class="table-primary fw-bold">
            <td colspan="6" class="text-end">
              Closing Balance
            </td>
            <td class="text-end">{{ formatCurrency(ledgerData.closingBalance) }}</td>
          </tr>
        </tfoot>
      </table>
    </div>
    
  </div>
</div>


</template>