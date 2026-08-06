<script setup>
import { ref, onMounted, watch, computed, shallowRef } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { userDateFormat, useForm, dbDataFormat, printADiv, getNestedValue } from '@/utilities/methods'



//  Setup
const title = 'Product Stock Ledger'
const bUrl = 'inventory/reports/product-stock-ledger'

const {
customGet,
isLoading
} = useResourceApiClient(bUrl, title, true)


const currentPage = shallowRef(1);
const perPage = ref(10);

const { form } = useForm({
  product_id: null,
  from_date: new Date(),
  to_date: new Date(),
})



const errors  = ref({})
let objData = ref(false)
const items   = ref({})


async function fetchData() {
 try {
  form.value.from_date = dbDataFormat(form.value.from_date)
  form.value.to_date = dbDataFormat(form.value.to_date)
  const response = await customGet(bUrl, form.value)
  const responseData = response
  
  objData.value = responseData
  items.value = responseData.items

 }catch (err){
  if (err.response?.status === 422) {
      errors.value = err.response.data.errors
      objData.value = false
    }
 }
}

const search = ()=>fetchData()

</script>

<template>
  <div class="container-fluid">
      <div class="card shadow-sm mb-2">
          <div class="card-header bg-primary text-white">Filter Options</div>
          <div class="card-body">
             <ValidationErrors :errors="errors" />
            <div class="row">
              <div class="col-md-4">
                  <BaseFormGroup label="Product " labelCols="12" required>
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
          </div>
      </div>
    <CenteredSpinner  v-if="isLoading" />
      <template v-if="objData">
      <div class="text-end mb-2 no-print">
        <BButton  variant="primary" size="sm" @click="printADiv('dataTablePrint')">
          <i class="fas fa-print"></i> Print
        </BButton>
    </div>
    
     <div class="report" id="dataTablePrint">
        <div class="report-title">
            <h3>Product Stock Ledger Report</h3>
            <small>Stock Movement History</small>
        </div>
        
        <div class="row mb-4">
           <div class="col-md-6">
              <table class="table table-sm table-borderless mb-0">

                    <tr>
                        <th width="140">Product</th>
                        <td>: {{objData?.product?.name}} ({{objData?.product?.sku}})</td>
                    </tr>


                    <tr>
                        <th>Category</th>
                        <td>: {{objData?.product?.category?.name}}</td>
                    </tr>

                    <tr>
                        <th>Brand</th>
                        <td>: {{objData?.product?.brand?.name}}</td>
                    </tr>

                   

                </table>
           </div>
           <div class="col-md-6">
              <table class="table table-sm table-borderless mb-0">
                    <tr>
                        <th>From Date</th>
                        <td>: {{userDateFormat(form.from_date)}}</td>
                    </tr>

                    <tr>
                        <th>To Date</th>
                        <td>: {{userDateFormat(form.from_date)}}</td>
                    </tr>

                    <tr>
                        <th>Opening Stock</th>
                        <td><strong>: {{objData.opening.quantity}}</strong></td>
                    </tr>

                </table>
           </div>
        </div>
        <table class="table table-bordered table-hover text-center">

            <thead class="table-dark">

            <tr>

                <th width="60" >SL</th>
                <th width="150">Date</th>
                <th>Movement</th>
                <th width="120" >Stock In</th>
                <th width="120" >Stock Out</th>
                <th width="120">Balance</th>

            </tr>

            </thead>

            <tbody>

            <tr v-for="(item, index) in items" :key="index">

                <td>{{index+1}}</td>
                <td>{{userDateFormat(item.date)}}</td>
                <td>
                    <span class="badge" :class="item.is_stock_in?' bg-success':' bg-danger'">{{item.type_name}}</span>
                </td>
                <td> {{item.is_stock_in?item.quantity:'-'}}</td>
                <td>{{!item.is_stock_in?item.quantity:'-'}}</td>
                <td class=" fw-bold">{{item.balance}}</td>

            </tr>


            </tbody>

            <tfoot>

            <tr class="table-primary">

                <th colspan="5" class="text-end">
                    Closing Stock
                </th>

                <th class="text-center">
                    {{objData.closing.quantity}}
                </th>

            </tr>

            </tfoot>

        </table>
     </div>
     </template>
     
  </div>
</template>

 <style>
       
        .report{
            background:#fff;
            padding:25px;
            margin:30px auto;
            box-shadow:0 0 10px rgba(0,0,0,.08);
        }

        .report-title{
            text-align:center;
            border-bottom:2px solid #0d6efd;
            padding-bottom:10px;
            margin-bottom:20px;
        }

        .report-title h3{
            margin:0;
            font-weight:700;
        }

        .table td,
        .table th{
            vertical-align:middle;
        }

        .summary-card{
            border:1px solid #dee2e6;
            border-radius:5px;
            padding:12px;
            background:#f8f9fa;
        }

        @media print{

            body{
                background:#fff;
                -webkit-print-color-adjust: exact;
            }

            .report{
                box-shadow:none;
                margin:0;
                padding:0;
            }

            .no-print{
                display:none;
            }
        }
    </style>
