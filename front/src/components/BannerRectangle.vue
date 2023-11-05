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
      <div class="banner-right__box">
        <svg viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
          <path
            fill="#EFDA57"
            d="M33.3,-63.1C40.7,-53.3,42.8,-39.6,51.7,-28.4C60.6,-17.3,76.3,-8.6,77.8,0.9C79.3,10.4,66.6,20.7,57.9,32.3C49.3,43.9,44.7,56.8,35.8,61.4C26.8,66.1,13.4,62.6,-1.5,65.1C-16.4,67.7,-32.7,76.3,-43.3,72.6C-53.9,68.9,-58.7,52.8,-59.7,38.6C-60.8,24.5,-58,12.2,-56.4,0.9C-54.7,-10.3,-54.2,-20.7,-50.7,-30.6C-47.2,-40.5,-40.8,-50,-31.9,-59C-22.9,-67.9,-11.5,-76.3,0.7,-77.5C12.9,-78.7,25.8,-72.9,33.3,-63.1Z"
            transform="translate(80 100)"
          >
            <animate
              attributeName="d"
              dur="15000ms"
              repeatCount="indefinite"
              values="M33.3,-63.1C40.7,-53.3,42.8,-39.6,51.7,-28.4C60.6,-17.3,76.3,-8.6,77.8,0.9C79.3,10.4,66.6,20.7,57.9,32.3C49.3,43.9,44.7,56.8,35.8,61.4C26.8,66.1,13.4,62.6,-1.5,65.1C-16.4,67.7,-32.7,76.3,-43.3,72.6C-53.9,68.9,-58.7,52.8,-59.7,38.6C-60.8,24.5,-58,12.2,-56.4,0.9C-54.7,-10.3,-54.2,-20.7,-50.7,-30.6C-47.2,-40.5,-40.8,-50,-31.9,-59C-22.9,-67.9,-11.5,-76.3,0.7,-77.5C12.9,-78.7,25.8,-72.9,33.3,-63.1Z;
                      M46,-79.7C58.8,-72.4,67.6,-58.3,74.4,-43.8C81.1,-29.4,85.8,-14.7,85.1,-0.4C84.3,13.8,78.1,27.7,69,38C59.8,48.3,47.8,55.1,35.8,59C23.8,63,11.9,64.1,-2,67.5C-15.8,70.9,-31.7,76.6,-45.5,73.8C-59.4,70.9,-71.2,59.4,-74.3,45.7C-77.5,32,-71.9,16,-69,1.7C-66,-12.5,-65.6,-25.1,-60.2,-34.9C-54.8,-44.7,-44.4,-51.8,-33.5,-60.1C-22.7,-68.5,-11.3,-78.1,2.7,-82.7C16.7,-87.4,33.3,-86.9,46,-79.7Z;
                      M34.9,-60.6C44.6,-54.8,51.4,-44.2,59.5,-33.3C67.7,-22.4,77.3,-11.2,81.5,2.5C85.8,16.1,84.7,32.2,77.9,45.4C71.1,58.6,58.4,69,44.5,76.5C30.5,84.1,15.3,88.9,2.3,84.9C-10.7,81,-21.4,68.3,-32.6,59.1C-43.8,50,-55.5,44.4,-63.4,35.1C-71.3,25.8,-75.5,12.9,-75.6,-0.1C-75.7,-13.1,-71.8,-26.2,-64.8,-37C-57.8,-47.8,-47.7,-56.5,-36.4,-61.4C-25,-66.3,-12.5,-67.5,0,-67.5C12.6,-67.6,25.2,-66.5,34.9,-60.6Z;
                      M46.5,-75.4C60.4,-72.5,71.9,-60.3,78.2,-46.2C84.5,-32.1,85.6,-16,82.7,-1.7C79.8,12.7,73,25.5,65.3,37.1C57.6,48.8,49,59.4,38,64.7C27,70,13.5,70,-0.2,70.4C-13.9,70.7,-27.8,71.4,-37.3,65.3C-46.9,59.1,-52.2,46.2,-57.1,34.2C-62,22.1,-66.5,11.1,-69.3,-1.6C-72,-14.3,-73.1,-28.5,-69.3,-42.5C-65.5,-56.5,-57,-70.1,-44.6,-73.9C-32.3,-77.7,-16.1,-71.6,0.1,-71.7C16.3,-71.9,32.6,-78.3,46.5,-75.4Z;
                      M33.3,-63.1C40.7,-53.3,42.8,-39.6,51.7,-28.4C60.6,-17.3,76.3,-8.6,77.8,0.9C79.3,10.4,66.6,20.7,57.9,32.3C49.3,43.9,44.7,56.8,35.8,61.4C26.8,66.1,13.4,62.6,-1.5,65.1C-16.4,67.7,-32.7,76.3,-43.3,72.6C-53.9,68.9,-58.7,52.8,-59.7,38.6C-60.8,24.5,-58,12.2,-56.4,0.9C-54.7,-10.3,-54.2,-20.7,-50.7,-30.6C-47.2,-40.5,-40.8,-50,-31.9,-59C-22.9,-67.9,-11.5,-76.3,0.7,-77.5C12.9,-78.7,25.8,-72.9,33.3,-63.1Z"
            ></animate>
          </path>
        </svg>
      </div>
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
      text-align: center;
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
      width: 180px;
      height: 200px;
      position: relative;
      top: 350px;
      left: -330px;
      z-index: 10;
    }
  }
}
</style>
