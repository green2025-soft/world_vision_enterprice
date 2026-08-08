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

  // =========================================
  // Module Dashboard
  // =========================================
  const moduleDashboardMenu = {
    type: 'link',
    text: 'Module Dashboard',
    to: '/core/module-dashboard',
    icon: 'fas fa-th-large'
  }

  // =========================================
  // Inventory Dashboard
  // =========================================
  const staticMenu = {
    type: 'link',
    text: 'Dashboard',
    to: '/inventory/dashboard',
    icon: 'fas fa-tachometer-alt'
  }

  // =========================================
  // Inventory Module
  // =========================================
  const core = menuStore.menus.find(
    menu => menu.module_slug === 'inventory'
  )

  // Inventory module না থাকলেও
  // এই দুইটা menu অবশ্যই থাকবে
  if (!core || !Array.isArray(core.menus)) {
    return [
      moduleDashboardMenu,
      staticMenu
    ]
  }

  // =========================================
  // Dynamic Inventory Menus
  // =========================================
  const dynamicMenus = core.menus
    .map(menu => {

      const hasChildren =
        Array.isArray(menu.children) &&
        menu.children.length > 0

      // Dropdown
      if (hasChildren) {
        return {
          type: 'dropdown',
          text: menu.title || 'Untitled',
          icon: menu.icon || 'fas fa-folder',

          children: menu.children
            .filter(child => child.route)
            .map(child => ({
              type: 'link',
              text: child.title || 'Subitem',
              to: `/${child.route.replace(/^\/+/, '')}`,
              icon: child.icon || 'fas fa-dot-circle'
            }))
        }
      }

      // Normal link
      return {
        type: 'link',
        text: menu.title || 'Untitled',
        to: menu.route
          ? `/${menu.route.replace(/^\/+/, '')}`
          : null,
        icon: menu.icon || 'fas fa-circle'
      }
    })
    .filter(menu => menu.to || menu.children?.length)

  // =========================================
  // Final Menu
  // =========================================
  return [
    moduleDashboardMenu,
    staticMenu,
    ...dynamicMenus
  ]
})
</script>

<template>
  <DashboardLayout v-model="sidenavCollapsed">

    <template #sideNav>
      <SideNav
        :items="navItems"
        @itemClick="sidenavCollapsed = true"
      />
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
