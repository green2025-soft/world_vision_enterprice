<script setup>
import { ref, onMounted, computed } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm } from '@/utilities/methods'

const title = 'Employees'
const bUrl = 'hrm/employees'

const { 
  create, 
  askDelete, 
  confirmDelete, 
  updateWithFile, 
  confirmDeleteModal, 
  formErrors, 
  isSubmitting
} = useResourceApiClient(bUrl, title)

let errors = ref([])
const activeTab = ref('personal')
const isEdit = ref(false)
const showModal = ref(false)

const { form, reset } = useForm({
  // Personal Information
  first_name: '',
  last_name: '',
  father_name: '',
  mother_name: '',
  spouse_name: '',
  slug: '',
  
  // Contact Information
  email: '',
  phone: '',
  present_address: '',
  permanent_address: '',
  city: '',
  state: '',
  country: 'Bangladesh',
  postal_code: '',
  
  // Relations (Foreign Keys)
  department_id: null,
  designation_id: null,
  // branch_id: null, // REMOVED - not needed
  gender_id: null,
  religion_id: null,
  shift_id: null,
  employee_category_id: null,
  employee_type_id: null,
  employee_status_id: null,
  blood_group_id: null,
  
  // Personal Details
  nationality: 'Bangladeshi',
  marital_status: null,
  date_of_birth: null,
  joining_date: null,
  confirmation_date: null,
  termination_date: null,
  
  // Employment Details
  probation_period: '',
  tin_no: '',
  national_id: '',
  passport_number: '',
  passport_expiry_date: null,
  
  // Other
  profile_picture: null,
  profile_picture_preview: null,
  remarks: '',
  status: 1,
})

const dataTableRef = ref(null)

// Stats data
const stats = ref({
  total: 0,
  active: 0,
  probation: 0,
  departments: 0
})

// Tabs configuration
const tabs = [
  { id: 'personal', label: 'Personal Info', icon: 'fas fa-user' },
  { id: 'contact', label: 'Contact', icon: 'fas fa-address-book' },
  { id: 'employment', label: 'Employment', icon: 'fas fa-briefcase' },
  { id: 'additional', label: 'Additional', icon: 'fas fa-id-card' },
  { id: 'profile', label: 'Profile', icon: 'fas fa-image' }
]

// Format date for input (removes time part)
const formatDateForInput = (date) => {
  if (!date) return null
  const d = new Date(date)
  if (isNaN(d.getTime())) return null
  return d.toISOString().split('T')[0]
}

// Format date for display
const formatDateForDisplay = (date) => {
  if (!date) return '-'
  const d = new Date(date)
  if (isNaN(d.getTime())) return '-'
  return d.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'short',
    day: 'numeric'
  })
}

// Handle file upload
const handleFileUpload = (event) => {
  const file = event.target.files[0]
  if (file) {
    if (file.size > 2 * 1024 * 1024) {
      // Show error toast
      return
    }
    form.value.profile_picture = file
    const reader = new FileReader()
    reader.onload = (e) => {
      form.value.profile_picture_preview = e.target.result
    }
    reader.readAsDataURL(file)
  }
}

// Remove profile picture
const removeProfilePicture = () => {
  form.value.profile_picture = null
  form.value.profile_picture_preview = null
  const fileInput = document.getElementById('profile_picture_input')
  if (fileInput) fileInput.value = ''
}

async function saveItem() {
  try {
    const formData = new FormData()
    
    Object.keys(form.value).forEach(key => {
      if (key === 'profile_picture') {
        if (form.value[key] instanceof File) {
          formData.append(key, form.value[key])
        }
      } else if (key === 'profile_picture_preview') {
        return
      } else if (form.value[key] !== null && form.value[key] !== undefined && form.value[key] !== '') {
        formData.append(key, form.value[key])
      }
    })
    
    if (form.value.id) {
      formData.append('_method', 'PUT')
      await updateWithFile(form.value.id, formData)
    } else {
      await create(formData, '', true)
    }
    
    await dataTableRef.value?.refresh()
    showModal.value = false
    reset()
    form.value.profile_picture_preview = null
    // Refresh stats after save
    await fetchStats()
    
  } catch (error) {
    errors.value = formErrors.value
    console.error('Error saving:', error)
  }
}

