<template>
  <tr>
    <td :style="{
  paddingLeft: `${depth * 20}px`,
  background: item.parent_id == null ? '#f5f7f9' : '#fff'
}">
      <strong v-if="hasChildren"><template v-if="depth>0">↳</template> <template v-else>&nbsp;</template> {{ item.code }} </strong>
      <span v-else>↳ {{ item.code }}</span>
    </td>

    <td :style="{background: item.parent_id == null ? '#f5f7f9' : '#fff'}">
      <strong v-if="hasChildren">{{ item.name.toUpperCase() }}</strong>
      <span v-else>{{ item.name }}</span>
    </td>

    <td class="text-center" :style="{background: item.parent_id == null ? '#f5f7f9' : '#fff'}">
      <template v-if="item.is_debit">
        ✅ Yes
      </template>
      <template v-else>❌ No</template>
      {{ item.type }}
      
    </td>

    <td class="text-center" :style="{background: item.parent_id == null ? '#f5f7f9' : '#fff'}">
      <StatusDisplay :value="item.status" /> 
    </td>

    <td class="text-center" :style="{background: item.parent_id == null ? '#f5f7f9' : '#fff'}">
      <div class="btn-group dropleft">
        <BButton variant="outline-primary" @click="$emit('edit', item)" v-if="item.parent_id">
          <i class="fa fa-edit"></i>
        </BButton>
        <BButton variant="outline-success" @click="$emit('add-child', item)">
          <i class="fa fa-plus"></i>
        </BButton>
      </div>
    </td>
  </tr>

  <!-- Children rows recursively -->
  <ChartRow
    v-for="child in item.children_recursive"
    :key="child.id"
    :item="child"
    :depth="depth + 1"
    @edit="$emit('edit', $event)"
    @add-child="$emit('add-child', $event)"
  />
</template>

<script setup>
import { computed } from 'vue'
const props = defineProps({
  item: Object,
  depth: {
    type: Number,
    default: 0
  }
})

defineEmits(['edit', 'add-child'])

// ✅ Check if this row has children
const hasChildren = computed(() => {
  return Array.isArray(props.item.children_recursive) && props.item.children_recursive.length > 0 || props.item.parent_id === null
})
</script>
