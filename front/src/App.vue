<script setup>
import HeaderComponent from "@/components/HeaderComponent.vue";
</script>

<template>
  <div class="container">
    <div class="wrapper">
      <Suspense>
        <HeaderComponent />
        <template #fallback> Loading</template>
      </Suspense>
      <router-view />
    </div>
  </div>
</template>

<style lang="scss">
#app {
  overflow: hidden;
  background-color: $basic-color-gray;
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;

  .container {
    max-width: 1920px;
    overflow: hidden;
    padding: 0;
    margin: 0 auto;
  }

  .wrapper {
    margin: 0 56px;
    overflow: hidden;
  }
}
</style>
