<script setup>
import { ref, onMounted, computed } from 'vue'
import { useResourceApiClient } from '@/composables/resourceApiClient'
import { useForm } from '@/utilities/methods'
import MenuItem from '@/components/MenuItem.vue'
import { useMenuStore } from '@/store/menu-store'

const title = 'Admin Menu'
const bUrl = 'core/admin-menus'

const {
  getList,
  customGet,
  customPost,
  create,
  update,
  isSubmitting,
  formErrors,
  askDelete,
  confirmDelete,
  confirmDeleteModal
} = useResourceApiClient(bUrl, title)

let allData = ref([])
let parentLists = ref([])
let modulesLists = ref([])
const selectedModuleId = ref(null)

onMounted(async () => {
  allData.value = await getList()
  parentLists.value = await customGet(`${bUrl}/parent`)
  modulesLists.value = await customGet(`core/modules`)
  if (modulesLists.value.length > 0) {
    selectedModuleId.value = modulesLists.value[0].id
  }
})

const filteredMenuList = computed(() => {
  if (!selectedModuleId.value) return []
  return allData.value.filter(menu => menu.module_id === selectedModuleId.value)
})

const filteredParentList = computed(() => {
  return parentLists.value.filter(item => item.module_id === selectedModuleId.value)
})

const showModal = ref(false)
let errors = ref([])

const { form, reset } = useForm({
  id: '',
  title: '',
  module_id: '',
  route: '',
  icon: '',
  parent_id: '',
  permission_route: '',
  status: 1
})

async function saveItem() {
  try {
    form.value.module_id = selectedModuleId.value

    if (form.value.id) {
      await update(form.value.id, form.value)
    } else {
      await create(form.value)
    }

    allData.value = await getList()
    parentLists.value = await customGet(`${bUrl}/parent`)

    const menuStore = useMenuStore()
    menuStore.resetMenu()
    await menuStore.fetchUserMenus()

    reset()
    delete form.value.id
    showModal.value = false
  } catch (error) {
    errors.value = formErrors.value
  }
}

function handleEdit(item) {
  form.value = { ...item }
  selectedModuleId.value = item.module_id
  errors.value = []
  showModal.value = true
}

function handleDelete(id) {
  askDelete(id)
}

function flattenMenu(menuItems, parentId = null, result = [], level = 0) {
  menuItems.forEach((item, index) => {
    result.push({
      id: item.id,
      parent_id: parentId,
      sequence: index + 1
    })

    const children = item.children_recursive || item.children || []
    if (children.length > 0) {
      flattenMenu(children, item.id, result, level + 1)
    }
  })
  return result
}

async function saveNewOrder(newOrder) {
  const flatMenus = flattenMenu(newOrder)
  try {
    await customPost(`${bUrl}/reorder`, { menus: flatMenus }, 'Menu reordered successfully')
    allData.value = await getList()
  } catch (error) {
    console.error(error)
  }
}

function openModal(item = null) {
  errors.value = []
  if (item) {
    Object.assign(form.value, item)
  } else {
    reset()
  }
  showModal.value = true
}
</script>


<template>
  <ConfirmDelete
    ref="confirmDeleteModal"
    @confirm="() => confirmDelete(() => getList().then(data => (allData.value = data)))"
  />

  <div class="card card-outline card-info">
    <div class="card-header">
      <h2 class="card-title"><i class="fas fa-tasks"></i> {{ title }}</h2>
      <div class="card-tools">
        <BButton variant="primary" size="sm" @click="openModal">
          <i class="fas fa-plus"></i> Add New
        </BButton>
      </div>
    </div>

    <!-- Module Tabs -->
    <div class="p-2 border-bottom bg-light">
      <BNav tabs>
        <BNavItem
          v-for="module in modulesLists"
          :key="module.id"
          :active="selectedModuleId === module.id"
          @click="selectedModuleId = module.id"
          href="#"
        >
          {{ module.name }}
        </BNavItem>
      </BNav>
    </div>

    <!-- Menu List -->
    <div class="card-body" v-if="filteredMenuList.length">
      <MenuItem
        v-model="filteredMenuList"
        @edit="handleEdit"
        @delete="handleDelete"
        @reorder="saveNewOrder"
      />
    </div>

    <div v-else class="text-center text-muted py-4">
      No menu items for this module.
    </div>
  </div>

  <!-- Modal -->
  <FormModal
    v-model="showModal"
    :title="form.id ? `Edit ${title}` : `Add ${title}`"
    :loading="isSubmitting"
    @submit="saveItem"
    size="lg"
  >
    <ValidationErrors :errors="errors" />

    <BaseFormGroup label="Title" labelCols="3" required>
      <BFormInput v-model="form.title" />
    </BaseFormGroup>

    <!-- Removed Module Select -->

    <BaseFormGroup label="Route" labelCols="3" required>
      <BFormInput v-model="form.route" />
    </BaseFormGroup>

    <BaseFormGroup label="Icon" labelCols="3">
      <BFormInput v-model="form.icon" />
    </BaseFormGroup>

    <BaseFormGroup label="Parent Menu" labelCols="3">
      <BFormSelect
        v-model="form.parent_id"
        :options="[
          { value: '', text: 'Select Parent' },
          ...filteredParentList.map(r => ({ value: r.id, text: r.title }))
        ]"
      />
    </BaseFormGroup>

    <BaseFormGroup label="Permission Route" labelCols="3">
      <BFormInput v-model="form.permission_route" />
    </BaseFormGroup>

    <BaseFormGroup label="Status" labelCols="3">
      <BFormCheckbox v-model="form.status" :value="1" :unchecked-value="0" switch>
        Active
      </BFormCheckbox>
    </BaseFormGroup>
  </FormModal>
</template>
