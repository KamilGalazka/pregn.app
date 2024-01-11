<script setup>
import ArticleBasicPage from "@/components/article/ArticleBasicPage.vue";

const category = "layette";
</script>

<template>
  <h1>{{ $t("article.layetteCategoryHeader") }}</h1>
  <div class="container-fluid">
    <ArticleBasicPage :article-category="category" />
  </div>
</template>

<style scoped lang="scss"></style>
