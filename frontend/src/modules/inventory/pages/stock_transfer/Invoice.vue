<script setup>
import { ref, onMounted, defineProps, computed  } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { formatDateWithFormat,  formatCurrency, printADiv, useImageUrl } from '@/utilities/methods'
import { useSettingsStore } from '@/store/settings-store'
import { useRoute, useRouter } from 'vue-router'
const route = useRoute()
const router = useRouter()
const settingsStore = useSettingsStore()

const title = 'Stock Transfers'
const isSpinner = ref(false)

const props = defineProps({
  id: {
    type: [String, Number],
    required: false
  }
})

const { 
  getOne, 
} = useResourceApiClient('inventory/stock-transfers', title, true)

const objData= ref('');

onMounted(async () => {
  try{
   isSpinner.value= true
   objData.value = await getOne(props.id)
  }catch {

  }
  isSpinner.value= false
   
})

const totalQuantity = computed(() => {
  return (objData.value?.items || []).reduce(
    (sum, item) => sum + Number(item.quantity || 0),
    0
  )
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
              
    <div class="invoice-wrapper" id="invoicePrint">

        <!-- Header -->
        <div class="row align-items-center mb-3">
            <div class="col-md-12">
                <div class="d-flex align-items-center">
                    <div class="company-logo me-3">
                        <img width="70" height="70" :src="useImageUrl(settingsStore.data.app_logo)" />
                    </div>

                    <div>
                        <h1 class="invoice-title">{{ settingsStore.data.app_name  }}</h1>
                        <div>{{ settingsStore.data.app_address }}</div>
                        <div>{{ settingsStore.data.app_contact }}</div>
                        <div>{{ settingsStore.data.app_email }}</div>
                    </div>
                </div>
            </div>
         
        </div>
         <hr>
        <div class="col-md-12 text-center mb-3">
            <h5> <strong class="invoice-badge"><i class="fas fa-exchange-alt"></i> BRANCH TO BRANCH STOCK TRANSFER</strong></h5>
        </div>
        <!-- ================= TRANSFER INFO ================= -->
        <div class="row mb-3 transfeerInfo">
            <div class="col-md-6">
                <table class="table table-bordered table-sm">
                    <tr>
                        <th width="40%">Transfer No</th>
                        <td>{{objData.transfer_no}}</td>
                    </tr>
                    <tr>
                        <th>Transfer Date</th>
                        <td>{{formatDateWithFormat(objData.transfer_date, 'd M, Y')}}</td>
                    </tr>
                    
                </table>
            </div>
            <div class="col-md-6">
                <table class="table table-bordered table-sm">
                    <tr>
                        <th width="40%">Status</th>
                        <td>{{objData.status}} </td>
                    </tr>
                    <tr>
                        <th>Transfer By</th>
                        <td> {{objData?.user?.name}} </td>
                    </tr>
                </table>
            </div>
        </div>
        <!-- ================= BRANCH INFORMATION ================= -->
        <div class="row mb-3">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-store"></i> From Branch
                    </div>
                    <div class="card-body">
                        <h5>{{ objData?.from_branch?.name}}</h5>
                        <p class="mb-0">Contact : {{ objData?.from_branch?.contact_no}}</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header ">
                        <i class="fas fa-store"></i> To Branch
                    </div>
                    <div class="card-body">
                          <h5>{{ objData?.to_branch?.name}}</h5>
                        <p class="mb-0">Contact : {{ objData?.to_branch?.contact_no}}</p>
                    </div>
                </div>
            </div>
        </div>

       


            

          

        <!-- Product Table -->
        <div class="table-responsive mb-2">
            <table class="table table-bordered align-middle">
                <thead>
                <tr>
                    <th width="40" class="text-center">#</th>
                    <th>Product Name</th>
                    <th width="100" class="text-end">Qty</th>
                    <th width="120" class="text-end">Unit Cost</th>
                    <th width="120" class="text-end">Total</th>
                </tr>
                </thead>

                <tbody>
               <tr v-for="(item, index) in objData.items" :key="index">
                
                      <td class="text-center">{{ ++index }}</td>
                      <td> {{ item?.product?.name }} ({{ item?.product?.sku }})</td>
                      <td class="text-end">{{ (item.quantity) }}</td>
                      <td class="text-end">{{ formatCurrency(item.unit_cost) }}</td>
                      <td class="text-end">{{ formatCurrency(item.total_cost)}}</td>
                      
                  </tr>

                </tbody>
            </table>
        </div>

        <!-- ================= SUMMARY ================= -->
        <div class="row mb-3">
            <div class="col-md-7">
                <h6 class="fw-bold">
                    <i class="fas fa-sticky-note text-warning"></i> Remarks
                </h6>
                <p>{{ objData.note }}</p>
            </div>
            <div class="col-md-5">
                <table class="table table-bordered align-middle">
                    <tbody>
                    <tr>
                        <th width="60%"> Total Items </th>
                        <td class="text-end">{{ totalQuantity }}</td>
                    </tr>
                    <tr>
                        <th> Total Cost </th>
                        <td class="text-end text-danger font-weight-bold"> {{ formatCurrency(objData.total_amount) }} </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

      

        
        <div class="print-spacer"></div>
        <!-- Signature -->
        <div class="row signature-section">
            <div class="col-md-6">
                <div class="signature">
                    <div class="signature-line"></div>
                    Supplier Signature
                </div>
            </div>

            <div class="col-md-6">
                <div class="signature">
                    <div class="signature-line"></div>
                    Authorized Signature
                </div>
            </div>
        </div>

      

    </div>


            
        </div>
      </div>
</template>
<style scoped>



/* MAIN WRAPPER */

.invoice-badge{
    background:rgb(13 110 253 / 12%);
    color:#0d6efd;
    padding:10px 20px;
    border-radius:8px;
    font-weight:700;
    font-size:18px;
    display:inline-block;
}

/* MAIN WRAPPER */

.invoice-wrapper{
    max-width:1100px;
    margin:30px auto;
    background:#fff;
    padding:30px;
    border-radius:10px;
    box-shadow:0 0 15px rgba(0,0,0,.08);
}

/* HEADER */

.invoice-title{
    font-size:32px;
    font-weight:700;
    color:#0d6efd;
    margin-bottom:5px;
}

.invoice-number{
    font-size:15px;
    color:#6c757d;
}

.company-logo{
    width:70px;
    height:70px;
    border-radius:8px;
    background:#0d6efd;
    color:rgb(13 110 253 / 12%);
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:28px;
}

/* SECTION */

.section-title{
    font-size:15px;
    font-weight:600;
    color:#0d6efd;
    margin-bottom:10px;
    text-transform:uppercase;
}

.info-box{
    border:1px solid #dee2e6;
    border-radius:8px;
    padding:15px;
    height:100%;
}



.table th{
    font-weight:600;
    vertical-align:middle;
}

.table td{
    vertical-align:middle;
}

/* SUMMARY */

.summary-card{
    border:1px solid #dbe2ea;
    border-radius:10px;
    overflow:hidden;
}



.summary-table td{
    padding:10px 15px;
}

.grand-total{
    background:#dbeafe;
    font-weight:700;
    font-size:18px;
    color:#0d6efd;
}

/* NOTE */

.note-box{
    border:1px dashed #adb5bd;
    border-radius:8px;
    padding:15px;
    min-height:90px;
}

/* SIGNATURE */

.signature-section{
    margin-top:80px;
}

.signature{
    text-align:center;
}

.signature-line{
    border-top:1px solid #000;
    width:220px;
    margin:0 auto 8px;
}

/* PRINT SPACER */

.print-spacer{
    height:60px;
}

.transfeerInfo td, .transfeerInfo th{
    padding: 3px 6px;
    border-width: 1px !important;
}

/* PRINT */

@media print{

    html,
    body{
        margin:0;
        padding:0;
        background:#fff;
    }

    .invoice-wrapper{
        box-shadow:none;
        margin:0;
        max-width:100%;
        padding:15px;
    }

    .no-print{
        display:none !important;
    }

    /* TABLE BREAK FIX */

    table{
        page-break-inside:auto;
    }

    tr{
        page-break-inside:avoid;
        page-break-after:auto;
    }

    thead{
        display:table-header-group;
    }

    tfoot{
        display:table-footer-group;
    }

    /* SIGNATURE */

    .signature-section{
        page-break-inside:avoid;
        break-inside:avoid;
        margin-top:100px;
    }

    .print-spacer{
        height:200px;
    }

}

</style>