function openModal(item = null) {
  errors.value = []
  reset()
  form.value.profile_picture_preview = null
  isEdit.value = false
  activeTab.value = 'personal'

  if (item) {
    const dateFields = ['date_of_birth', 'joining_date', 'confirmation_date', 'termination_date', 'passport_expiry_date']
    const formattedItem = { ...item }
    
    dateFields.forEach(field => {
      if (formattedItem[field]) {
        formattedItem[field] = formatDateForInput(formattedItem[field])
      }
    })
    
    if (formattedItem.profile_picture) {
      formattedItem.profile_picture_preview = formattedItem.profile_picture
    }
    
    Object.assign(form.value, formattedItem)
    isEdit.value = true
  }

  showModal.value = true
}

const maritalStatusOptions = [
  { value: null, text: 'Select Marital Status' },
  { value: 'Married', text: 'Married' },
  { value: 'Unmarried', text: 'Unmarried' },
  { value: 'Divorced', text: 'Divorced' },
  { value: 'Widowed', text: 'Widowed' }
]

// Computed property for full name display
const fullName = computed(() => {
  return form.value.first_name && form.value.last_name 
    ? `${form.value.first_name} ${form.value.last_name}` 
    : 'No Name'
})

// Get field error
const getFieldError = (field) => {
  return errors.value && errors.value[field] ? errors.value[field][0] : ''
}

const hasError = (field) => {
  return errors.value && errors.value[field]
}

// Switch tab
const switchTab = (tabId) => {
  activeTab.value = tabId
}

// Fetch stats - Calculate from DataTable data
const fetchStats = async () => {
  try {
    // Try to get data from DataTable
    let items = []
    
    if (dataTableRef.value) {
      // Check different ways DataTable might expose its data
      if (dataTableRef.value.items) {
        items = dataTableRef.value.items
      } else if (dataTableRef.value.data) {
        items = dataTableRef.value.data
      } else if (dataTableRef.value.tableData) {
        items = dataTableRef.value.tableData
      } else if (dataTableRef.value.getData) {
        items = await dataTableRef.value.getData()
      } else if (dataTableRef.value.getItems) {
        items = await dataTableRef.value.getItems()
      }
    }
    
    // If we have items, calculate stats
    if (items && items.length > 0) {
      const active = items.filter(item => item.status === 1).length
      
      // Calculate probation - adjust based on your logic
      const probation = items.filter(item => {
        // Check if employee_status_id is for probation
        if (item.employee_status_id === 2) return true
        // Or if probation_period > 0
        if (item.probation_period && parseInt(item.probation_period) > 0) return true
        return false
      }).length
      
      // Calculate unique departments
      const departments = new Set(
        items.map(item => item.department_id)
          .filter(id => id !== null && id !== undefined && id !== '')
      ).size
      
      stats.value = {
        total: items.length,
        active: active,
        probation: probation,
        departments: departments
      }
    } else {
      stats.value = {
        total: 0,
        active: 0,
        probation: 0,
        departments: 0
      }
    }
  } catch (error) {
    console.error('Error fetching stats:', error)
    stats.value = {
      total: 0,
      active: 0,
      probation: 0,
      departments: 0
    }
  }
}

// Refresh stats when data table changes
const onDataTableUpdate = () => {
  fetchStats()
}

// Refresh data
const refreshData = async () => {
  if (dataTableRef.value) {
    await dataTableRef.value.refresh?.()
    await fetchStats()
  }
}

onMounted(() => {
  fetchStats()
})
</script>

