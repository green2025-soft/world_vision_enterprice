<script setup>
import { ref } from 'vue'
import { useRoute } from 'vue-router'

const props = defineProps({
  items: {
    type: Array,
    default: () => []
  }
})

const emit = defineEmits(['itemClick'])

const expandedIndex = ref(-1)
const route = useRoute()

function toggleDropdown(index) {
  expandedIndex.value = expandedIndex.value === index ? -1 : index
}

function handleItemClick(item) {
  if (window.innerWidth <= 800) {
    emit('itemClick', item)
  }
}

function isActive(item) {
  if (item.to && route.path === item.to) return true
  if (item.children) {
    return item.children.some(child => route.path === child.to)
  }
  return false
}
</script>

<template>
  <ul class="nav flex-column">
    <template v-for="(item, index) in items" :key="index">
      <!-- Single Link -->
      <li v-if="item.to" class="nav-item">
        <RouterLink
          :to="item.to"
          class="text-white d-block nav-link  "
           :class="{ active: isActive(item) }"
          @click="handleItemClick(item)"
        >
          <i :class="item.icon"></i>
          <span class="ms-2">{{ item.text }}</span>
        </RouterLink>
      </li>

      <!-- Dropdown Item -->
      <li v-else class="nav-item">
        <a
          href="javascript:void(0)"
          class="text-white d-block nav-link "
          :class="{ active: isActive(item) }"
          @click="toggleDropdown(index)"
        >
          <i :class="item.icon"></i>
          <span class="ms-1">{{ item.text }}</span>
          <i class="fas fa-chevron-down float-end"></i>
        </a>
        <ul
          class="list-unstyled "
           v-show="expandedIndex === index || isActive(item)"
        >
          <li v-for="(child, i) in item.children" :key="i">
            <RouterLink
              :to="child.to"
              class="text-white d-block nav-link"
              :class="{ active: route.path === child.to }"
              @click="handleItemClick(child)"
            >
              <i :class="child.icon"></i>
              <span class="">{{ child.text }}</span>
            </RouterLink>
          </li>
        </ul>
      </li>
    </template>
  </ul>
</template>
