<template>
  <Suspense>
    <HeaderComponent />
    <template #fallback> Loading</template>
  </Suspense>
  <router-view />
</template>

<script setup>
import HeaderComponent from "@/components/HeaderComponent.vue";
</script>

<style>
#app {
  overflow: hidden;
  background-color: $basic-color-gray;
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
}
</style>
