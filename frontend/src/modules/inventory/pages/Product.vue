<script setup>
import { ref } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm, formatDate } from '@/utilities/methods'


//  Setup
const title = 'Product'
const bUrl = 'inventory/products'

const {
  updateWithFile,
  create,
  askDelete,
  confirmDelete,
  getOne,
  confirmDeleteModal,
  formErrors,
  isSubmitting,
} = useResourceApiClient(bUrl, title, true)

//  Form Setup
const { form, reset } = useForm({
  name: '',
  category_id: '',
  unit_id: '',
  purchase_price: '',
  selling_price: '',
  re_order: '',
  made_by: '',
  upload_image: '',
  image: '',
  specification: '',
  status: 1,

})
const errors = ref([])
const showModal = ref(false)
const dataTableRef = ref(null)
const isEdit = ref(false)

//  Modal Open/Edit
function openModal(item = null) {
  errors.value = []
  reset()
  if (item) { 
    Object.assign(form.value, item)
    isEdit.value= true
  }else{
    isEdit.value= false
  }
  
  showModal.value = true
}

//  Save/Create/Update Item
async function saveItem() {
  try {
    if (form.value.id) {
      await updateWithFile(form.value.id, form.value)
    } else {
      await create(form.value)
    }

    await dataTableRef.value?.refresh()
    reset()
    showModal.value = false
  } catch (error) {
    errors.value = formErrors.value
  }
}

const viewOpenModal = ref(false)
const viewItem = ref(null)
const isLoading = ref(false)

// Function to open modal & load data
async function openViewModal(id) {
  isLoading.value = true
  try {
    const data = await getOne(id)
    viewItem.value = data
    viewOpenModal.value = true
  } catch (err) {
    console.error('Failed to load item', err)
  } finally {
    isLoading.value = false
  }
}



</script>

<template>
     <ConfirmDelete ref="confirmDeleteModal"  @confirm="() => confirmDelete(() => dataTableRef.refresh())" />
     <div class="container-fluid">
        <div class="container ">
    <div class="card card-outline card-info">
        <div class="card-header">
             <h2 class="card-title"><i class="fas fa-tasks"></i> {{ title }}</h2>
            <div class="card-tools">
              <BButton variant="primary" size="sm" @click="openModal()"><i class="fas fa-plus"></i> Add New</BButton>
            </div>
        </div>
        <div class="card-body">

          
          <DataTable
           ref="dataTableRef"
                    :fields="[
                      { key: 'sl', label: 'SL' },
                      { key: 'sku', label: 'Code' },
                      { key: 'name', label: 'name' },
                      { key: 'category.name', label: 'Category' },
                      { key: 'brand.name', label: 'Brand' },
                      { key: 'made_by', label: 'Made By' },
                      { key: 'image', label: 'Image', isChange: true,  align: 'center' },
                      { key: 'status', label: 'Status', isChange: true, width: '140px',  align: 'center' },
                      { key: 'actions', label: 'Actions' }
                    ]"
                    :bUrl="bUrl"
                    :isBranch="true"
                  >
                      <template #cell-image="{ item }">
                          <GlobalImage :src="item.image" wrapperClass="m-auto" :size="50"/>
                    </template>
                    <template #cell-status="{ item }">
                      <StatusDisplay :value="item.status" />
                    </template>
                   <template #actions="{ rowItem }">
                         <div class="btn-group dropleft">
                            <BButton variant="outline-primary"  @click="openViewModal(rowItem.id)">
                              <i class="fa fa-table"></i>
                            </BButton>
                              <BButton variant="primary" class="dropdown-toggle dropdown_toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                              </BButton>

                            <ul class="dropdown-menu" >
                               <li><a class="dropdown-item"   @click="openModal(rowItem)"><i class="fa fa-edit"></i> Edit</a></li>
                                    <li> <div class="dropdown-divider"></div></li>
                               <li><a class="dropdown-item" href=""  @click="askDelete(rowItem.id)"><i class="fa fa-trash"></i> Delete</a></li>
                            </ul>
                        
                        </div>
                   </template>
            </DataTable>
        </div>
      

    </div>

  </div>
    </div>

    <FormModal
  v-model="showModal"
  :title="form.id ? `Edit ${title}` : `Add ${title}`"
  :loading="isSubmitting"
  size="lg"
  
  @submit="saveItem"
