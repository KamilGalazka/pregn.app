<script setup>
import HeaderComponent from "@/components/HeaderComponent.vue";
import OpeningView from "@/views/OpeningView.vue";
import { useStore } from "@/stores/store";
import FooterComponent from "@/components/FooterComponent.vue";

const store = useStore();
</script>

<template>
  <OpeningView v-if="!store.isOpeningPageClosed" />
  <div v-else class="basic-container">
    <div class="basic-wrapper">
      <header>
        <Suspense>
          <HeaderComponent />
          <template #fallback> Loading</template>
        </Suspense>
      </header>
      <main>
        <router-view />
      </main>
      <FooterComponent />
    </div>
  </div>
</template>

<style lang="scss">
#app {
  overflow: hidden;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;

  .basic-wrapper {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
  }

  main {
    flex-grow: 1;
  }
}
</style>
