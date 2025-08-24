<script setup>
import { onBeforeMount } from "vue";
import { authenticate } from "../store/authenticate";

// authenticate;

onBeforeMount(() => {
  authenticate.logout();
  //   location.href = "/core/login";
});
</script>

<template>
  <div></div>
</template>
