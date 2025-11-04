<script setup>
import { ref, onMounted } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm, formatDate } from '@/utilities/methods'
import { toast } from 'vue3-toastify'


//  Setup
const title = 'Purchase'
const bUrl = 'inventory/purchases'

const {
  askDelete,
  confirmDelete,
  confirmDeleteModal,

} = useResourceApiClient(bUrl, title, true)



const dataTableRef = ref(null)

onMounted(() => {
    const toastMessage = sessionStorage.getItem('purchaseToastMessage')
    if (toastMessage) {
       const { message, type } = JSON.parse(toastMessage)
       toast.success(message)
    }
  sessionStorage.removeItem('purchaseToastMessage')

})


</script>

<template>
     <ConfirmDelete ref="confirmDeleteModal"  @confirm="() => confirmDelete(() => dataTableRef.refresh())" />
     <div class="container-fluid">
        <div class="container ">
    <div class="card card-outline card-info">
        <div class="card-header">
             <h2 class="card-title"><i class="fas fa-tasks"></i> {{ title }}</h2>
            <div class="card-tools">
              <RouterLink class="btn btn-primary btn-sm" :to="`/${bUrl}/create`"><i class="fas fa-plus"></i> Add New</RouterLink>
            </div>
        </div>
        <div class="card-body">

          
          <DataTable
           ref="dataTableRef"
                    :fields="[
                      { key: 'sl', label: 'SL' },
                      { key: 'invoice_no', label: 'Invoice No', align: 'center'  },
                      { key: 'invoice_date', label: 'date', align: 'center'  },
                      { key: 'supplier.name', label: 'Supplier' },
                      
                      { key: 'total_amount', label: 'Total', align: 'right'  },
                      { key: 'discount_amount', label: 'discount', align: 'right'  },
                      { key: 'tax_amount', label: 'Tex', align: 'right'  },
                      { key: 'net_total', label: 'Sub Total', align: 'right'  },
                      { key: 'supplier_adjust', label: 'Adjustment', align: 'right'  },
                      { key: 'paid_amount', label: 'Paid', align: 'right'  },
                      { key: 'due_amount', label: 'due', align: 'right'  },
                      
                      
                      { key: 'actions', label: 'Actions' }
                    ]"
                    :bUrl="bUrl"
                    :isBranch="true"
                  >
                
               
                   <template #actions="{ rowItem }">
                         <div class="btn-group dropleft">
                            <BButton variant="outline-primary"  >
                              <i class="fa fa-table"></i>
                            </BButton>
                              <BButton variant="primary" class="dropdown-toggle dropdown_toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                              </BButton>

                            <ul class="dropdown-menu" >
                               <li>
                                  <RouterLink class="dropdown-item" :to="`/${bUrl}/${rowItem.id}/edit`"><i class="fas fa-edit"></i> Edit</RouterLink>
                                
                              </li>
                                    <li> <div class="dropdown-divider"></div></li>
                               <li><a class="dropdown-item" href=""  @click.prevent="askDelete(rowItem.id)"><i class="fa fa-trash"></i> Delete</a></li>
                            </ul>
                        
                        </div>
                   </template>
            </DataTable>
        </div>
      

    </div>

  </div>
    </div>

    


</template>
