<script setup>
import BasicPage from "@/components/article/BasicPage.vue";

const category = "health";
</script>

<template>
  <h1>{{ $t("article.healthCategoryHeader") }}</h1>
  <div class="container-fluid">
    <BasicPage :article-category="category" />
  </div>
</template>

<style scoped lang="scss"></style>
