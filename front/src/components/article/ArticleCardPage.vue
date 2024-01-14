<script setup>
import { defineProps, ref } from "vue";
import axios from "axios";
import routes from "@/helpers/routes";
import ErrorView from "@/views/ErrorView.vue";
import { useI18n } from "vue-i18n";

const { locale: currentLanguage } = useI18n({ useScope: "global" });

const props = defineProps({
  id: String,
  articleCategory: String,
});

const article = ref({});

const getArticle = async () => {
  let response;

  try {
    response = await axios({
      method: "GET",
      url: `${routes.article}/${props.articleCategory}/${props.id}`,
    });
  } catch (error) {
    console.log(error);
  }

  article.value = response.data.response;
};

getArticle();
</script>

<template>
  <div v-if="article?.published">
    <div
      v-html="
        currentLanguage === 'pl' ? article.content_pl : article.content_en
      "
    ></div>
  </div>
  <ErrorView v-else />
</template>

<style scoped lang="scss"></style>
