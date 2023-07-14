<template>
  <Suspense>
    <HeaderComponent />

    <template #fallback> Loading </template>
  </Suspense>
  <BannerRectangle />
  <BannerRectangle />
  <BannerRectangle />
  <FooterComponent />
</template>

<script setup>
import HeaderComponent from "@/components/HeaderComponent.vue";
import BannerRectangle from "@/components/BannerRectangle.vue";
import FooterComponent from "@/components/FooterComponent.vue";
</script>
