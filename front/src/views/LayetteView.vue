<script setup>
import BasicPage from "@/components/article/BasicPage.vue";

const category = "layette";
</script>

<template>
  <h1>{{ $t("article.layetteCategoryHeader") }}</h1>
  <div class="container-fluid">
    <BasicPage :article-category="category" />
  </div>
</template>

<style scoped lang="scss"></style>
