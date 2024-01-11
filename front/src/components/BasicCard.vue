<script setup>
import { defineProps } from "vue";
import BasicButton from "@/components/BasicButton.vue";
import router from "@/router";
import { useI18n } from "vue-i18n";

const { locale: currentLanguage } = useI18n({ useScope: "global" });

const props = defineProps({
  card: Object,
  articleCategory: String,
});

const getImage = (imageName) => {
  let imageSrc;

  try {
    imageSrc = require(`@/assets/articles/${imageName}`);
  } catch (error) {
    imageSrc = "";
  }

  return imageSrc;
};

const openArticle = (articleId) => {
  router.push({
    name: "article",
    params: { id: articleId, articleCategory: props.articleCategory },
  });
};
</script>

<template>
  <div v-if="props.card.published" class="card">
    <div class="overflow-hidden">
      <img
        :src="getImage(props.card.image_name)"
        class="card-img card-img-top"
        alt="..."
      />
    </div>
    <div class="card-body text-left">
      <p class="card-title">
        {{
          currentLanguage === "pl" ? props.card.title_pl : props.card.title_en
        }}
      </p>
      <p class="card-date d-flex">
        <font-awesome-icon icon="calendar-days" />
        <span>{{ props.card.published_date }}</span>
      </p>
      <p class="card-text mb-3">
        {{
          currentLanguage === "pl"
            ? props.card.description_pl
            : props.card.description_en
        }}
      </p>
      <div class="d-flex justify-content-center">
        <BasicButton
          :button-text="$t('basic.openArticleButton')"
          @click="openArticle(props.card.id)"
        />
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
.card {
  &-title {
    font-size: 20px;
  }

  &-img {
    height: 300px;
    object-fit: cover;
    transition: transform 0.1s linear;

    &:hover {
      transform: scale(1.05);
    }
  }

  &-date {
    margin-top: 10px;
    margin-bottom: 20px;

    span {
      margin-left: 5px;
      font-size: 12px;
      color: gray;
    }
  }
}
</style>
