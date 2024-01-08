<script setup>
import { defineProps } from "vue";
import BasicButton from "@/components/BasicButton.vue";

const props = defineProps({ card: Object });
const getImage = (imageName) => {
  let imageSrc;

  try {
    imageSrc = require(`@/assets/health/${imageName}`);
  } catch (error) {
    imageSrc = "";
  }

  return imageSrc;
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
      <p class="card-title">{{ props.card.title_pl }}</p>
      <p class="card-date d-flex">
        <font-awesome-icon icon="calendar-days" />
        <span>{{ props.card.published_date }}</span>
      </p>
      <p class="card-text mb-3">
        {{ props.card.description_pl }}
      </p>
      <div class="d-flex justify-content-center">
        <BasicButton :button-text="$t('basic.openArticleButton')" />
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
