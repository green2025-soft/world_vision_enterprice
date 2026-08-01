<script setup>
import { ref, onMounted, defineProps, computed  } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import {  formatCurrency, printADiv, useImageUrl, userDateFormat } from '@/utilities/methods'
import { useSettingsStore } from '@/store/settings-store'
import { useRoute, useRouter } from 'vue-router'
const route = useRoute()
const router = useRouter()
const settingsStore = useSettingsStore()

const title = 'Supplier Due Payment'
const isSpinner = ref(false)

const props = defineProps({
  id: {
    type: [String, Number],
    required: false
  }
})

const { 
  getOne, 
} = useResourceApiClient('inventory/supplier-payment', title, true)

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
   
        <!-- ================= TRANSFER INFO ================= -->
        <div class="row mb-3 transfeerInfo">
            <div class="col-md-6">
                <div class="info-title">
                    Supplier Information
                </div>

                <table class="table table-bordered">

                    <tr>
                        <th>Name</th>
                        <td>{{objData?.supplier?.name}}</td>
                    </tr>

                

                    <tr>
                        <th>Mobile</th>
                        <td>{{objData?.supplier?.phone}}</td>
                    </tr>
                      <tr>
                        <th>E-mail</th>
                          <td>{{objData?.supplier?.email}}</td>
                    </tr>

                    <tr>
                        <th>Address</th>
                        <td>{{objData?.supplier?.address}}</td>
                    </tr>

                </table>
            </div>
            <div class="col-md-6">
                
                <div class="info-title">
                    Invoice Information
                </div>

                <table class="table table-bordered">

                    <tr>
                        <th>Invoice No</th>
                        <td>{{objData.invoice_no}}</td>
                    </tr>

                    <tr>
                        <th>Payment Date</th>
                        <td>{{userDateFormat(objData.payment_date)}}</td>
                    </tr>

                </table>
            </div>
        </div>

        <div class="mt-4">

            <div class="info-title">
                Payment Details
            </div>
            <div class="row">
                <div class="col-md-6"></div>    
                <div class="col-md-6">
                    <div class="summary-card">
                    <table class="table summary-table mb-0">
                        <tr>
                            <td>Payment</td>
                            <td class="text-end">{{ formatCurrency(objData.payment) }}</td>
                        </tr>
                        <tr>
                            <td>Adjustment</td>
                            <td class="text-end">{{ formatCurrency(objData.adjustment) }}</td>
                        </tr>
                    </table>
                    </div>
                </div>    
            </div>

            

        </div>
            <div class="mt-4">

            <div class="info-title">
                Note
            </div>

            <div class="note-box">
                {{ objData.note }}
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

.info-title {
    font-size: 18px;
    font-weight: 700;
    color: #0d6efd;
    margin-bottom: 12px;
    border-bottom: 2px solid #0d6efd;
    padding-bottom: 5px;
}

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

/* SUMMARY */

.summary-card{
    border:1px solid #dbe2ea;
    border-radius:10px;
    overflow:hidden;
}

.summary-table td{
    padding:10px 15px;
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