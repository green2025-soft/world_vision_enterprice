<script setup>
import { ref, onMounted, defineProps } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { formatDateWithFormat,  formatCurrency, printADiv, useImageUrl } from '@/utilities/methods'
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
} = useResourceApiClient('inventory/purchase-return', title, true)

const objData= ref('');

onMounted(async () => {
  try{
   isSpinner.value= true
   objData.value = await getOne(props.id)
  }catch {

  }
  isSpinner.value= false
   
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
        <div class="row align-items-center mb-4">
            <div class="col-md-12 mb-3">
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
            <div class="col-md-12 text-center">
                <h5> <strong class="invoice-badge">PURCHASE RETURN</strong></h5>
            </div>
        </div>

        <!-- Supplier & Invoice Info -->
        <div class="row g-3 mb-4">

            <div class="col-md-6">
                <div class="info-box">
                    <div class="section-title">
                        <i class="fas fa-truck me-1"></i>
                        Supplier Information
                    </div>

                    <strong>{{ objData?.supplier?.name }}</strong><br>
                    {{ objData?.supplier?.address }}
                    Phone: {{ objData?.supplier?.phone }}<br>
                    Email:  {{ objData?.supplier?.email }}
                </div>
            </div>

            <div class="col-md-6" id="invoiceDetails">
                <div class="info-box">
                    <div class="section-title">
                        <i class="fas fa-info-circle me-1"></i>
                        Invoice Details
                    </div>
                    <table class="table table-borderless table-sm">
                        <tr>
                            <td><strong>Date: </strong></td>
                            <td class="text-end"> {{formatDateWithFormat(objData.return_date, 'd M, Y')}}</td>
                        </tr>
                        <tr>
                            <td><strong>Return No:</strong></td>
                            <td class="text-end"> {{ objData.invoice_no }}</td>
                        </tr>
                        <tr>
                            <td><strong>Reference Inv:</strong></td>
                            <td class="text-end"> {{ objData?.purchase?.invoice_no }}</td>
                        </tr>
                    </table>
                </div>
            </div>

        </div>
        
{{ objData }}
        <!-- Product Table -->
        <div class="table-responsive mb-2">
            <table class="table table-bordered align-middle">
                <thead>
                <tr>
                    <th width="40" class="text-center">#</th>
                    <th>Product Name</th>
                    <th width="120" class="text-end">Return Qty</th>
                    <th width="120" class="text-end">Wastage Qty</th>
                    <th width="100" class="text-end">Amount</th>
                </tr>
                </thead>

                <tbody>
               <tr v-for="(item, index) in objData.items" :key="index">
                
                      <td class="text-center">{{ ++index }}</td>
                      <td> {{ item?.product?.name }} ({{ item?.product?.sku }})</td>
                      <td class="text-end">{{ item.return_qty }}</td>
                      <td class="text-end">{{ item.wastage_qty }}</td>
                      <td class="text-end">{{ item.total_refund_price}}</td>
                  </tr>

                </tbody>
            </table>
        </div>

        <!-- Summary -->
        <div class="row">

            <div class="col-md-6 mt-2">
                <div class="note-box" v-if="objData.remarks">
                    <strong>Notes:</strong>
                    <hr>
                    {{ objData.remarks }}
                    
                </div>
            </div>

            <div class="col-md-6">
                <div class="summary-card">

                   
              

                    <table class="table summary-table mb-0">

                       

                        <tr v-if="objData.cash_refund_amount >0">
                            <td>Cash Return </td>
                            <td class="text-end">{{ formatCurrency(objData.cash_refund_amount) }}</td>
                        </tr>

                        <tr v-if="objData.adjusted_due_amount >0">
                            <td>Due Adjusted </td>
                            <td class="text-end">{{ formatCurrency(objData.adjusted_due_amount) }}</td>
                        </tr>
                        <tr v-if="objData.supplier_advance >0">
                            <td>Supplier Advance </td>
                            <td class="text-end">{{ formatCurrency(objData.supplier_advance) }}</td>
                        </tr>

                        <tr class="grand-total">
                            <td>Total Return Amount</td>
                            <td class="text-end">{{ formatCurrency(objData.total_refund_amount) }}</td>
                        </tr>
                    
                    </table>

                </div>
                
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
    background:#fee2e2;
    color:#dc2626;
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
    color:#dc2626;
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
    background:#dc2626;
    color:#fff;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:28px;
}

/* SECTION */

.section-title{
    font-size:15px;
    font-weight:600;
    color:#dc2626;
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
    color:#dc2626;
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