<template>
  <ConfirmDelete ref="confirmDeleteModal" @confirm="() => confirmDelete(() => dataTableRef?.refresh())" />
  
  <div class="container-fluid p-4">
    <div class="row">
      <div class="col-12">
        <!-- Header with Stats -->
        <div class="d-flex justify-content-between align-items-center mb-4">
          <div>
            <h2 class="fw-bold text-primary">
              <i class="fas fa-users me-2"></i> {{ title }}
              <span class="badge bg-primary ms-2">HRM</span>
            </h2>
            <p class="text-muted mb-0">Manage employee information and records</p>
          </div>
          <div>
            <BButton 
              variant="primary" 
              size="lg" 
              class="shadow-sm rounded-pill px-4"
              @click="openModal()"
            >
              <i class="fas fa-plus-circle me-2"></i> Add New Employee
            </BButton>
          </div>
        </div>

        <!-- Stats Cards -->
        <div class="row g-3 mb-4">
          <div class="col-md-3">
            <div class="card border-0 shadow-sm bg-gradient-primary text-white h-100">
              <div class="card-body d-flex justify-content-between align-items-center p-3">
                <div>
                  <h6 class="text-white-50 mb-1">Total Employees</h6>
                  <h3 class="mb-0 fw-bold">{{ stats.total || 0 }}</h3>
                </div>
                <div class="bg-white bg-opacity-25 rounded-circle p-3">
                  <i class="fas fa-users fa-2x"></i>
                </div>
              </div>
            </div>
          </div>
          <div class="col-md-3">
            <div class="card border-0 shadow-sm bg-gradient-success text-white h-100">
              <div class="card-body d-flex justify-content-between align-items-center p-3">
                <div>
                  <h6 class="text-white-50 mb-1">Active</h6>
                  <h3 class="mb-0 fw-bold">{{ stats.active || 0 }}</h3>
                </div>
                <div class="bg-white bg-opacity-25 rounded-circle p-3">
                  <i class="fas fa-user-check fa-2x"></i>
                </div>
              </div>
            </div>
          </div>
          <div class="col-md-3">
            <div class="card border-0 shadow-sm bg-gradient-warning text-white h-100">
              <div class="card-body d-flex justify-content-between align-items-center p-3">
                <div>
                  <h6 class="text-white-50 mb-1">On Probation</h6>
                  <h3 class="mb-0 fw-bold">{{ stats.probation || 0 }}</h3>
                </div>
                <div class="bg-white bg-opacity-25 rounded-circle p-3">
                  <i class="fas fa-clock fa-2x"></i>
                </div>
              </div>
            </div>
          </div>
          <div class="col-md-3">
            <div class="card border-0 shadow-sm bg-gradient-danger text-white h-100">
              <div class="card-body d-flex justify-content-between align-items-center p-3">
                <div>
                  <h6 class="text-white-50 mb-1">Departments</h6>
                  <h3 class="mb-0 fw-bold">{{ stats.departments || 0 }}</h3>
                </div>
                <div class="bg-white bg-opacity-25 rounded-circle p-3">
                  <i class="fas fa-building fa-2x"></i>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Data Table Card -->
        <div class="card border-0 shadow-lg">
          <div class="card-header bg-transparent d-flex justify-content-between align-items-center py-3">
            <div>
              <i class="fas fa-list text-primary me-2"></i>
              <span class="fw-bold">Employee List</span>
            </div>
            <div class="d-flex gap-2">
              <BButton variant="outline-secondary" size="sm" @click="refreshData">
                <i class="fas fa-sync-alt"></i> Refresh
              </BButton>
            </div>
          </div>
          <div class="card-body p-0">
            <DataTable 
              ref="dataTableRef" 
              :fields="[
                { key: 'sl', label: '#', align: 'center' },
                { key: 'employee_id', label: 'Employee ID' },
                { key: 'full_name', label: 'Full Name' },
                { key: 'email', label: 'Email' },
                { key: 'phone', label: 'Phone' },
                { key: 'department', label: 'Department' },
                { key: 'designation', label: 'Designation' },
                { key: 'status', label: 'Status', isChange: true, align: 'center' },
                { key: 'actions', label: 'Actions', align: 'center' }
              ]"
              :bUrl="bUrl"
              class="table-hover"
              @update="onDataTableUpdate"
            >
              <template #cell-full_name="{ item }">
                <div class="d-flex align-items-center">
                  <img 
                    :src="item.profile_picture || '/images/default-avatar.png'" 
                    class="rounded-circle me-2" 
                    style="width: 32px; height: 32px; object-fit: cover;"
                  />
                  <div>
                    <strong>{{ item.full_name || item.first_name + ' ' + item.last_name }}</strong>
                    <br/>
                    <small class="text-muted">{{ item.email || 'No Email' }}</small>
                  </div>
                </div>
              </template>
              <template #cell-department="{ item }">
                <span class="badge bg-info">{{ item.department?.name || '-' }}</span>
              </template>
              <template #cell-designation="{ item }">
                <span class="badge bg-secondary">{{ item.designation?.name || '-' }}</span>
              </template>
              <template #cell-status="{ item }">
                <!-- <StatusDisplay :value="item.status" /> -->
                <span class="badge bg-success">{{ item.employee_status?.name || '-' }}</span>
            </template>
              <template #actions="{ rowItem }">
                <div class="btn-group">
                  <BButton 
                    variant="outline-primary" 
                    size="sm" 
                    class="rounded-end-0"
                    @click="openModal(rowItem)"
                    title="Edit"
                  >
                    <i class="fa fa-edit"></i>
                  </BButton>
                  <BButton 
                    variant="outline-danger" 
                    size="sm" 
                    class="rounded-start-0"
                    @click="askDelete(rowItem.id)"
                    title="Delete"
                  >
                    <i class="fa fa-trash"></i>
                  </BButton>
                </div>
              </template>
            </DataTable>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Modal -->
  <FormModal
    v-model="showModal"
    :title="form.id ? `✏️ Edit ${title}` : `➕ Add ${title}`"
    :loading="isSubmitting"
    size="xl"
    @submit="saveItem"
    class="employee-modal"
  >
    <template #default>
      <!-- Header with Avatar -->
      <div class="text-center mb-4">
        <div class="position-relative d-inline-block">
          <div class="avatar-upload">
            <div 
              class="avatar-preview rounded-circle border border-4 border-primary"
              :style="{ 
                backgroundImage: form.profile_picture_preview 
                  ? `url(${form.profile_picture_preview})` 
                  : 'url(/images/default-avatar.png)',
                backgroundSize: 'cover',
                backgroundPosition: 'center',
                width: '80px',
                height: '80px',
                margin: '0 auto'
              }"
            >
              <label for="avatar-upload-input" class="avatar-upload-label">
                <i class="fas fa-camera"></i>
              </label>
            </div>
            <input 
              id="avatar-upload-input"
              type="file"
              accept="image/*"
              class="d-none"
              @change="handleFileUpload"
            />
          </div>
          <h4 class="mt-2 mb-0 fw-bold">{{ fullName }}</h4>
          <small class="text-muted">Employee Profile</small>
        </div>
      </div>

      <ValidationErrors :errors="errors" class="mb-3" />

      <!-- Tabs -->
      <div class="card border-0 shadow-sm">
        <div class="card-header bg-transparent p-0">
          <ul class="nav nav-pills nav-fill" style="flex-wrap: wrap;">
            <li class="nav-item" v-for="tab in tabs" :key="tab.id">
              <button 
                class="nav-link rounded-0 px-4 py-3 fw-bold"
                :class="activeTab === tab.id ? 'active bg-primary' : ''"
                @click="switchTab(tab.id)"
                style="border: none; background: transparent; width: 100%;"
              >
                <i :class="tab.icon + ' me-2'"></i> {{ tab.label }}
              </button>
            </li>
          </ul>
        </div>
        <div class="card-body p-4">
          <!-- PERSONAL INFORMATION TAB -->
          <div v-if="activeTab === 'personal'">
            <h6 class="text-primary mb-3"><i class="fas fa-user-circle me-2"></i> Personal Details</h6>
            <div class="row">
              <div class="col-md-6">
                <div class="mb-3">
                  <label class="form-label fw-bold">Employee ID</label>
                  <input 
                    v-model="form.employee_id" 
                    type="text" 
                    class="form-control rounded-3 bg-light"
                    disabled
                  />
                </div>
              </div>
              <div class="col-md-6">
                <div class="mb-3">
                  <label class="form-label fw-bold">Slug</label>
                  <input 
                    v-model="form.slug" 
                    type="text" 
                    class="form-control rounded-3 bg-light"
                    disabled
                  />
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-6">
                <div class="mb-3">
                  <label class="form-label fw-bold">First Name <span class="text-danger">*</span></label>
                  <input 
                    v-model="form.first_name" 
                    type="text" 
                    class="form-control rounded-3"
                    :class="{ 'is-invalid': hasError('first_name') }"
                    placeholder="Enter first name"
                  />
                  <div v-if="hasError('first_name')" class="invalid-feedback">
                    {{ getFieldError('first_name') }}
                  </div>
                </div>
              </div>
              <div class="col-md-6">
                <div class="mb-3">
                  <label class="form-label fw-bold">Last Name <span class="text-danger">*</span></label>
                  <input 
                    v-model="form.last_name" 
                    type="text" 
                    class="form-control rounded-3"
                    :class="{ 'is-invalid': hasError('last_name') }"
                    placeholder="Enter last name"
                  />
                  <div v-if="hasError('last_name')" class="invalid-feedback">
                    {{ getFieldError('last_name') }}
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-6">
                <div class="mb-3">
                  <label class="form-label fw-bold">Father's Name</label>
                  <input v-model="form.father_name" type="text" class="form-control rounded-3" placeholder="Enter father's name" />
                </div>
              </div>
              <div class="col-md-6">
                <div class="mb-3">
                  <label class="form-label fw-bold">Mother's Name</label>
                  <input v-model="form.mother_name" type="text" class="form-control rounded-3" placeholder="Enter mother's name" />
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-6">
                <div class="mb-3">
                  <label class="form-label fw-bold">Spouse's Name</label>
                  <input v-model="form.spouse_name" type="text" class="form-control rounded-3" placeholder="Enter spouse's name" />
                </div>
              </div>
              <div class="col-md-6">
                <div class="mb-3">
                  <label class="form-label fw-bold">Marital Status</label>
                  <select v-model="form.marital_status" class="form-select rounded-3">
                    <option v-for="opt in maritalStatusOptions" :key="opt.value" :value="opt.value">
                      {{ opt.text }}
                    </option>
                  </select>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-6">
                <div class="mb-3">
                  <label class="form-label fw-bold">Date of Birth</label>
                  <DatePicker v-model="form.date_of_birth"  />
                </div>
              </div>
              <div class="col-md-6">
                <div class="mb-3">
                  <label class="form-label fw-bold">Nationality</label>
                  <input v-model="form.nationality" type="text" class="form-control rounded-3" placeholder="Nationality" />
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-4">
                <div class="mb-3">
                  <label class="form-label fw-bold">Gender</label>
                  <ResourceSelect
                    v-model="form.gender_id"
                    bUrl="hrm/genders"
                    placeholder="Select Gender"
                    :isBranch="false"
                    :isEdit="isEdit"
                    :positional="true"
                  />
                </div>
              </div>
              <div class="col-md-4">
                <div class="mb-3">
                  <label class="form-label fw-bold">Religion</label>
                  <ResourceSelect
                    v-model="form.religion_id"
                    bUrl="hrm/religions"
                    placeholder="Select Religion"
                    :isBranch="false"
                    :isEdit="isEdit"
                    :positional="true"
                  />
                </div>
              </div>
              <div class="col-md-4">
                <div class="mb-3">
                  <label class="form-label fw-bold">Blood Group</label>
                  <ResourceSelect
                    v-model="form.blood_group_id"
                    bUrl="hrm/blood-group"
                    placeholder="Select Blood Group"
                    :isBranch="false"
                    :isEdit="isEdit"
                    :positional="true"
                  />
                </div>
              </div>
            </div>
          </div>

          <!-- CONTACT INFORMATION TAB -->
          <div v-if="activeTab === 'contact'">
            <h6 class="text-primary mb-3"><i class="fas fa-address-card me-2"></i> Contact Details</h6>
            <div class="row">
              <div class="col-md-6">
                <div class="mb-3">
                  <label class="form-label fw-bold">Email</label>
                  <input 
                    v-model="form.email" 
                    type="email" 
                    class="form-control rounded-3"
                    :class="{ 'is-invalid': hasError('email') }"
                    placeholder="Enter email"
                  />
                  <div v-if="hasError('email')" class="invalid-feedback">
                    {{ getFieldError('email') }}
                  </div>
                </div>
              </div>
              <div class="col-md-6">
                <div class="mb-3">
                  <label class="form-label fw-bold">Phone</label>
                  <input 
                    v-model="form.phone" 
                    type="text" 
                    class="form-control rounded-3"
                    :class="{ 'is-invalid': hasError('phone') }"
                    placeholder="Enter phone number"
                  />
                  <div v-if="hasError('phone')" class="invalid-feedback">
                    {{ getFieldError('phone') }}
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-6">
                <div class="mb-3">
                  <label class="form-label fw-bold">Present Address</label>
                  <textarea v-model="form.present_address" class="form-control rounded-3" rows="3" placeholder="Enter present address"></textarea>
                </div>
              </div>
              <div class="col-md-6">
                <div class="mb-3">
                  <label class="form-label fw-bold">Permanent Address</label>
                  <textarea v-model="form.permanent_address" class="form-control rounded-3" rows="3" placeholder="Enter permanent address"></textarea>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-3">
                <div class="mb-3">
                  <label class="form-label fw-bold">City</label>
                  <input v-model="form.city" type="text" class="form-control rounded-3" placeholder="City" />
                </div>
              </div>
              <div class="col-md-3">
                <div class="mb-3">
                  <label class="form-label fw-bold">State</label>
                  <input v-model="form.state" type="text" class="form-control rounded-3" placeholder="State" />
                </div>
              </div>
              <div class="col-md-3">
                <div class="mb-3">
                  <label class="form-label fw-bold">Country</label>
                  <input v-model="form.country" type="text" class="form-control rounded-3" placeholder="Country" />
                </div>
              </div>
              <div class="col-md-3">
                <div class="mb-3">
                  <label class="form-label fw-bold">Postal Code</label>
                  <input v-model="form.postal_code" type="text" class="form-control rounded-3" placeholder="Postal code" />
                </div>
              </div>
            </div>
          </div>

          <!-- EMPLOYMENT DETAILS TAB -->
          <div v-if="activeTab === 'employment'">
            <h6 class="text-primary mb-3"><i class="fas fa-building me-2"></i> Employment Details</h6>
            <div class="row">
              <div class="col-md-4">
                <div class="mb-3">
                  <label class="form-label fw-bold">Department</label>
                  <ResourceSelect
                    v-model="form.department_id"
                    bUrl="hrm/departments"
                    placeholder="Select Department"
                    :isBranch="true"
                    :isEdit="isEdit"
                    :positional="true"
                  />
                </div>
              </div>
              <div class="col-md-4">
                <div class="mb-3">
                  <label class="form-label fw-bold">Designation</label>
                  <ResourceSelect
                    v-model="form.designation_id"
                    bUrl="hrm/designations"
                    placeholder="Select Designation"
                    :isBranch="true"
                    :isEdit="isEdit"
                    :positional="true"
                  />
                </div>
              </div>
              <!-- Branch removed -->
              <div class="col-md-4">
                <div class="mb-3">
                  <label class="form-label fw-bold">Employee Category</label>
                  <ResourceSelect
                    v-model="form.employee_category_id"
                    bUrl="hrm/employee-categories"
                    placeholder="Select Category"
                    :isBranch="false"
                    :isEdit="isEdit"
                    :positional="true"
                  />
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-4">
                <div class="mb-3">
                  <label class="form-label fw-bold">Employee Type</label>
                  <ResourceSelect
                    v-model="form.employee_type_id"
                    bUrl="hrm/employee-types"
                    placeholder="Select Type"
                    :isBranch="false"
                    :isEdit="isEdit"
                    :positional="true"
                  />
                </div>
              </div>
              <div class="col-md-4">
                <div class="mb-3">
                  <label class="form-label fw-bold">Employee Status</label>
                  <ResourceSelect
                    v-model="form.employee_status_id"
                    bUrl="hrm/employee-status"
                    placeholder="Select Status"
                    :isBranch="false"
                    :isEdit="isEdit"
                    :positional="true"
                  />
                </div>
              </div>
              <div class="col-md-4">
                <div class="mb-3">
                  <label class="form-label fw-bold">Shift</label>
                  <ResourceSelect
                    v-model="form.shift_id"
                    bUrl="hrm/shifts"
                    placeholder="Select Shift"
                    :isBranch="false"
                    :isEdit="isEdit"
                    :positional="true"
                  />
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-4">
                <div class="mb-3">
                  <label class="form-label fw-bold">Joining Date</label>
                  <DatePicker v-model="form.joining_date"  />
                </div>
              </div>
              <div class="col-md-4">
                <div class="mb-3">
                  <label class="form-label fw-bold">Confirmation Date</label>
                  <DatePicker v-model="form.confirmation_date"  />
                  
                </div>
              </div>
              <div class="col-md-4">
                <div class="mb-3">
                  <label class="form-label fw-bold">Probation Period (Months)</label>
                  <input v-model="form.probation_period" type="number" class="form-control rounded-3" placeholder="e.g., 6" />
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-4">
                <div class="mb-3">
                  <label class="form-label fw-bold">Termination Date</label>
                  <DatePicker v-model="form.termination_date"  />
                </div>
              </div>
            </div>
          </div>

          <!-- ADDITIONAL INFORMATION TAB -->
          <div v-if="activeTab === 'additional'">
            <h6 class="text-primary mb-3"><i class="fas fa-id-card me-2"></i> Additional Information</h6>
            <div class="row">
              <div class="col-md-6">
                <div class="mb-3">
                  <label class="form-label fw-bold">National ID</label>
                  <input 
                    v-model="form.national_id" 
                    type="text" 
                    class="form-control rounded-3"
                    :class="{ 'is-invalid': hasError('national_id') }"
                    placeholder="Enter NID"
                  />
                  <div v-if="hasError('national_id')" class="invalid-feedback">
                    {{ getFieldError('national_id') }}
                  </div>
                </div>
              </div>
              <div class="col-md-6">
                <div class="mb-3">
                  <label class="form-label fw-bold">TIN</label>
                  <input v-model="form.tin_no" type="text" class="form-control rounded-3" placeholder="Enter TIN" />
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-6">
                <div class="mb-3">
                  <label class="form-label fw-bold">Passport Number</label>
                  <input 
                    v-model="form.passport_number" 
                    type="text" 
                    class="form-control rounded-3"
                    :class="{ 'is-invalid': hasError('passport_number') }"
                    placeholder="Enter passport number"
                  />
                  <div v-if="hasError('passport_number')" class="invalid-feedback">
                    {{ getFieldError('passport_number') }}
                  </div>
                </div>
              </div>
              <div class="col-md-6">
                <div class="mb-3">
                  <label class="form-label fw-bold">Passport Expiry Date</label>
                  <DatePicker v-model="form.passport_expiry_date"  />
                </div>
              </div>
            </div>
          </div>

          <!-- PROFILE & REMARKS TAB -->
          <div v-if="activeTab === 'profile'">
            <h6 class="text-primary mb-3"><i class="fas fa-image me-2"></i> Profile & Remarks</h6>
            <div class="row">
              <div class="col-md-12">
                <div class="mb-3">
                  <label class="form-label fw-bold">Profile Picture</label>
                  <div class="border rounded-3 p-4 text-center bg-light">
                    <div v-if="form.profile_picture_preview" class="mb-3">
                      <img 
                        :src="form.profile_picture_preview" 
                        alt="Profile Preview" 
                        class="rounded-circle"
                        style="width: 150px; height: 150px; object-fit: cover; border: 4px solid #fff; box-shadow: 0 0 20px rgba(0,0,0,0.1);"
                      />
                      <div class="mt-2">
                        <button class="btn btn-danger btn-sm rounded-pill" @click="removeProfilePicture">
                          <i class="fas fa-times me-1"></i> Remove
                        </button>
                      </div>
                    </div>
                    <div v-else>
                      <div class="d-flex flex-column align-items-center">
                        <div class="bg-primary bg-opacity-10 rounded-circle p-4 mb-2">
                          <i class="fas fa-camera fa-3x text-primary"></i>
                        </div>
                        <p class="text-muted mb-2">Click below to upload profile picture</p>
                        <button class="btn btn-outline-primary rounded-pill" @click="$refs.fileInput.click()">
                          <i class="fas fa-upload me-1"></i> Choose Image
                        </button>
                      </div>
                    </div>
                    <input
                      ref="fileInput"
                      type="file"
                      accept="image/*"
                      class="d-none"
                      @change="handleFileUpload"
                    />
                    <small class="text-muted d-block mt-2">Supported formats: JPG, PNG, GIF (Max 2MB)</small>
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-12">
                <div class="mb-3">
                  <label class="form-label fw-bold">Remarks</label>
                  <textarea v-model="form.remarks" class="form-control rounded-3" rows="4" placeholder="Enter any remarks about the employee..."></textarea>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </template>
  </FormModal>
