<script setup>
import { ref, onMounted } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm, formatCurrency } from '@/utilities/methods'



//  Setup
const title = 'Supplier Due List'
const bUrl = '/inventory/suppliers/due-list'

const {


} = useResourceApiClient(bUrl, title, true)


const dataTableRef = ref(null)

onMounted(() => {
})

</script>

<template>
     
     <div class="container-fluid">
        <div class=" ">
    <div class="card card-outline card-info">
        <div class="card-header">
             <h2 class="card-title"><i class="fas fa-tasks"></i> {{ title }}</h2>
            <div class="card-tools">
              
            </div>
        </div>
        <div class="card-body">

          
          <DataTable ref="dataTableRef"
                    :fields="[
                      { key: 'sl', label: 'SL' },
                      { key: 'name', label: 'Supplier Name'  },
                      { key: 'phone', label: 'Phone', align: 'center'  },
                      { key: 'credit_total', label: 'Total Payment', align: 'right'  },
                      { key: 'balance', label: 'Total Due', align: 'right'  },
                    ]"
                    :bUrl="bUrl"
                    :isBranch="true"
                  >
              <template #custom-foot="{ response }">
                  <tr class="table-info fw-bold">
                    <td colspan="3" class="text-end">Grand Total</td>
                    <td class="text-end"> {{ response.summary?.credit_total}}</td>
                    <td class="text-end"> {{ response.summary?.balance }}</td>
                  </tr>
              </template>
            </DataTable>
        </div>
      

    </div>

  </div>
    </div>
</template>
