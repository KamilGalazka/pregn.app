<script setup>
import ArticleBasicPage from "@/components/article/ArticleBasicPage.vue";

const category = "health";
</script>

<template>
  <h1>{{ $t("article.healthCategoryHeader") }}</h1>
  <div class="container-fluid">
    <ArticleBasicPage :article-category="category" />
  </div>
</template>

<style scoped lang="scss"></style>
