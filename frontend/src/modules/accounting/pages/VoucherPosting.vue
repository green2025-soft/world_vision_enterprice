<script setup>
import { ref, computed, onMounted } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm, userDateFormat, dbDataFormat,printADiv, numberToWords } from '@/utilities/methods'
import { useSettingsStore } from '@/store/settings-store'
const settingsStore = useSettingsStore()

// Setup
const title = 'Voucher Posting'
const bUrl = 'accounting/journal-entries'

const {
  update,
  getOne,
  create,
  askDelete,
  confirmDelete,
  customGet,
  confirmDeleteModal,
  formErrors,
  isSubmitting,
} = useResourceApiClient(bUrl, title, true)

const isEdit = ref(false)
const showModal = ref(false)
const dataTableRef = ref(null)
const errors = ref([])

// Form Setup
const { form, reset } = useForm({
  name: '',
  date: new Date(),
  voucher_type: '',
  narration: '',
  reference: '',
  lines: [
    { account_head_id: null, debit: 0, credit: 0 }
  ]
})

// Modal open for create/edit
async function openModal(item = null) {
  errors.value = []
  reset()

  if (item) {
    
    Object.assign(form.value, item)
    form.value.lines = JSON.parse(JSON.stringify(item.details || []))  
    isEdit.value = true
  } else {
    isEdit.value = false
    form.value.lines = [{ account_head_id: null, debit: 0, credit: 0 }]
    form.value.reference = await customGet('accounting/generate-reference-no');
  }

  showModal.value = true
}

// Add/Remove Lines
function addLine() {
  form.value.lines.push({
    account_head_id: null,
    debit: 0,
    credit: 0,
  })
}

function removeLine(index) {
  if (form.value.lines.length > 1) {
    form.value.lines.splice(index, 1)
  }
}

function handleAmountInput(index, type) {
  if (type === 'debit') {
    form.value.lines[index].credit = 0
  } else {
    form.value.lines[index].debit = 0
  }
}

const totalDebit = computed(() =>
  form.value.lines.reduce((sum, line) => sum + Number(line.debit || 0), 0)
)
const totalCredit = computed(() =>
  form.value.lines.reduce((sum, line) => sum + Number(line.credit || 0), 0)
)

