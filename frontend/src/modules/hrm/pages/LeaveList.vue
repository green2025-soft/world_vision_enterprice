<script setup>
import { ref, computed, watch } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm } from '@/utilities/methods'

const title = 'Leave'
const bUrl = 'hrm/leaves'

const {
  create,
  askDelete,
  confirmDelete,
  updateWithFile,
  confirmDeleteModal,
  formErrors,
  isSubmitting
} = useResourceApiClient(bUrl, title)

const errors = ref([])
const showModal = ref(false)
const dataTableRef = ref(null)

/*
|--------------------------------------------------------------------------
| Form
|--------------------------------------------------------------------------
*/

const { form, reset } = useForm({
  employee_id: '',
  department_id: '',
  designation_id: '',
  leave_category_id: '',

  application_date: '',
  leave_from: '',
  leave_to: '',

  total_leave: '',

  leave_reason: '',
  attachment: null,

  status: 1,
  remarks: '',
})

/*
|--------------------------------------------------------------------------
| Edit Mode
|--------------------------------------------------------------------------
*/

const isEdit = computed(() => {
  return !!form.value.id
})

/*
|--------------------------------------------------------------------------
| Date Helpers
|--------------------------------------------------------------------------
*/

/*
 * Convert YYYY-MM-DD -> DD-MM-YYYY
 */
function formatDate(date) {
  if (!date) {
    return ''
  }

  const parts = date.split('-')

  if (parts.length !== 3) {
    return date
  }

  const [year, month, day] = parts

  return `${day}-${month}-${year}`
}


/*
 * Convert DD-MM-YYYY -> YYYY-MM-DD
 */
function parseDate(date) {
  if (!date) {
    return ''
  }

  const parts = date.split('-')

  if (parts.length !== 3) {
    return ''
  }

  const [day, month, year] = parts

  if (
    day.length !== 2 ||
    month.length !== 2 ||
    year.length !== 4
  ) {
    return ''
  }

  return `${year}-${month}-${day}`
}


/*
|--------------------------------------------------------------------------
| Display Dates
|--------------------------------------------------------------------------
*/

const applicationDateDisplay = computed({
  get() {
    return formatDate(form.value.application_date)
  },

  set(value) {
    form.value.application_date = parseDate(value)
  }
})


const leaveFromDisplay = computed({
  get() {
    return formatDate(form.value.leave_from)
  },

  set(value) {
    form.value.leave_from = parseDate(value)
  }
})


const leaveToDisplay = computed({
  get() {
    return formatDate(form.value.leave_to)
  },

  set(value) {
    form.value.leave_to = parseDate(value)
  }
})


/*
|--------------------------------------------------------------------------
| Calculate Total Leave
|--------------------------------------------------------------------------
*/

function calculateTotalLeave() {
  if (
    !form.value.leave_from ||
    !form.value.leave_to
  ) {
    form.value.total_leave = ''
    return
  }

  const from = new Date(
    `${form.value.leave_from}T00:00:00`
  )

  const to = new Date(
    `${form.value.leave_to}T00:00:00`
  )

  if (
    isNaN(from.getTime()) ||
    isNaN(to.getTime())
  ) {
    form.value.total_leave = ''
    return
  }

  if (to < from) {
    form.value.total_leave = ''
    return
  }

  const difference =
    Math.floor(
      (
        to.getTime() -
        from.getTime()
      ) /
      (1000 * 60 * 60 * 24)
    ) + 1

  form.value.total_leave = difference
}


/*
|--------------------------------------------------------------------------
| Watch Leave Dates
|--------------------------------------------------------------------------
*/

watch(
  [
    () => form.value.leave_from,
    () => form.value.leave_to
  ],
  () => {
    calculateTotalLeave()
  }
)


/*
|--------------------------------------------------------------------------
| Save
|--------------------------------------------------------------------------
*/

async function saveItem() {
  try {

    if (form.value.id) {

      await updateWithFile(
        form.value.id,
        form.value
      )

    } else {

      await create(
        form.value,
        '',
        true
      )

    }

    await dataTableRef.value?.refresh()

    showModal.value = false

    reset()

    errors.value = []

  } catch (error) {

    errors.value = formErrors.value

  }
}


