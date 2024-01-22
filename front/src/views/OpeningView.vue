<script setup>
import { useStore } from "@/stores/store";
import BasicButton from "@/components/BasicButton.vue";

const store = useStore();
const handleClose = () => store.setOpeningPageAsOpened();
</script>

<template>
  <div
    class="opening-page__container d-flex justify-content-center align-items-center"
  >
    <div class="opening-page d-flex align-items-center flex-column flex-md-row">
      <div>
        <img
          class="opening-page__image"
          src="../assets/opening-page.svg"
          :alt="$t('openingPage.imageAltText')"
        />
      </div>
      <div class="d-flex flex-column justify-content-between">
        <h1 class="opening-page__header mb-5 border-none">
          {{ $t("openingPage.appName") }}
        </h1>
        <div class="opening-page__text mb-5">
          <p>{{ $t("openingPage.mainText") }}</p>
        </div>
        <BasicButton
          @click="handleClose"
          :button-text="$t('openingPage.buttonText')"
          class="opening-page__button m-auto"
          data-cy="opening-page__button"
        />
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
.opening-page {
  padding: 0 24px;
  max-width: 1200px;

  &__container {
    width: 100vw;
    height: 100vh;
  }

  &__image {
    @media (max-width: 600px) {
      width: 350px;
      height: 350px;
    }

    @media (max-width: 350px) {
      width: 250px;
      height: 250px;
    }
  }

  &__header {
    color: black;
  }

  &__text {
    color: #e88a5f;
    font-size: 56px;

    @media (max-width: 1200px) {
      font-size: 42px;
    }

    @media (max-width: 600px) {
      font-size: 36px;
    }

    @media (max-width: 350px) {
      font-size: 24px;
    }
  }

  &__button {
    width: 150px;
  }
}
</style>
