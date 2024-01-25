<script setup>
import { ref, defineProps } from "vue";
import axios from "axios";
import routes from "@/helpers/routes";
import BasicCard from "@/components/BasicCard.vue";

const props = defineProps({
  articleCategory: String,
});

const articles = ref([]);

const getArticles = async () => {
  let response;

  try {
    response = await axios({
      method: "GET",
      url: `${routes.article}/${props.articleCategory}`,
    });
  } catch (error) {
    console.log(error);
  }

  articles.value = response.data.response;
};

getArticles();
</script>

<template>
  <div class="row mt-5">
    <div
      v-for="article in articles"
      :key="article"
      class="col-12 col-sm-6 col-lg-4 col-xl-4 gap-2 d-flex justify-content-center mb-5"
    >
      <BasicCard :card="article" :article-category="props.articleCategory" />
    </div>
  </div>
</template>

<style scoped lang="scss"></style>
