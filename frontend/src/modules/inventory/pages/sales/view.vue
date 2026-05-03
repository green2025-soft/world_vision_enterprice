<script setup>
import { ref, onMounted, defineProps } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { formatDateWithFormat,  formatCurrency, printADiv } from '@/utilities/methods'
import { useSettingsStore } from '@/store/settings-store'
import { useRoute, useRouter } from 'vue-router'
const route = useRoute()
const router = useRouter()
const settingsStore = useSettingsStore()

const title = 'Pos'
const isSpinner = ref(false)

const props = defineProps({
  id: {
    type: [String, Number],
    required: false
  }
})

const { 
  getOne, 
} = useResourceApiClient('inventory/sales', title, true)

const objData= ref('');

onMounted(async () => {
  try{
   isSpinner.value= true
   objData.value = await getOne(props.id)
  }catch {

  }
  isSpinner.value= false
   if (route.query.print === 'true') {
    setTimeout(() => {
      printADiv('invoicePrint');
       router.push(`/inventory/pos`)
        // router.back()
    }, 100)
  }
})

</script>
<template>
      <div class="container-fluid">
        <CenteredSpinner v-if="isSpinner"  />
        <div class="container " v-else>
          <div style="position: absolute;right: 40px;" class="no-print">
              <button @click="printADiv('invoicePrint')" class="btn btn-warning btn-sm">
            <i class="fa fa-print"></i> Print
          </button>
        </div>
              
            <div class="invoice-box" id="invoicePrint">

              <!-- HEADER -->
              <div class="text-center">
                  <h5 class="mb-0 fw-bold text-uppercase">{{ settingsStore.data.app_name  }}</h5>
                  <div class="text-small"> {{ settingsStore.data.app_address }}</div>
                  <div class="text-small"> {{ settingsStore.data.app_contact }}</div>
              </div>

              <div class="dashed"></div>

              <!-- INFO -->
              <div class="row text-small">
                  <div class="col-6">
                  <strong>Inv:</strong>  {{ objData.invoice_no }}<br>
                  </div>
                  <div class="col-6 text-end">
                    <strong>Date:</strong> {{formatDateWithFormat(objData.invoice_date, 'd M, Y')}}
                  </div>
                  <div class="col-12">
                    <strong>Customer:</strong>  {{ objData?.customer?.name }}
                  </div>
                  <div class="col-6 ">
                    <strong>Mobile :</strong> {{ objData?.customer?.phone }}
                  </div>
                  <!-- <div class="col-6 text-end" >
                    <strong>Address:</strong> {{ objData?.customer?.address }}
                  </div> -->
              </div>

              <div class="dashed"></div>

              <!-- ITEMS -->
              <table class="table table-borderless">
                  <thead>
                  <tr>
                      <th>#</th>
                      <th>Item</th>
                      <th class="text-end">Qty</th>
                      <th class="text-end">Price</th>
                      <th class="text-end">Total</th>
                  </tr>
                  </thead>
                  <tbody>
                  <tr v-for="(item, index) in objData.items" :key="index">
                      <td>{{ ++index }}</td>
                      <td> {{ item.name }}</td>
                      <td class="text-end">{{ item.quantity }}</td>
                      <td class="text-end">{{ item.sale_price }}</td>
                      <td class="text-end">{{ item.sale_price * item.quantity}}</td>
                  </tr>

                  
                  </tbody>
              </table>

              <div class="dashed"></div>

              <!-- TOTAL -->
              <table class="table table-borderless text-small">
                  <tr>
                  <td>Subtotal</td>
                  <td class="text-end">{{ formatCurrency(objData.total_amount) }}</td>
                  </tr>
                  <tr>
                  <td>Discount - </td>
                  <td class="text-end">{{ formatCurrency(objData.discount_amount) }}</td>
                  </tr>
                  <tr>
                  <td>Tax + </td>
                  <td class="text-end">{{ formatCurrency(objData.tax_amount) }}</td>
                  </tr>
                  <tr>
                  <td>Adjustment -</td>
                  <td class="text-end">{{ formatCurrency(objData.adjustment) }}</td>
                  </tr>

                  <tr class="fw-bold">
                  <td>Total</td>
                  <td class="text-end">{{ formatCurrency(objData.net_total) }}</td>
                  </tr>

                  <tr>
                  <td>Paid</td>
                  <td class="text-end">{{ formatCurrency(objData.paid_amount) }}</td>
                  </tr>

                  <tr class="fw-bold">
                  <td>Due</td>
                  <td class="text-end">{{ formatCurrency(objData.due_amount) }}</td>
                  </tr>
              </table>

              <div class="dashed"></div>

              <!-- FOOTER -->
              <div class="text-center text-small">
                  <p class="mb-1">Thank You!</p>
                  <!-- <p class="mb-0">Powered by POS System</p> -->
              </div>

            </div>
            
        </div>
      </div>
</template>
<style scoped>

.invoice-box {
      max-width: 420px;
      margin: auto;
      background: #fff;
      padding: 15px;
      border: 1px solid #ddd;
    }

    .text-small {
      font-size: 12px;
    }

    .table td, .table th {
      padding: 4px;
      font-size: 12px;
    }

    .dashed {
      border-top: 1px dashed #000;
      margin: 8px 0;
    }

    @media print {
      body {
        background: #fff;
      }
      .invoice-box {
        border: none;
        width: 100%;
      }
      .invoice-box h5{
        font-size: 15px;
      }
      .table td, .table th {
         padding: 2px;
      }
    }
</style>