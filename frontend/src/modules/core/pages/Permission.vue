<script setup>
import { ref, onMounted, computed, watch } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'

// Title and API setup
const title = 'Permission'
const bUrl = 'core/permission'
const {
  getList,
  customGet,
  customPost,
  create,
  isLoading
} = useResourceApiClient('core/roles', title)

// States
const roleLists = ref([])
const moduleList = ref([])
const sectionList = ref([])

const selectedRole = ref('')
const selectedModule = ref('')
const selectedSection = ref('')
const permissionsData = ref(null) 

// Fetch roles and modules on mount
onMounted(async () => {
  roleLists.value = await getList()
  moduleList.value = await customGet('core/modules')
})

// Module options
const moduleOptions = computed(() => [
  { value: '', text: 'Select Module' },
  ...moduleList.value.map(m => ({ value: m.id, text: m.name }))
])

// Section options
const sectionOptions = computed(() => [
  { value: '', text: 'Select Section' },
  ...sectionList.value.map(s => ({ value: s.id, text: s.name }))
])

// Watch module change and fetch sections
watch(selectedModule, async (newModuleId) => {
  if (newModuleId) {
    const response = await customGet(`${bUrl}/sections`, { module_id: newModuleId })
    sectionList.value = response || []
  } else {
    sectionList.value = []
  }
  selectedSection.value = '' // reset selected section
})



// New function: POST to get filtered permissions
async function fetchPermissions() {

  const postData = {
    role_id: selectedRole.value,
    module_id: selectedModule.value || '',
    section_id: selectedSection.value || ''
  }
  permissionsData.value= []

  try {
    const response = await customPost(`${bUrl}/permissions`, postData)
    permissionsData.value = response
  

  } catch (error) {
    console.error('Error fetching permissions:', error)
  }
}


function getGroupChecked(group) {
  return computed({
    get() {
      return group.permissions.every(p => p.is_checked)
    },
    set(value) {
      group.permissions.forEach(p => {
        p.is_checked = value
      })
    }
  })
}

function getModuleChecked(module) {
  return computed({
    get() {
      return module.permission_groups.every(g =>
        g.permissions.every(p => p.is_checked)
      )
    },
    set(value) {
      module.permission_groups.forEach(group => {
        group.permissions.forEach(p => {
          p.is_checked = value
        })
      })
    }
  })
}



const selectedPermissionIds = computed(() => {
  const ids = []
  permissionsData.value?.forEach(module => {
    module.permission_groups?.forEach(group => {
      group.permissions?.forEach(permission => {
        if (permission.is_checked) {
          ids.push(permission.id)
        }
      })
    })
  })
  return ids
})


async function savePermissions() {
  const postData = {
    role_id: selectedRole.value,
    permissions: selectedPermissionIds.value
  }
  
  try {
    const response = await customPost(`${bUrl}/assign`, postData, 'Permissions assigned successfully!')

  } catch (error) {
    console.error('Failed to assign permissions:', error)
    alert('Failed to assign permissions.')
  }
}



</script>

<template>
  <div class="container-fluid">
    <div class="card card-outline card-info">
      <div class="card-header">
        <h2 class="card-title"><i class="fas fa-tasks"></i> {{ title }}</h2>
        <div class="card-tools">
          <BButton  class="me-2" size="sm"><i class="fa fa-edit"></i> Section Edit</BButton>
          <BButton variant="primary" size="sm"  class="me-2"><i class="fa fa-edit"></i> Route Edit</BButton>
          <BButton variant="info" size="sm"  class="me-2"><i class="fa fa-plus-circle"></i> Add New</BButton>
        </div>
      </div>

      <div class="card-body" v-if="roleLists.length">
        <b-row class="align-items-center">
          <!-- Role -->
          <BCol cols="1">
            <label for="role">Role <code>*</code></label>
          </BCol>
          <BCol cols="2">
            <BFormSelect
              v-model="selectedRole"
              :options="[
                { value: '', text: 'Select Role' },
                ...roleLists.map(r => ({ value: r.id, text: r.name }))
              ]"
            />
          </BCol>

          <!-- Module -->
          <BCol cols="1">
            <label for="module">Module</label>
          </BCol>
          <BCol cols="2">
            <BFormSelect v-model="selectedModule" :options="moduleOptions" />
          </BCol>

          <!-- Section -->
          <BCol cols="1">
            <label for="section_id">Section</label>
          </BCol>
          <BCol cols="3">
            <BFormSelect v-model="selectedSection" :options="sectionOptions" />
          </BCol>

          <!-- Submit -->
          <BCol cols="2">

                <LoadingButton
                    text="Search"
                    :loading="isLoading"
                    @click="fetchPermissions"
                    />
           
          </BCol>
        </b-row>
      </div>
    </div>
  </div>

  <!-- Permission Table -->
