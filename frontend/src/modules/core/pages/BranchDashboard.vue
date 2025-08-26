<script setup>
    import { ref, onMounted } from 'vue'
    import { useResourceApiClient } from '@/composables/resourceApiClient'
    import { useImageUrl  } from '@/utilities/methods'
    import { useRouter } from 'vue-router'
    import { useBranchStore } from '@/store/branch-store'
    const router = useRouter()
    const branchStore = useBranchStore()

    function handleBranchClick(id, data) {
      branchStore.setBranchId(id, data)
      router.push('/core/module-dashboard') 
    }

    const {
    customGet,
    } = useResourceApiClient('core/branches', 'Branch')

    let branches = ref([]);
    onMounted(async () => {
        branchStore.clearBranchId()
        branches.value = await customGet(`core/branches/lists`)
    })
</script>
<template>
    <div class="container-fluid">
        <div class="row g-3" v-if="branches">
            <div class="col-12 col-sm-6 col-md-4 col-lg-3" v-for="(data, dataIndex) in branches" :key="data.id">
                <a href="@" @click.prevent="handleBranchClick(data.id, data)"  class="text-decoration-none text-dark">
                    <div class="branch-card">
                        <div class="branch-logo">
                            <img :src="useImageUrl(data.logo)" alt="Head Office Logo"
                            onerror="this.parentElement.innerHTML='<i class=\'fas fa-building branch-icon\'></i>'">
                        </div>
                        <div class="branch-name">{{ data.name }}</div>
                        <div class="branch-phone" v-if="data.contact_no"><i class="fas fa-phone-alt me-1"></i> {{ data.contact_no }}</div>
                    </div>
                </a>
            </div>


        </div>
    </div>
</template>
 <style scoped>
  .branch-card {
      min-height: 180px;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
      padding: 20px;
      background-color: #ffffff;
      border: 1px solid #eee;
      text-align: center;
      transition: transform 0.2s;
    }

    .branch-card:hover {
      transform: translateY(-5px);
    }

    .branch-logo {
      width: 60px;
      height: 60px;
      margin: 0 auto 15px;
      border: 2px solid #ddd;
      border-radius: 50%;
      background-color: #f0f0f0;
      overflow: hidden;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .branch-logo img {
      width: 100%;
      height: 100%;
      object-fit: contain;
    }

    .branch-icon {
      font-size: 28px;
      color: #4e54c8;
    }

    .branch-name {
      font-size: 1.2rem;
      font-weight: 600;
    }

    .branch-phone {
      font-size: 1rem;
      color: #555;
    }
  </style>
