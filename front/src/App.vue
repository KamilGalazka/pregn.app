<script setup>
import HeaderComponent from "@/components/HeaderComponent.vue";
import OpeningView from "@/views/OpeningView.vue";
import { useStore } from "@/stores/store";

const store = useStore();
</script>

<template>
  <OpeningView v-if="!store.isOpeningPageClosed" />
  <div v-else class="basic-container">
    <div class="basic-wrapper">
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
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
}
</style>
