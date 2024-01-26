<script setup>
import { defineProps } from "vue";
import BasicButton from "@/components/BasicButton.vue";

const props = defineProps({
  headerText: String,
  buttonText: String,
  imageName: String,
  imagePosition: {
    type: String,
    default: "right",
  },
  imageAltText: String,
  link: {
    type: String,
    default: null,
  },
});

const setImageProperPath = () => {
  let imageSrc;

  try {
    imageSrc = require(`@/assets/${props.imageName}`);
  } catch (error) {
    imageSrc = "";
  }

  return imageSrc;
};
</script>

<template>
  <div
    :class="`basic-banner__container d-flex flex-column-reverse flex-md-row${
      props.imagePosition === 'right' ? '' : '-reverse'
    } justify-content-center align-items-center m-auto position-relative`"
  >
    <div class="basic-banner__left col-6 col-md-4 d-flex flex-column">
      <p class="basic-banner__header h2 text-center mb-5">
        {{ props.headerText }}
      </p>
      <RouterLink
        v-if="props.link"
        :to="props.link"
        class="basic-banner__button m-auto"
      >
        <BasicButton :button-text="props.buttonText" />
      </RouterLink>
      <BasicButton
        v-else
        class="basic-banner__button"
        :button-text="props.buttonText"
      />
    </div>
    <div
      class="basic-banner__right col-5 col-md-6 d-flex justify-content-center align-items-center"
    >
      <img
        class="basic-banner__image"
        :src="setImageProperPath()"
        :alt="props.imageAltText"
      />
    </div>
  </div>
</template>

<style scoped lang="scss">
.basic-banner {
  &__image {
    @media (max-width: 1200px) {
      width: 450px;
    }

    @media (max-width: 887px) {
      width: 400px;
    }
  }

  &__header {
    @media (max-width: 887px) {
      font-size: 24px;
    }
  }

  &__left {
    animation: from-left 0.7s ease-in-out 0.7s both;
  }
}

@keyframes from-left {
  0% {
    opacity: 0;
  }
  40% {
    opacity: 0.6;
  }
  100% {
    opacity: 1;
  }
}
</style>
