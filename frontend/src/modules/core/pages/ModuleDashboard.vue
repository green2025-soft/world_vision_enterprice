<template>
  <div class="row g-4">
    <div
      class="col-12 col-sm-6 col-md-4 col-lg-3"
      v-for="(module, index) in modules"
      :key="module.id"
    >
      <a
        :href="module.link"
        class="text-decoration-none text-white"
      >
        <div
          class="module-card d-flex flex-column align-items-center justify-content-center text-center"
          :style="{ background: module.bg }"
        >
          <div class="module-icon">
            <i :class="['fas', module.icon]"></i>
          </div>
          <div class="module-name">{{ module.name }}</div>
        </div>
      </a>
    </div>
  </div>
</template>

<script setup>
const modules = [
  {
    id: 1,
    name: 'Sales',
    icon: 'fa-shopping-cart',
    link: '/sales',
    bg: 'linear-gradient(135deg, #ff7e5f, #feb47b)'
  },
  {
    id: 2,
    name: 'Inventory',
    icon: 'fa-boxes',
    link: '/inventory/dashboard',
    bg: 'linear-gradient(135deg, #6a11cb, #2575fc)'
  },
  {
    id: 3,
    name: 'HRM',
    icon: 'fa-users',
    link: '/hrm',
    bg: 'linear-gradient(135deg, #43cea2, #185a9d)'
  },
  {
    id: 4,
    name: 'Accounts',
    icon: 'fa-wallet',
    link: '/accounting/dashboard',
    bg: 'linear-gradient(135deg, #f7971e, #ffd200)'
  },
   {
    id: 5,
    name: 'Core',
    icon: 'fa-cogs',
    link: '/core',
    bg: 'linear-gradient(135deg, #ede7f6, #185a9d)' // soft lavender
  },
  {
    id: 6,
    name: 'Attendance',
    icon: 'fa-calendar-check',
    link: '/attendance',
    bg: 'linear-gradient(135deg, #d38e0c, #185a9d)' // light lime
  }
]
</script>

<style scoped>
.module-card {
  min-height: 180px;
  border-radius: 14px;
  padding: 20px;
  transition: transform 0.3s, box-shadow 0.3s;
  color: #fff;
  box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
}

.module-card:hover {
  transform: translateY(-6px);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
}

.module-icon {
  font-size: 36px;
  margin-bottom: 15px;
}

.module-name {
  font-size: 1.2rem;
  font-weight: 600;
}
</style>
