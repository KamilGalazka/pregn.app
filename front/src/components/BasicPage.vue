<script setup>
import { defineProps, ref } from "vue";
import axios from "axios";
import routes from "@/helpers/routes";
import ErrorView from "@/views/ErrorView.vue";
import { useI18n } from "vue-i18n";

const { locale: currentLanguage } = useI18n({ useScope: "global" });

const props = defineProps({
  pageType: String,
});

const page = ref({});

const getPage = async () => {
  let response;

  try {
    response = await axios({
      method: "GET",
      url: `${routes.page}${props.pageType}`,
    });
  } catch (error) {
    console.log(error);
  }

  page.value = response.data.response;
};

getPage();
</script>

<template>
  <div v-if="page?.published">
    <div
      v-html="currentLanguage === 'pl' ? page.content_pl : page.content_en"
    ></div>
  </div>
  <ErrorView v-else />
</template>

<style scoped lang="scss"></style>
