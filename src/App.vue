<template>
  <RouterView></RouterView>
</template>

<script setup>
import { RouterView } from "vue-router";
import { logoutUser, refreshSession, startSessionTimer } from './composables/session'

// Start timer when app mounts
startSessionTimer()

// Optional: refresh session on any click
window.addEventListener('click', refreshSession)
window.addEventListener('keydown', refreshSession)
</script>
