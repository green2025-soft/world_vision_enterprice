<script setup>
import AuthMaster from "@/AuthMaster.vue";
import { ref, shallowRef, computed } from "vue";
import { authenticate } from "@/store/authenticate";
import { axiosPublic } from "@/services/axiosInstance";
import { showErrorMessage, showSuccessMessage } from "@/utilities/methods";
import { useRoute, useRouter } from "vue-router";

const route = useRoute();
const router = useRouter();

const auth = authenticate;
const employeeId = ref("W-");
const password = ref();
if (auth.checkLoginStatus()) {
  router.push("/modules");
}

const passwordVisible = shallowRef(false);

const email = shallowRef("");
const otp = shallowRef("");
const tempToken = shallowRef("");
const loading = shallowRef(false);

function sendOtp() {
  loading.value = true;
  axiosPublic
    .post("/employee/send-otp", { email: email.value })
    .then((res) => {
      console.log(res.data);
    })
    .catch((err) => {
      showErrorMessage(err);
    })
    .finally(() => {
      loading.value = false;
      router.push({ query: { step: "verify-otp", email: email.value } });
      setTimeout(() => {
        document.getElementById("otp")?.focus();
      }, 111);
    });
}

function verifyOtp() {
  if (tempToken.value) {
    changePassword();
    return;
  }
  loading.value = true;
  axiosPublic
    .post("/employee/validate-otp", { email: email.value, otp: otp.value })
    .then((res) => {
      tempToken.value = res.data.tempToken;
    })
    .catch((err) => {
      showErrorMessage(err);
    })
    .finally(() => {
      loading.value = false;
      // router.push({ query: { step: "verify-otp", email: email.value } });
      // setTimeout(() => {
      //   document.getElementById("otp")?.focus();
      // }, 111);
    });
}

function changePassword() {
  if (newPassword.value !== confirmNewPassword.value) {
    showErrorMessage("Password and Confirm Password does not match");
    return;
  }

  if (newPassword.value.length < 3) {
    showErrorMessage("Password must be at least 3 characters long");
    return;
  }

  loading.value = true;
  axiosPublic
    .post("/employee/change-password-by-email", {
      tempToken: tempToken.value,
      newPassword: newPassword.value
    })
    .then((res) => {
      // console.log(res.data);
      showSuccessMessage(res.data.message);
      tempToken.value = "";
      setTimeout(() => {
        router.push("/login");
      }, 2222);

      // router.push("/login");
    })
    .catch((err) => {
      showErrorMessage(err);
    })
    .finally(() => {
      loading.value = false;
    });
}

const step = computed(() => {
  return route.query.step;
});

const enteredEmail = computed(() => route.query.email);

const newPassword = shallowRef("");
const confirmNewPassword = shallowRef("");
</script>

<template>
  <AuthMaster>
    <section
      class="login-container app_div"
      :class="{ 'login-container--visible': passwordVisible }"
    >
      <div class="container">
        <div class="row">
          <div class="col-12 col-md-10 offset-md-1">
            <div class="login-body">
              <div class="row align-items-center">
                <div class="col-md-6">
                  <div class="login-banner text-center">
                    <div class="form-logo">
                      <img src="/backend/images/logo.png" alt="logo" />
                    </div>
                    <h3>Dhaka WASA</h3>
                    <div class="software-modules mt-3">
                      <p>Medical Information Management Software</p>
                      <p>MIS Report Software</p>
                      <!-- <p>Utility Management Software (Electricity)</p> -->
                    </div>
                    <hr />
                    <div>
                      <p>Difference Innovation and Excellance</p>
                    </div>
                    <div>
                      <p><i class="fas fa-phone"></i> Helpline</p>
                      <p><i class="fas fa-book"></i> User Manual</p>
                      <!-- <p><i class="fas fa-video"></i> Video Tutorial</p> -->
                    </div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="wrap-login">
                    <span class="login-form-title pb-4"> Reset Password </span>

                    <form
                      class="login-form validate-form"
                      @submit.prevent="sendOtp"
                      v-if="step === 'send-otp'"
                    >
                      <div class="wrap-input validate-input mb-4 mt-2">
                        <span class="label-input">Enter your email</span>

                        <BFormInput
                          class="mt-2"
                          v-model="email"
                          placeholder="Enter Email"
                          type="email"
                          required
                        ></BFormInput>
                        <!-- <span class="focus-input username-icon"></span> -->
                      </div>

                      <div class="container-login-form-btn">
                        <div class="wrap-login-form-btn">
                          <div class="login-form-bgbtn"></div>
                          <BButton
                            id="submit"
                            type="submit"
                            class="login-form-btn"
                            :loading="loading"
                            variant="primary"
                          >
                            Continue
                          </BButton>
                        </div>
                      </div>
                    </form>

                    <form
                      class="login-form validate-form"
                      @submit.prevent="verifyOtp"
                      v-if="step === 'verify-otp'"
                    >
                      <div class="wrap-input validate-input mb-4 mt-2">
                        <span class="label-input">Enter your email</span>
                        <BFormInput
                          class="mt-2 mb-4"
                          :model-value="enteredEmail"
                          type="email"
                          required
                          disabled
                        ></BFormInput>

                        <span class="label-input" v-if="!tempToken"
                          >Enter OTP</span
                        >

                        <BFormInput
                          name="otp"
                          id="otp"
                          class="mt-2"
                          v-model="otp"
                          placeholder="OTP"
                          required
                          v-if="!tempToken"
                        ></BFormInput>

                        <span
                          class="d-inline-block d-block label-input"
                          v-if="tempToken"
                        >
                          Enter New Password
                        </span>

                        <BFormInput
                          name="np"
                          id="np"
                          class="mt-2"
                          v-model="newPassword"
                          placeholder="New Password"
                          required
                          v-if="tempToken"
                        ></BFormInput>

                        <span class="d-block label-input mt-3" v-if="tempToken">
                          Confirm New Password
                        </span>

                        <BFormInput
                          name="cnp"
                          id="cnp"
                          class="mt-2"
                          v-model="confirmNewPassword"
                          placeholder="Confirm New Password"
                          required
                          v-if="tempToken"
                        ></BFormInput>
                        <!-- <span class="focus-input username-icon"></span> -->
                      </div>

                      <div class="container-login-form-btn">
                        <div class="wrap-login-form-btn">
                          <div class="login-form-bgbtn"></div>
                          <BButton
                            id="submit"
                            type="submit"
                            class="login-form-btn"
                            :loading="loading"
                            variant="primary"
                          >
                            {{ tempToken ? "Reset Now" : "Continue" }}
                          </BButton>
                        </div>
                      </div>
                    </form>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </AuthMaster>
