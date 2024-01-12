<script setup>
import { useStore } from "@/stores/store";
import BasicButton from "@/components/BasicButton.vue";

const store = useStore();
const handleClose = () => store.setOpeningPageAsOpened();
</script>

<template>
  <div class="opening-page__container">
    <div class="opening-page">
      <div class="opening-page__left">
        <img src="../assets/couple.jpg" />
      </div>
      <div class="opening-page__right">
        <h1 class="opening-page__header">pregn.app</h1>
        <div class="opening-page__text">
          <p class="opening-page__text--main">
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
          </p>
          <p class="opening-page__text--extra">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit.
          </p>
        </div>
        <BasicButton
          @click="handleClose"
          button-text="Przejdź dalej"
          data-cy="opening-page__button"
        />
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
.opening-page {
  display: flex;
  align-items: center;
  padding: 96px;
  height: 70%;

  &__container {
    width: 100vw;
    height: 100vh;
    background: #ebcfc2;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  &__left {
    height: 100%;
    clip-path: polygon(20% 1%, 94% 1%, 81% 100%, 7% 100%);

    img {
      max-width: 950px;
    }
  }

  &__right {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    height: 100%;
  }

  &__header {
    border: none;
  }

  &__text {
    color: #e88a5f;
    text-align: left;

    &--main {
      font-size: 56px;
    }

    &--extra {
      font-size: 24px;
    }
  }
}
</style>
