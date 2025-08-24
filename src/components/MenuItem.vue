<template>
  <table class="table table-bordered">
    <thead>
      <tr>
        <th>Title</th>
        <th>Route</th>
        <th>Permission Route</th>
        <th>Icon</th>
        <th>Module</th>
        <th>Status</th>
        <th class="text-center" style="width: 150px;">Actions</th>
      </tr>
    </thead>

    <!-- Single tbody for everything -->
    <VueDraggable
      tag="tbody"
      :model-value="flatList"
      @update:modelValue="onDragUpdate"
      item-key="id"
    >
      <template v-for="item in flatList" :key="item.id">
        <tr :class="{ 'ps-4': item.level > 0 }">
          <td>
            <span v-if="item.level > 0">&nbsp; ↳ {{ item.title }} </span>
            <strong v-else>{{ item.title }}</strong>
          </td>
          <td>{{ item.route }}</td>
          <td>{{ item.permission_route }}</td>
          <td>{{ item.icon }}</td>
          <td>{{ item.module?.name ?? '' }}</td>
          <td class="text-center">
            <span v-if="item.status == 1" class="badge bg-success">Active</span>
            <span v-else class="badge bg-secondary">Inactive</span>
          </td>
          <td class="text-center">
            <div class="btn-group dropleft">
              <button @click="$emit('edit', item)" class="btn btn-sm btn-warning">Edit</button>
              <button @click="$emit('delete', item.id)" class="btn btn-sm btn-danger">Delete</button>
            </div>
          </td>
        </tr>
      </template>
    </VueDraggable>
  </table>
</template>

<script setup>
import { VueDraggable } from 'vue-draggable-plus'
import { computed } from 'vue'

const props = defineProps({
  modelValue: { type: Array, required: true }
})
const emit = defineEmits(['update:modelValue', 'edit', 'delete', 'reorder'])

// Flatten hierarchy to single list with level info
const flatList = computed(() => {
  const result = []

  const traverse = (nodes, level = 0) => {
    nodes.forEach(node => {
      result.push({ ...node, level })  // keep level for indent
      if (node.children_recursive?.length) {
        traverse(node.children_recursive, level + 1)
      }
    })
  }

  traverse(props.modelValue)
  return result
})

// Drag update handler
const onDragUpdate = (newFlatList) => {
  // Reconstruct nested structure
  const nestedMap = new Map()
  newFlatList.forEach(item => {
    nestedMap.set(item.id, { ...item, children_recursive: [] })
  })

  const newNested = []
  newFlatList.forEach(item => {
    if (item.level === 0) {
      newNested.push(nestedMap.get(item.id))
    } else {
      // find parent: last item with level = current_level-1 before this item
      const parentIndex = newFlatList.slice(0, newFlatList.indexOf(item)).reverse().find(i => i.level === item.level - 1)
      if (parentIndex) {
        nestedMap.get(parentIndex.id).children_recursive.push(nestedMap.get(item.id))
      }
    }
  })

  emit('update:modelValue', newNested)
  emit('reorder', newNested)
}
</script>