// Validate before submit
async function saveItem() {
  if (totalDebit.value !== totalCredit.value) {
    errors.value = ['Total Debit and Credit must be equal.']
    return
  }



  try {
    form.value.date = dbDataFormat(form.value.date)
    if (form.value.id) {
      await update(form.value.id, form.value)
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
  <!-- Confirm Delete Modal -->
  <ConfirmDelete
    ref="confirmDeleteModal"
    @confirm="() => confirmDelete(() => dataTableRef.refresh())"
  />

  <!-- Main Table -->
  <div class="container-fluid">
    <div class="container">
      <div class="card card-outline card-info">
        <div class="card-header d-flex justify-content-between align-items-center">
          <h2 class="card-title"><i class="fas fa-box"></i> {{ title }}</h2>
          <BButton variant="primary" size="sm" @click="openModal()">
            <i class="fas fa-plus"></i> Add New
          </BButton>
        </div>

        <div class="card-body">
          <DataTable
            ref="dataTableRef"
            :fields="[
              { key: 'sl', label: 'SL' },
              { key: 'date', label: 'Date', isChange: true, align: 'center' },
              { key: 'voucher_type', label: 'Voucher Type' },
              { key: 'reference', label: 'Reference Number', align: 'center' },
              { key: 'voucher_no', label: 'Voucher Number', align: 'center' },
              { key: 'narration', label: 'Narration', align: 'center' },
              { key: 'debit', label: 'Debit', align: 'center' },
              { key: 'credit', label: 'Credit', align: 'center' },
              { key: 'actions', label: 'Actions' }
            ]"
            :bUrl="bUrl"
            :isBranch="true"
          >
            <template #cell-date="{ item }">
              {{ userDateFormat(item.date) }}
            </template>

            <template #actions="{ rowItem }">
              <div class="btn-group">
                <BButton variant="outline-primary"  @click="openViewModal(rowItem.id)">
                    <i class="fa fa-table"></i>
                </BButton>
                <BButton variant="outline-info" @click="openModal(rowItem)">
                  <i class="fa fa-edit"></i>
                </BButton>
              
              </div>
            </template>
          </DataTable>
        </div>
      </div>
    </div>
  </div>

  <!-- Modal Form -->
  <FormModal
    v-model="showModal"
    :title="form.id ? `Edit ${title}` : `Add ${title}`"
    :loading="isSubmitting"
    size="xl"
    @submit="saveItem"
    class="voucher-posting-modal"
  >
    <ValidationErrors :errors="errors" />
    

    <div class="row">
      
      <div class="col-md-6">
        <BaseFormGroup label="Date" labelCols="12" required>
          <DatePicker v-model="form.date" :max-date="new Date()" />
        </BaseFormGroup>
      </div>
      <div class="col-md-6">
        <BaseFormGroup label="Voucher Type" labelCols="12" required>
          <ResourceSelect
            v-model="form.voucher_type"
            bUrl="accounting/voucher-types"
            placeholder="Select Voucher Type"
            valueField="name"
            :clearable="false"
          />
        </BaseFormGroup>
      </div>
    </div>

    <div class="row mb-3">
      <div class="col-md-6">
        <BaseFormGroup label="Reference Number" labelCols="12" required>
          <BFormInput v-model="form.reference" />
        </BaseFormGroup>
      </div>
      <div class="col-md-6">
        <BaseFormGroup label="Narration" labelCols="12">
          <BFormInput v-model="form.narration" />
        </BaseFormGroup>
      </div>
    </div>

    <!-- Line Items Table -->
    <div class="table-responsive lines-table">
      <table class="table table-bordered mb-0">
        <thead class="thead-light">
          <tr>
            <th>Account Head</th>
            <th style="width: 20%; text-align: center">Debit</th>
            <th style="width: 20%; text-align: center;">Credit</th>
            <th style="width: 50px;">Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(line, index) in form.lines" :key="index" class="line-row">
            <td class="account-head-cell">
           <ResourceSelect
              v-model="line.account_head_id"
              bUrl="accounting/account-heads"
              :clearable="false"
              :labelField="(item) => `(${item.code}) ${item.name} (${item.type})`"
              :isEdit="isEdit"
            />
            </td>
            <td>
              <BFormInput
                type="number"
                v-model="line.debit"
                 class="text-center"
                min="0"
                @input="handleAmountInput(index, 'debit')"
              />
            </td>
            <td>
              <BFormInput
                type="number"
                v-model="line.credit"
                min="0"
                @input="handleAmountInput(index, 'credit')"
                class="text-center"
              />
            </td>
          <td class="text-center d-flex justify-content-center align-items-center">
              <BButton
                v-if="index === 0"
                size="sm"
                variant="success"
                @click="addLine"
                title="Add Line"
                class="d-block"
              >
                <i class="fas fa-plus"></i>
              </BButton>

              <BButton
                v-else
                size="sm"
                variant="danger"
                @click="removeLine(index)"
                title="Remove Line"
                 class="d-block"
              >
                <i class="fas fa-trash"></i>
              </BButton>
            </td>
          </tr>
        </tbody>
        <tfoot>
          <tr>
          <th colspan="4" class="text-end">  <span
          :class="{
            'text-success': totalDebit === totalCredit,
            'text-danger': totalDebit !== totalCredit
          }"
        >
          <strong>Total Debit:</strong> {{ totalDebit.toFixed(2) }} |
          <strong>Total Credit:</strong> {{ totalCredit.toFixed(2) }}
        </span>
      </th>
      
          </tr>
        </tfoot>
      </table>

      <!-- Totals -->
      <div class="text-end mt-2">
      
      </div>
    </div>
  </FormModal>


<BModal
  v-model="viewOpenModal"
  size="xl"
  :title="(viewItem?.voucher_type || 'Voucher') + ' Details'"
  hide-footer
  centered

>
  <div v-if="isLoading" class="text-center py-5">
    <BSpinner label="Loading..." />
  </div>

  <div v-else class="p-4" >
    <div id="voucherPrint">
    <h5 class="text-center fw-bold mb-1 text-uppercase ">{{ settingsStore.data.app_name  }}</h5>
    <p class="text-center small mb-1">
      {{ settingsStore.data.app_address }}
    </p>
    <h6 class="text-center text-decoration-underline mb-4">{{ viewItem?.voucher_type }}</h6>
    
    <div class="row mb-3">
      <div class="col-md-6">
        <p><strong>VOUCHER NO :</strong> {{ viewItem?.voucher_no }}</p>
        <p><strong>COMPANY/BRANCH :</strong> {{ viewItem?.branch?.name || '-' }}</p>        
      </div>
      <div class="col-md-6 text-end">
        <p><strong>POSTING DATE :</strong> {{ userDateFormat(viewItem?.date) }}</p>
        <p><strong>PRINT DATE :</strong> {{ userDateFormat(new Date()) }}</p>
      </div>
    </div>

    <p><strong>NARRATION :</strong> {{ viewItem?.narration || 'N/A' }}</p>

    <div class="table-responsive mt-3">
      <table class="table table-bordered text-center">
        <thead class="table-light">
          <tr>
            <th class="text-start">HEAD OF ACCOUNTS</th>
            
            <th>DEBIT</th>
            <th>CREDIT</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(line, index) in viewItem?.details" :key="index">
            <td class="text-start">
              ({{ line.account_head?.code }}) {{ line.account_head?.name }} ({{ line.account_head?.type }})
            </td>
            <td>{{ line.debit>0 ?parseFloat(line.debit).toFixed(2):'-' }}</td>
            <td>{{ line.credit >0 ?parseFloat(line.credit).toFixed(2):'-' }}</td>
          </tr>
          <tr>
            <th colspan="1">TOTAL AMOUNT</th>
            <th>{{ viewItem?.debit }}</th>
            <th>{{ viewItem?.debit }}</th>
          </tr>
          <tr>
            <td colspan="3" class="text-start">
              <strong>IN WORD:</strong>  {{ numberToWords(viewItem?.debit) }}
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <div class="row mt-5 text-center">
      <div class="col-4">
        <p>_________________________</p>
        <p class="mb-0 fw-bold">PREPARED BY</p>
      </div>
      <div class="col-4">
        <p>_________________________</p>
        <p class="mb-0 fw-bold">CHECKED BY</p>
      </div>
      <div class="col-4">
        <p>_________________________</p>
        <p class="mb-0 fw-bold">AUTHORIZED</p>
      </div>
    </div>
    </div>

    <div class="text-end mt-4">
      <BButton variant="outline-primary" @click="printADiv('voucherPrint')" class="me-2">
        <i class="fas fa-print"></i>
      </BButton>
      <BButton variant="outline-danger" @click="viewOpenModal = false">
        <i class="fas fa-times"></i>
      </BButton>
    </div>
  </div>
</BModal>

</template>

<style scoped>
.voucher-posting-modal .modal-body {
  overflow: visible !important; /* Make modal body overflow visible */
  max-height: calc(100vh - 150px);
  overflow-y: auto; /* Allow scrolling if content is large */
}

.lines-table {
  overflow: visible !important; /* Important so dropdowns can overflow */
}

.line-row .account-head-cell {
  position: relative; /* Make sure dropdown positions relative to this cell */
}

.resource-select {
  width: 100%;
  /* Ensure dropdowns can overflow parent */
  overflow: visible !important;
  position: relative !important;
  z-index: 1050; /* Should be above modal */
}
.col-form-label{
  padding: 0;
}
.modal-body {
  max-height: 70vh; /* Adjust as needed */
  overflow-y: auto;
}

</style>