/*
|--------------------------------------------------------------------------
| Open Modal
|--------------------------------------------------------------------------
*/

function openModal(item = null) {

  errors.value = []

  reset()

  if (item) {

    Object.assign(
      form.value,
      item
    )

  }

  showModal.value = true
}


/*
|--------------------------------------------------------------------------
| Close Modal
|--------------------------------------------------------------------------
*/

function closeModal() {

  showModal.value = false

  errors.value = []

  reset()

}
</script>


<template>

  <!-- =========================================================
       DELETE CONFIRMATION
  ========================================================== -->

  <ConfirmDelete
    ref="confirmDeleteModal"
    @confirm="
      () => confirmDelete(
        () => dataTableRef?.refresh()
      )
    "
  />


  <!-- =========================================================
       PAGE
  ========================================================== -->

  <div class="container-fluid">

    <div class="container">

      <div class="card border-info shadow-sm">

        <div
          class="
            card-header
            bg-transparent
            border-info
            d-flex
            justify-content-between
            align-items-center
          "
        >

          <h5 class="card-title mb-0">

            <i class="fas fa-clipboard-list me-2 text-primary"></i>

            {{ title }}

          </h5>


          <BButton
            variant="primary"
            size="sm"
            @click="openModal()"
          >

            <i class="fas fa-plus me-1"></i>

            Add New

          </BButton>

        </div>


        <div class="card-body">

          <DataTable
            ref="dataTableRef"

            :fields="[

              {
                key: 'sl',
                label: 'SL'
              },

              {
                key: 'employee_name',
                label: 'Employee'
              },

              {
                key: 'department_name',
                label: 'Department'
              },

              {
                key: 'designation_name',
                label: 'Designation'
              },

              {
                key: 'leave_from',
                label: 'Leave From'
              },

              {
                key: 'leave_to',
                label: 'Leave To'
              },

              {
                key: 'total_leave',
                label: 'Total',
                align: 'center'
              },

              {
                key: 'leave_reason',
                label: 'Reason'
              },

              {
                key: 'status',
                label: 'Status',
                isChange: true,
                align: 'center'
              },

              {
                key: 'actions',
                label: 'Actions',
                align: 'center'
              }

            ]"

            :bUrl="bUrl"
          >

            <template #cell-employee_name="{ item }">

              <div class="fw-semibold">
                {{ item.employee?.full_name ?? '-' }}
              </div>

            </template>


            <template #cell-department_name="{ item }">

              {{ item.department?.name ?? '-' }}

            </template>


            <template #cell-designation_name="{ item }">

              {{ item.designation?.name ?? '-' }}

            </template>


            <!-- Leave From -->

            <template #cell-leave_from="{ item }">

              {{ formatDate(item.leave_from) || '-' }}

            </template>


            <!-- Leave To -->

            <template #cell-leave_to="{ item }">

              {{ formatDate(item.leave_to) || '-' }}

            </template>


            <!-- Total Leave -->

            <template #cell-total_leave="{ item }">

              <span class="badge text-bg-info">

                {{ item.total_leave ?? '0' }}

                {{ Number(item.total_leave) === 1 ? 'Day' : 'Days' }}

              </span>

            </template>


            <!-- Reason -->

            <template #cell-leave_reason="{ item }">

              <span
                class="text-truncate d-inline-block"
                style="max-width: 180px;"
                :title="item.leave_reason"
              >

                {{ item.leave_reason ?? '-' }}

              </span>

            </template>


            <!-- Status -->

            <template #cell-status="{ item }">

              <StatusDisplay
                :value="item.status"
              />

            </template>


            <!-- Actions -->

            <template #actions="{ rowItem }">

              <div class="btn-group">

                <BButton
                  variant="outline-info"
                  size="sm"
                  title="View"
                  @click="openModal(rowItem)"
                >

                  <i class="fas fa-eye"></i>

                </BButton>


                <BButton
                  variant="outline-primary"
                  size="sm"
                  title="Edit"
                  @click="openModal(rowItem)"
                >

                  <i class="fas fa-edit"></i>

                </BButton>


                <BButton
                  variant="outline-danger"
                  size="sm"
                  title="Delete"
                  @click="askDelete(rowItem.id)"
                >

                  <i class="fas fa-trash"></i>

                </BButton>

              </div>

            </template>

          </DataTable>

        </div>

      </div>

    </div>

  </div>


  <!-- =========================================================
       MODAL
  ========================================================== -->

  <FormModal
    v-model="showModal"
    size="lg"
    :scrollable="true"

    :title="
      isEdit
        ? `Edit ${title}`
        : `Add ${title}`
    "

    :loading="isSubmitting"

    @submit="saveItem"
  >

    <ValidationErrors
      :errors="errors"
      class="mb-3"
    />


    <!-- =======================================================
         EMPLOYEE INFORMATION
    ======================================================== -->

    <div class="card border-0 shadow-sm mb-3">

      <div class="card-header bg-primary-subtle border-0 py-2">

        <div class="d-flex align-items-center">

          <div class="me-2 text-primary">
            <i class="fas fa-user-circle fa-lg"></i>
          </div>

          <div>

            <div class="fw-semibold text-primary">
              Employee Information
            </div>

            <small class="text-muted">
              Employee and organizational details
            </small>

          </div>

        </div>

      </div>


      <div class="card-body p-3">

        <div class="row g-3">

          <div class="col-md-6">

            <BaseFormGroup
              label="Employee"
              labelCols="12"
              required
            >

              <ResourceSelect
                v-model="form.employee_id"
                bUrl="hrm/employees"
                labelField="full_name"
                valueField="id"
                placeholder="Select Employee"
                :isBranch="false"
                :isEdit="isEdit"
                :positional="true"
              />

            </BaseFormGroup>

          </div>


          <div class="col-md-6">

            <BaseFormGroup
              label="Leave Category"
              labelCols="12"
              required
            >

              <ResourceSelect
                v-model="form.leave_category_id"
                bUrl="hrm/leave-categories"
                placeholder="Select Leave Category"
                :isBranch="false"
                :isEdit="isEdit"
                :positional="true"
              />

            </BaseFormGroup>

          </div>


          <div class="col-md-6">

            <BaseFormGroup
              label="Department"
              labelCols="12"
              required
            >

              <ResourceSelect
                v-model="form.department_id"
                bUrl="hrm/departments"
                placeholder="Select Department"
                :isBranch="false"
                :isEdit="isEdit"
                :positional="true"
              />

            </BaseFormGroup>

          </div>


          <div class="col-md-6">

            <BaseFormGroup
              label="Designation"
              labelCols="12"
              required
            >

              <ResourceSelect
                v-model="form.designation_id"
                bUrl="hrm/designations"
                placeholder="Select Designation"
                :isBranch="false"
                :isEdit="isEdit"
                :positional="true"
              />

            </BaseFormGroup>

          </div>

        </div>

      </div>

    </div>


    <!-- =======================================================
         LEAVE PERIOD
    ======================================================== -->

    <div class="card border-0 shadow-sm mb-3">

      <div class="card-header bg-info-subtle border-0 py-2">

        <div class="d-flex align-items-center">

          <div class="me-2 text-info">
            <i class="fas fa-calendar-alt fa-lg"></i>
          </div>

          <div>

            <div class="fw-semibold text-info">
              Leave Period
            </div>

            <small class="text-muted">
              Dates are entered as DD-MM-YYYY
            </small>

          </div>

        </div>

      </div>


      <div class="card-body p-3">

        <div class="row g-3">

          <!-- Application Date -->

          <div class="col-md-4">

            <BaseFormGroup
              label="Application Date"
              labelCols="12"
              required
            >

              <BFormInput
                v-model="applicationDateDisplay"
                type="date"
                placeholder="DD-MM-YYYY"
                maxlength="10"
              />

            </BaseFormGroup>

          </div>


          <!-- Leave From -->

          <div class="col-md-4">

            <BaseFormGroup
              label="Leave From"
              labelCols="12"
              required
            >

              <BFormInput
                v-model="leaveFromDisplay"
                type="date"
                placeholder="DD-MM-YYYY"
                maxlength="10"
              />

            </BaseFormGroup>

          </div>


          <!-- Leave To -->

          <div class="col-md-4">

            <BaseFormGroup
              label="Leave To"
              labelCols="12"
              required
            >

              <BFormInput
                v-model="leaveToDisplay"
                type="date"
                placeholder="DD-MM-YYYY"
                maxlength="10"
              />

            </BaseFormGroup>

          </div>


          <!-- Total Leave -->

          <div class="col-md-4">

            <BaseFormGroup
              label="Total Leave"
              labelCols="12"
              required
            >

              <div class="input-group">

                <span class="input-group-text">

                  <i class="fas fa-calendar-check text-info"></i>

                </span>


                <BFormInput
                  v-model="form.total_leave"
                  type="number"
                  readonly
                  tabindex="-1"
                />


                <span class="input-group-text">

                  {{
                    Number(form.total_leave) === 1
                      ? 'Day'
                      : 'Days'
                  }}

                </span>

              </div>


              <small
                v-if="
                  form.leave_from &&
                  form.leave_to &&
                  !form.total_leave
                "
                class="text-danger"
              >

                Leave To must be the same as or after
                Leave From.

              </small>


              <small
                v-else
                class="text-muted"
              >

                Automatically calculated from the selected dates.

              </small>

            </BaseFormGroup>

          </div>

        </div>

      </div>

    </div>


    <!-- =======================================================
         LEAVE DETAILS
    ======================================================== -->

    <div class="card border-0 shadow-sm mb-3">

      <div class="card-header bg-warning-subtle border-0 py-2">

        <div class="d-flex align-items-center">

          <div class="me-2 text-warning">
            <i class="fas fa-file-alt fa-lg"></i>
          </div>

          <div>

            <div class="fw-semibold text-warning-emphasis">
              Leave Details
            </div>

            <small class="text-muted">
              Reason, attachment and additional remarks
            </small>

          </div>

        </div>

      </div>


      <div class="card-body p-3">

        <div class="row g-3">

          <div class="col-12">

            <BaseFormGroup
              label="Leave Reason"
              labelCols="12"
              required
            >

              <BFormTextarea
                v-model="form.leave_reason"
                rows="3"
                placeholder="Enter the reason for leave..."
              />

            </BaseFormGroup>

          </div>


          <div class="col-md-6">

            <BaseFormGroup
              label="Attachment"
              labelCols="12"
            >

              <div class="input-group">

                <span class="input-group-text">

                  <i class="fas fa-paperclip text-secondary"></i>

                </span>

                <BFormInput
                  type="file"
                  @change="
                    form.attachment =
                      $event.target.files?.[0] ?? null
                  "
                />

              </div>

              <small class="text-muted">
                Upload supporting document if required.
              </small>

            </BaseFormGroup>

          </div>


          <div class="col-md-6">

            <BaseFormGroup
              label="Remarks"
              labelCols="12"
            >

              <BFormTextarea
                v-model="form.remarks"
                rows="3"
                placeholder="Enter additional remarks..."
              />

            </BaseFormGroup>

          </div>

        </div>

      </div>

    </div>


    <!-- =======================================================
         STATUS
    ======================================================== -->

    <div class="card border-0 shadow-sm">

      <div class="card-header bg-secondary-subtle border-0 py-2">

        <div class="d-flex align-items-center">

          <div class="me-2 text-secondary">

            <i class="fas fa-tasks fa-lg"></i>

          </div>

          <div>

            <div class="fw-semibold">
              Application Status
            </div>

            <small class="text-muted">
              Set the current status of this application
            </small>

          </div>

        </div>

      </div>


      <div class="card-body p-3">

        <div class="row">

          <div class="col-md-6">

            <BaseFormGroup
              label="Status"
              labelCols="12"
              required
            >

              <StatusSelect
                v-model="form.status"
              />

            </BaseFormGroup>

          </div>

        </div>

      </div>

    </div>

  </FormModal>

</template>