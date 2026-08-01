<script setup>
import { useSettingsStore } from '@/store/settings-store'
import {  printADiv, useImageUrl } from '@/utilities/methods'
const settingsStore = useSettingsStore()
</script>
<template>
    
        <!-- Header -->
        <div class="row align-items-center mb-3">
            <div class="col-md-12">
                <div class="d-flex align-items-center">
                    <div class="company-logo me-3">
                        <img width="70" height="70" :src="useImageUrl(settingsStore.data.app_logo)" />
                    </div>

                    <div>
                        <h1 class="invoice-title">{{ settingsStore.data.app_name  }}</h1>
                        <div>{{ settingsStore.data.app_address }}</div>
                        <div>{{ settingsStore.data.app_contact }}</div>
                        <div>{{ settingsStore.data.app_email }}</div>
                    </div>
                </div>
            </div>
        </div>
         <hr>
         
</template>