</template>

<style scoped>
/* Gradients */
.bg-gradient-primary {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.bg-gradient-success {
  background: linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%);
}

.bg-gradient-warning {
  background: linear-gradient(135deg, #f6d365 0%, #fda085 100%);
}

.bg-gradient-danger {
  background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
}

/* Avatar Upload */
.avatar-upload {
  position: relative;
}

.avatar-preview {
  transition: all 0.3s ease;
  cursor: pointer;
}

.avatar-upload-label {
  position: absolute;
  bottom: 0;
  right: 0;
  background: #007bff;
  color: white;
  border-radius: 50%;
  padding: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.avatar-upload-label:hover {
  transform: scale(1.1);
  background: #0056b3;
}

/* Tabs */
.nav-pills .nav-link {
  border-radius: 0;
  color: #6c757d;
  transition: all 0.3s ease;
  border-bottom: 3px solid transparent;
}

.nav-pills .nav-link:hover {
  background: #f8f9fa;
  color: #495057;
}

.nav-pills .nav-link.active {
  background: #007bff !important;
  color: white !important;
  box-shadow: 0 4px 15px rgba(0, 123, 255, 0.4);
  border-bottom: 3px solid #0056b3;
}

/* Form Inputs */
.form-control, .form-select {
  border: 1px solid #e0e0e0;
  transition: all 0.3s ease;
}

.form-control:focus, .form-select:focus {
  border-color: #667eea;
  box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
}

.form-control.is-invalid {
  border-color: #dc3545;
}

/* Card Styling */
.card {
  border-radius: 12px;
  overflow: hidden;
}

.card-header {
  background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
  font-weight: 600;
}

/* Stats cards height consistency */
.h-100 {
  height: 100%;
}

/* Responsive */
@media (max-width: 768px) {
  .container-fluid {
    padding: 1rem !important;
  }
  
  .card-header {
    flex-direction: column;
    gap: 10px;
  }
  
  .nav-pills .nav-link {
    font-size: 12px;
    padding: 8px 12px !important;
  }
}
</style>