<script setup>
import { shallowRef, computed, onMounted } from 'vue'
import { RouterView } from 'vue-router'
import SideNav from '@/components/SideNav.vue'
import AdminHeader from '@/components/AdminHeader.vue'
import DashboardLayout from '@/views/DashboardLayout.vue'
import { useMenuStore } from '@/store/menu-store'

const sidenavCollapsed = shallowRef(true)
const menuStore = useMenuStore()

onMounted(async () => {
  if (!menuStore.menus.length) {
    await menuStore.fetchUserMenus()
  }
})

const navItems = computed(() => {
  const staticMenu = {
    type: 'link',
    text: 'Dashboard',
    to: '/inventory/dashboard',
    icon: 'fas fa-tachometer-alt'
  }

  

  const core = menuStore.menus.find(m => m.module_slug === 'inventory')
  if (!core || !core.menus) return [staticMenu] // fallback to only static menu

  const dynamicMenus = core.menus.map(menu => {
  const hasChildren = Array.isArray(menu.children) && menu.children.length > 0

  if (hasChildren) {
    return {
      type: 'dropdown',
      text: menu.title || 'Untitled',
      icon: menu.icon || 'fas fa-folder',
      children: menu.children
        .filter(child => !!child.route)
        .map(child => ({
          text: child.title || 'Subitem',
          to: `/${child.route.replace(/^\/+/, '')}`,
          icon: child.icon || 'fas fa-dot-circle'
        }))
    }
  }else{
  return {
      type: 'link',
      text: menu.title || 'Untitled',
      icon: menu.icon || 'fas fa-circle'
    }
  }
  
}).filter(Boolean)


  return [staticMenu, ...dynamicMenus]
})

</script>

<template>
  <DashboardLayout v-model="sidenavCollapsed">
    <template #sideNav>
      <SideNav :items="navItems" @itemClick="sidenavCollapsed = true" />
    </template>

    <template #header>
      <AdminHeader
        :sidebarCollapsed="sidenavCollapsed"
        @hamburgerClick="sidenavCollapsed = !sidenavCollapsed"
      />
    </template>

    <template #content>
      <RouterView />
    </template>
  </DashboardLayout>
</template>
