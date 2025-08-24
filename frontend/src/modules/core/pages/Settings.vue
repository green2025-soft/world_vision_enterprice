<script setup>
    import { shallowRef, onMounted } from 'vue'
    import { useApiClient } from '@/composables/useApiClient'
    import { useResourceApiClient } from '@/composables/resourceApiClient'
    import { useSettingsStore } from '@/store/settings-store'

    const api = useApiClient()

const {
  create,
  formErrors,
  isSubmitting,
} = useResourceApiClient('core/settings/update', 'Settings')

let settings = shallowRef();
onMounted(async () => {
    try {
      const res = await api.get(`core/settings`, { requiresAuth: false, tosterMessage: false })
      settings.value =  res.data
    } catch (err) {
      throw err
    } finally {
      
    }
});

const handleSubmit = async () => {
    try {
    const res= await create(settings.value, '', true)
    reloadSettings()
     settings.value =  res.data

  } catch (e) {
    // errors already handled in formErrors
  }
}

const settingsStore = useSettingsStore()

async function reloadSettings() {
  settingsStore.reset()
  await settingsStore.fetchSettings()
}

</script>
<template>
     <div class="container-fluid">
        <div class="card card-outline card-info">
         
            <div class="card-body" id="settings">
                  <ul class="nav nav-tabs" id="settingsTab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="general-tab" data-bs-toggle="tab" data-bs-target="#general" type="button" role="tab" aria-controls="general" aria-selected="true"> General </button>
                        </li>
                          <li class="nav-item" role="presentation">
                            <button class="nav-link" id="genlogoeral-tab" data-bs-toggle="tab" data-bs-target="#logo" type="button" role="tab" aria-controls="logo" aria-selected="true"> Logo Upload </button>
                        </li>

                    </ul>
                <div class="tab-content" v-if="settings">
                    <div class="tab-pane fade show active" id="general" role="tabpanel" aria-labelledby="general-tab">
                        <br>
                        <BaseFormGroup :required="true"
                            label="App Name"
                            label-cols="2">
                            <BCol cols="5">
                                <BFormInput v-model="settings.app_name" />
                            </BCol>
                        </BaseFormGroup>
                        <BaseFormGroup  
                            label="App Url"
                            label-cols="2">
                            <BCol cols="5">
                                <BFormInput v-model="settings.app_url" />
                            </BCol>
                        </BaseFormGroup>
                         <BFormGroup  class="mb-2"
                            label="App E-mail"
                            label-cols="2">
                            <BCol cols="5">
                                <BFormInput type="email" v-model="settings.app_email"  />
                            </BCol>
                        </BFormGroup>
                        <BFormGroup  class="mb-2"
                            label="App Contact"
                            label-cols="2">
                            <BCol cols="5">
                                <BFormInput v-model="settings.app_contact"  />
                            </BCol>
                        </BFormGroup>
                        <BFormGroup  class="mb-2"
                            label="App Address"
                            label-cols="2">
                            <BCol cols="5">
                                <BFormInput v-model="settings.app_address" />
                            </BCol>
                        </BFormGroup>
                        <BFormGroup  class="mb-2"
                            label="Currency Symbol"
                            label-cols="2">
                            <BCol cols="5">
                                <BFormInput v-model="settings.currency_symbol"  />
                            </BCol>
                        </BFormGroup>
                        <!-- <BFormGroup  class="mb-2"
                            label="Symbol Position"
                            label-cols="2">
                            <BCol cols="5">
                                <BFormSelect
                                    :options="['Left', 'Right']"
                                    required
                                    />
                            </BCol>
                        </BFormGroup> -->
                    </div>
                    <div class="tab-pane fade" id="logo" role="tabpanel" aria-labelledby="logo-tab">
                        <br>
                        <BaseFormGroup :required="true"
                            label="App Logo"
                            label-cols="2">
                            <BCol cols="5">
                                 <FileUpload v-model="settings.app_logo"  preview />
                            </BCol>
                        </BaseFormGroup>
                        <BaseFormGroup :required="true"
                            label="Icon Logo"
                            label-cols="2">
                            <BCol cols="5">
                                <FileUpload v-model="settings.icon_logo"  preview />
                            </BCol>
                        </BaseFormGroup>
                    </div>
                </div>
            </div>
            <div class="card-footer" v-if="settings">
                 <BCol sm="10" offset-md="2">
                    <LoadingButton
                    text="Update"
                    :loading="isSubmitting"
                    @click="handleSubmit"
                    />
                </BCol>
                
            </div>
            
        </div>
    </div>
</template>