<b-container fluid class="py-4" v-if="permissionsData && permissionsData.data">
  <div class="card card-outline card-info">
    <div class="card-body">
      <div class="table-responsive custom-checkbox">
        <table class="table table-bordered align-middle">
          <thead class="table-light">
            <tr>
              <th width="20%">Module</th>
              <th width="20%">Section</th>
              <th width="60%">Permissions</th>
            </tr>
          </thead>
          <tbody>
            <!-- Loop through modules -->
            <template v-for="(module, moduleIndex) in permissionsData.data" :key="module.id">
              <!-- Row span count based on permission_groups -->
              <template v-for="(group, groupIndex) in module.permission_groups" :key="group.id">
                <tr>
                  <!-- Only show module column in the first group -->
                  <template v-if="groupIndex === 0">
                    <td :rowspan="module.permission_groups.length" class="align-middle">
                      <b-form-checkbox :id="'module_' + module.id" class="fw-bold">
                        {{ module.name }}
                      </b-form-checkbox>
                    </td>
                  </template>

                  <!-- Group name as Section -->
                  <td class="align-middle">
                    <b-form-checkbox :id="'section_' + group.id">
                      {{ group.name }}
                    </b-form-checkbox>
                  </td>

                  <!-- Permissions -->
                  <td>
                    <div class="d-flex flex-wrap gap-3">
                      <b-form-checkbox
                        v-for="permission in group.permissions"
                        :key="permission.id"
                        :id="'permission_' + permission.id"
                      >
                        {{ permission.display_name }}
                      </b-form-checkbox>
                    </div>
                  </td>
                </tr>
              </template>
            </template>
          </tbody>
        </table>
      </div>
    </div>
    <div class="card-footer">
      <b-button variant="primary" class="float-end">Save</b-button>
    </div>
  </div>
</b-container>
<b-container fluid class="py-4" v-if="permissionsData && permissionsData.length">
  <div class="card card-outline card-info">
    <div class="card-body">
    
      <div class="table-responsive custom-checkbox">
        <table class="table table-bordered align-middle">
          <thead class="table-light">
            <tr>
              <th width="12%">Module</th>
              <th width="18%">Section</th>
              <th width="70%">Permissions</th>
            </tr>
          </thead>
          <tbody>
            <!-- Loop through modules -->
            <template v-for="(module, moduleIndex) in permissionsData" :key="module.id">
              <!-- Loop through permission groups -->
              <template v-for="(group, groupIndex) in module.permission_groups" :key="group.id">
                <tr>
                  <!-- Show module name only for first group -->
                  <template v-if="groupIndex === 0">
                    <td :rowspan="module.permission_groups.length" class="align-middle">
                     <b-form-checkbox
                        :id="'module_' + module.id"
                        :model-value="getModuleChecked(module).value"
                        @update:model-value="getModuleChecked(module).value = $event"
                        class="fw-bold"
                      >
                        {{ module.name }}
                      </b-form-checkbox>
                    </td>
                  </template>

                  <!-- Section -->
                  <td class="align-middle">
                    <b-form-checkbox
                      :id="'section_' + group.id"
                      :model-value="getGroupChecked(group).value"
                      @update:model-value="getGroupChecked(group).value = $event"
                    >
                      {{ group.name }}
                    </b-form-checkbox>
                  </td>

                  <!-- Permissions -->
                  <td>
                    <div class="d-flex flex-wrap gap-3">
                      <b-form-checkbox
                        v-for="permission in group.permissions"
                        :key="permission.id"
                        :id="'permission_' + permission.id"
                         v-model="permission.is_checked"
                      >
                        {{ permission.display_name }}
                      </b-form-checkbox>
                    </div>
                  </td>
                </tr>
              </template>
            </template>
          </tbody>
        </table>
      </div>
    </div>
    <div class="card-footer">
      <LoadingButton
                    text="Save"
                    variant="primary"
                    :loading="isLoading"
                    @click="savePermissions"
                    />
      
    </div>
  </div>
</b-container>

</template>
