<script setup>
import { useRoute } from 'vue-router'
import { computed, onMounted, ref } from 'vue'
import { useSettingsStore } from '@/store/settings-store'
import { useImageUrl  } from '@/utilities/methods'
const route = useRoute()
const pageTitle = computed(() => route.meta.title || 'Dashboard')

const imageUrl = ref('')
const settingsStore = useSettingsStore()
onMounted(() => {
 settingsStore.fetchSettings().then(() => {
    imageUrl.value = useImageUrl(settingsStore.data.app_logo)
  })
  
})

</script>

<template>
   <!-- Sidebar -->
    <div class="d-flex custom-container-lg" id="wrapper">
        <!-- Sidebar for Large Screens -->
        <div id="sidebar-wrapper" class="bg-dark border-right d-none d-lg-block ">
            <div class="sidebar-heading text-white p-3">
                 <div v-if="settingsStore.loading">Loading settings...</div>
                <a v-else href="#" class="brand-link top_title">
                    <span class="w-100">
                    <img
                    v-if="imageUrl"
                    :src="imageUrl"
                    style="margin: 0 auto; max-height:40px"
                    class="d-block"
                    />
                    </span>
                    <p class="brand-text font-weight-light text-center">{{ settingsStore.data.app_name  }}</p>
                    
                </a>
                 
            </div>
           

            <ul id="sidebarAccordion">
             <slot name="sideNav"> </slot>
            </ul>

        </div>

        <!-- Offcanvas for Mobile -->
        <div class="offcanvas offcanvas-start bg-dark" tabindex="-1" id="offcanvasSidebar"
            aria-labelledby="offcanvasSidebarLabel">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title text-white" id="offcanvasSidebarLabel">{{ settingsStore.data.app_name  }}</h5>
                <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas"
                    aria-label="Close"></button>
            </div>
            <div class="offcanvas-body p-0">
              
                <ul id="sidebarAccordion">
                    <slot name="sideNav"> </slot>
                </ul>
            </div>
        </div>

        <!-- Page Content -->
        <div id="page-content-wrapper" class="w-100 d-flex flex-column">
            
            
            <slot name="header"></slot>


            <!-- Dashboard Header -->
            <div class="dashboard-header">
                  <h1>{{ pageTitle }}</h1>
            </div>

            <!-- Dashboard Content -->
            <div class="container-fluid">
                <div class="row ">
                    <div class="col-lg-12">
                        <slot name="content"></slot>
                    </div>
                </div>
            </div>

            <!-- footer aria start -->
            <div class="divider py-4"></div>
            <footer class="main-footer">
                <div class="container-fluid p-0">
                    <div class="row">
                        <div class="col-md-6 ">
                            <strong>Copyright © 2025-{{ new Date().getFullYear() }} <a href="#">{{ settingsStore.data.app_name  }}</a>.</strong>
                            All rights reserved.
                        </div>
                        <div class="col-md-6 text-end ">
                            <strong>Powered by <a href="#">{{ settingsStore.data.app_name  }}</a>.</strong>
                        </div>
                    </div>
                </div>
            </footer>
            <!-- /footer aria end -->

        </div>
    </div>
    <!-- Bootstrap JS -->

</template>


