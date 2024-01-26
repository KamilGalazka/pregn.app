<script setup>
import BasicBanner from "@/components/BasicBanner.vue";
import BasicButton from "@/components/BasicButton.vue";
</script>

<template>
  <BasicBanner
    :header-text="$t('mainPage.bannerTitle')"
    :button-text="$t('mainPage.bannerButtonText')"
    image-name="pregnancy-growth.svg"
    image-position="left"
    :image-alt-text="$t('mainPage.bannerAltImageText')"
    link="/stages"
  />

  <div class="account-banner my-10 py-10">
    <p v-html="$t('mainPage.accountBannerHeader')" class="h2 text-center"></p>
    <div
      class="d-flex flex-column flex-md-row justify-content-evenly align-items-center"
    >
      <div class="d-flex flex-column justify-content-center align-items-center">
        <img
          src="../assets/woman-with-calendar.svg"
          width="300"
          height="300"
          :alt="$t('mainPage.accountBannerLeftImageAltText')"
        />
        <p class="h4 text-center">
          {{ $t("mainPage.accountBannerLeftImageAltText") }}
        </p>
      </div>
      <div class="d-flex flex-column justify-content-center align-items-center">
        <img
          src="../assets/save-image.svg"
          width="300"
          height="300"
          :alt="$t('mainPage.accountBannerLeftImageAltText')"
        />
        <p class="h4 text-center">
          {{ $t("mainPage.accountBannerRightImageAltText") }}
        </p>
      </div>
    </div>
  </div>

  <div class="articles-banner my-15">
    <div class="d-flex justify-content-center align-items-center">
      <span
        class="articles-banner__title h1 mb-5 position-relative text-center"
      >
        {{ $t("mainPage.articlesBannerHeader") }}
      </span>
    </div>
    <div
      class="articles-banner__section-container d-flex flex-column flex-md-row justify-content-evenly align-items-center"
    >
      <div
        class="articles-banner__section p-5 d-flex flex-column justify-content-center align-items-center"
      >
        <img
          src="../assets/healthy-food.svg"
          width="250"
          height="250"
          :alt="$t('mainPage.articlesBannerLeftImageAltText')"
        />
        <p class="section--title h3">
          {{ $t("mainPage.articlesBannerLeftHeader") }}
        </p>
        <p class="section--description my-2">
          {{ $t("mainPage.articlesBannerLeftDescription") }}
        </p>
        <BasicButton :button-text="$t('mainPage.articlesBannerButtonText')" />
      </div>
      <div
        class="articles-banner__section p-5 d-flex flex-column justify-content-center align-items-center"
      >
        <img
          src="../assets/couple-thinking-about-layette.svg"
          width="250"
          height="250"
          :alt="$t('mainPage.articlesBannerRightImageAltText')"
        />
        <p class="section--title h3">
          {{ $t("mainPage.articlesBannerRightHeader") }}
        </p>
        <p class="section--description my-2">
          {{ $t("mainPage.articlesBannerRightDescription") }}
        </p>
        <BasicButton :button-text="$t('mainPage.articlesBannerButtonText')" />
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
.account-banner {
  min-height: 450px;
  background: linear-gradient(281.35deg, #fed841 50.64%, #ffe684 95.06%);
  border-radius: 50px;
}

.articles-banner__section {
  padding: 12px;
  background: #dcf3fe;
  border-radius: 50px 50px 50px 5px;

  button {
    transition: transform 0.3s ease-in-out;
  }

  &:hover button {
    transform: scale(1.05);
  }
}

.articles-banner {
  @media (max-width: 800px) {
    margin-top: 112px;
  }
}

.section--title {
  color: rgb(34, 57, 141);
}

.articles-banner__title:after {
  content: "";
  position: absolute;
  top: -30px;
  right: -150px;
  width: 200px;
  height: 200px;
  background: url("../assets/shine.svg") no-repeat;

  @media (max-width: 887px) {
    top: -35px;
    right: -100px;
  }

  @media (max-width: 800px) {
    top: -55px;
    right: -40px;
  }
}
</style>