>
  <ValidationErrors :errors="errors"  />
    <BaseFormGroup label="Product Name" labelCols="3"  required>
      <BFormInput v-model="form.name" />
    </BaseFormGroup>
    <BaseFormGroup label="Category" labelCols="3" required>
      <ResourceSelect
      v-model="form.category_id"
      bUrl="inventory/categories"
      :isBranch="true"
      :isEdit="isEdit"
      placeholder="Select Category" />
    </BaseFormGroup>
    <BaseFormGroup label="Product Brand" labelCols="3">
    <ResourceSelect
      v-model="form.brand_id"
      bUrl="inventory/brands"
      :isBranch="true"
      :isEdit="isEdit"
      placeholder="Select Brands" />
    </BaseFormGroup>
    <!-- Slot: Input fields -->
    <BaseFormGroup label="Product Model" labelCols="3"  >
      <BFormInput v-model="form.made_by" />
    </BaseFormGroup>

     <BaseFormGroup label="Unit" labelCols="3">
      <ResourceSelect
        v-model="form.unit_id"
        bUrl="inventory/units"
        :isBranch="true"
        :isEdit="isEdit"
        placeholder="Select unit" />
    </BaseFormGroup>
    <BaseFormGroup label="Purchase Pricel" labelCols="3"  >
       <PriceInput v-model="form.purchase_price" />
    </BaseFormGroup>
     <BaseFormGroup label="Sales Pricel" labelCols="3"  >
       <PriceInput v-model="form.selling_price" />
    </BaseFormGroup>
    <BaseFormGroup label="Re Order" labelCols="3"  >
       <PriceInput v-model="form.re_order" />
    </BaseFormGroup>
    <BaseFormGroup label="Specification" labelCols="3"  >
      <BFormInput v-model="form.specification" />
    </BaseFormGroup>
    <BaseFormGroup label="Status" labelCols="3"  required>
       <StatusSelect v-model="form.status" />
    </BaseFormGroup>
    <BaseFormGroup label="Product Image" labelCols="3"  >
      <FileUpload v-model="form.upload_image"  preview  :dbImage="form.image" />
  </BaseFormGroup>


    </FormModal>


     <b-modal v-model="viewOpenModal" size="lg" :title=" title +' Details'" hide-footer centered>
    <div v-if="viewItem" class="row g-4">

      <!-- Left Column -->
      <div class="col-md-8">
        <div class="table-responsive">
          <table class="table table-striped align-middle">
            <tbody>
              <TableRow label="Name" :value="viewItem.name" />
              <TableRow label="SKU" :value="viewItem.sku" />
              <TableRow label="Category" :value="viewItem.category?.name" />
              <TableRow label="Unit" :value="viewItem.unit?.name" />
              <TableRow label="Brand" :value="viewItem.brand?.name" />
              <TableRow label="Purchase Price" :value="viewItem.purchase_price" />
              <TableRow label="Selling Price" :value="viewItem.selling_price" />
              <TableRow label="Stock Quantity" :value="viewItem.stock_quantity" />
              <TableRow label="Re-order Level" :value="viewItem.re_order" />
              <TableRow label="Status">
                <StatusDisplay :value="viewItem.status" />
              </TableRow>
              <TableRow label="Made By" :value="viewItem.made_by" />
              <TableRow label="Specification" :value="viewItem.specification" />
              <TableRow label="Created At" :value="formatDate(viewItem.created_at)" />
              <TableRow label="Updated At" :value="formatDate(viewItem.updated_at)" />
            </tbody>
          </table>
        </div>
      </div>

      <!-- Right Column - Product Image -->
      <div class="col-md-4 text-center">
        <div class="border rounded p-2 shadow-sm">
         <!-- <GlobalImage :src="viewItem.image" wrapperClass="m-auto" /> -->
          <GlobalImage :src="viewItem.image" wrapperClass="m-auto" style="max-height: 250px;" />
          <p class="mt-2 small text-muted">Product Image</p>
        </div>
      </div>

    </div>

    <div v-else class="text-center py-5">
      <b-spinner small />
      <p class="mt-2">Loading...</p>
    </div>
  </b-modal>


</template>