</template>

<style>
.p-relative {
  position: relative;
}

/* login css start */
.login-container {
  width: 100%;
  min-height: 100vh;
  display: -webkit-box;
  display: -webkit-flex;
  display: -moz-box;
  display: -ms-flexbox;
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  align-items: center;
  padding: 15px;
  background-repeat: no-repeat;
  background-position: center;
  background-size: cover;
  background: #d6edff;
}
.login-body {
  background: #fff;
  /* box-shadow: 0 2px 10px #ddd; */
  /* margin-bottom: 100px; */
  border-radius: 8px;
  overflow: hidden;
}
.login-banner {
  background: #03a9f5;
  width: 100%;
  height: 100%;
  color: #fff;
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 35px 25px;
}
.login-banner .form-logo img {
  padding: 10px;
  max-width: 100px;
}
.login-banner h2 {
  font-size: 30px;
  color: #fff !important;
}
.login-container .software-modules {
  text-align: left;
}
.login-container .software-modules p {
  border: 1px solid #fff;
  padding: 2px 10px;
}
.login-container .software-modules p:hover {
  background: #fff;
  color: #000;
}

.login-container .wrap-login {
  background: #fff;
  border-radius: 10px;
  overflow: hidden;
  padding: 40px;
}
.login-container .login-form {
  width: 100%;
}
.login-container .login-form img {
  width: 70px;
  display: block;
  margin: auto;
}
.login-container .login-form-title {
  display: block;
  font-size: 30px;
  color: #333;
  line-height: 1.2;
  text-align: center;
}

.container-login-form-btn {
  display: -webkit-box;
  display: -webkit-flex;
  display: -moz-box;
  display: -ms-flexbox;
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}
.login-container .wrap-login-form-btn {
  width: 100%;
  display: block;
  position: relative;
  z-index: 1;
  border-radius: 25px;
  overflow: hidden;
  margin: 0 auto;
  box-shadow: 0 5px 30px 0 rgba(3, 216, 222, 0.2);
}
.login-container .login-form-bgbtn {
  position: absolute;
  z-index: -1;
  width: 300%;
  height: 100%;
  background: linear-gradient(to right, #00dbde, #03a9f5, #00dbde, #03a9f5);
  top: 0;
  left: -100%;
  transition: all 0.4s;
}
.login-container .login-form-btn {
  font-size: 16px;
  color: #fff;
  line-height: 1.2;
  text-transform: uppercase;
  display: -webkit-box;
  display: -webkit-flex;
  display: -moz-box;
  display: -ms-flexbox;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 0 20px;
  width: 100%;
  height: 50px;
}
.login-container .wrap-login-form-btn:hover .login-form-bgbtn {
  left: 0;
}

.login-container a {
  font-size: 14px;
  line-height: 1.7;
  color: #666;
  text-decoration: none;
  margin: 0;
  transition: all 0.4s;
}

.login-container button {
  outline: none !important;
  border: none;
  background: 0 0;
}
.login-container button:hover {
  cursor: pointer;
}
.login-container iframe {
  border: none !important;
}

@media (max-width: 576px) {
  .login-container .wrap-login {
    padding-left: 15px;
    padding-right: 15px;
  }
}

.d-inline-block {
  display: inline-block;
}

.d-block {
  display: block;
}

/* login css End */
</style>
