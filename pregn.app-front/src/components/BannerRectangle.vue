<template>
  <div class="wrapper">
    <div class="banner-left">
      <img
        alt="Zdjęcie kobiety w ciąży"
        src="@/assets/woman.webp"
        class="banner-left__image"
      />
      <div class="banner-left__text">
        <h1>{{ $t("banner.title") }}</h1>
        <p>
          Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
          eiusmod tempor incididunt ut labore et dolore magna aliqua. Imperdiet
          sed euismod nisi porta lorem mollis aliquam.
        </p>
        <BasicButton buttonText="Sprawdź" />
      </div>
    </div>
    <div class="banner-right">
      <img
        alt="Zdjęcie pary"
        src="@/assets/pregnancy.webp"
        class="banner-right__image-top"
      />
      <img
        alt="Zdjęcie kobiety ćwiczącej yogę"
        src="@/assets/yoga.webp"
        class="banner-right__image-bottom"
      />
      <div class="banner-right__box"></div>
    </div>
  </div>
</template>

<script setup>
import BasicButton from "@/components/BasicButton.vue";
</script>

<style scoped lang="scss">
.wrapper {
  display: flex;
  flex-direction: row;
  justify-content: space-around;
  align-items: flex-start;
  width: 100vw;
  height: 90vh;
  min-height: 900px;

  img {
    border-radius: 5px;
    box-shadow: 20px 19px 13px -18px rgba(0, 0, 0, 1);
  }

  .banner-left {
    position: relative;
    top: 100px;
    left: 100px;
    width: 350px;

    &__image {
      width: 100%;
      height: 500px;
    }

    &__text {
      background-color: white;
      margin-top: 20px;
      padding: 10px;
    }
  }

  .banner-right {
    width: 500px;

    &__image-top {
      width: 300px;
      height: 200px;
      position: relative;
      top: 100px;
      z-index: 10;
    }

    &__image-bottom {
      width: 200px;
      height: 200px;
      position: relative;
      top: 350px;
      left: -350px;
      z-index: 10;
    }

    &__box {
      width: 300px;
      height: 500px;
      background-color: $basic-color-yellow;
      position: relative;
      top: -50px;
      left: 50px;
    }
  }
}
</style>
