<script setup>
import { ref, shallowRef, onMounted } from "vue";
import { authenticate } from "@/store/authenticate";
import { useSettingsStore } from '@/store/settings-store'
import { useImageUrl  } from '@/utilities/methods'
const settingsStore = useSettingsStore()

const auth = authenticate;
const username = ref();
const password = ref();
if (auth.checkLoginStatus()) {
  // router.push("/modules");
}

const imageUrl = ref('')
onMounted(() => {
 settingsStore.fetchSettings().then(() => {
    imageUrl.value = useImageUrl(settingsStore.data.app_logo)
  })
  
})

const passwordVisible = shallowRef(false);
</script>

<template>
  
    <div class="container-login">
    <div class="wrap-login">
      <form class="login-form validate-form">
        <img  v-if="imageUrl"
                    :src="imageUrl" alt="logo">
        <span class="login-form-title"> {{ settingsStore.data.app_name  }} </span>
        <span class="pb-3 login-form-subtitle">Sign in to Continue</span>
          

        <!-- Username Input -->
        <div class="wrap-input validate-input mb-4">
          <span class="label-input">Username</span>
            <BInputGroup>
            <span class="input-group-text bg-secondary">
              <i class="fas fa-user text-white"></i>
            </span>
            <BFormInput v-model="username" placeholder="Type your username"  />
          </BInputGroup>
        </div>

        <!-- Password Input -->
        <div class="wrap-input validate-input">
          <span class="label-input">Password</span>
          <BInputGroup>
            <span class="input-group-text bg-secondary">
              <i class="fas fa-lock text-white"></i>
            </span>
             <BFormInput v-model="password"  type="password" :type="passwordVisible ? 'text' : 'password'" placeholder="Type your password"  />
          </BInputGroup>
        </div>

        <div class="text-end  pb-4 d-none">
          <RouterLink to="/core/module" class="text-decoration-none"> Forgot password? </RouterLink>
        </div>

        <!-- Submit Button -->
        <div class="container-login-form-btn">
          <div class="wrap-login-form-btn">
            <div class="login-form-bgbtn"></div>
            <button   type="submit" id="submit"  @click.prevent="auth.authenticate(username, password)
                            " class="login-form-btn">Login</button>
          </div>
        </div>
      </form>
    </div>
  </div>

</template>
