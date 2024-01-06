<script setup>
import { ref } from "vue";
import axios from "axios";

let informationAboutWeek = ref("");
let imageHeader = ref("");
let fetalLength = ref("");
let fetalWeight = ref("");
let chosenWeek = ref(1);
let chosenTrimester = ref(1);
let rangeStart = ref(1);
let rangeStop = ref(13);
let weeksArray = ref([]);
const firstComparisonToFruitWeek = 4;
const firstComparisonInNumbersWeek = 8;

const showStage = async (week) => {
  chosenWeek.value = week;

  const responseData = await axios({
    method: "GET",
    url: `http://localhost:3000/api/stage/${week}`,
  });

  const { response } = responseData.data;

  informationAboutWeek.value = response.description_pl; //todo change to current language
  imageHeader.value = response.image_header_pl; // todo change to current language
  fetalLength.value = response.length_cm;
  fetalWeight.value = response.weight_kg;
};

const evaluateRange = (rangeStart, rangeStop) => {
  for (let i = rangeStart.value; i <= rangeStop.value; i++)
    weeksArray.value.push(i);
};

const changeTrimester = (trimester) => {
  chosenTrimester.value = trimester;
  weeksArray.value = [];

  switch (trimester) {
    case 1: {
      rangeStart.value = 1;
      rangeStop.value = 13;
      showStage(1);
      break;
    }
    case 2: {
      rangeStart.value = 14;
      rangeStop.value = 27;
      showStage(14);
      break;
    }
    case 3: {
      rangeStart.value = 28;
      rangeStop.value = 40;
      showStage(28);
      break;
    }
  }

  evaluateRange(rangeStart, rangeStop);
};

const getStageImage = (week) => {
  let imageSrc;

  try {
    imageSrc = require(`@/assets/stages/week-${week}.svg`);
  } catch (error) {
    imageSrc = "";
  }

  return imageSrc;
};

showStage(1);
evaluateRange(rangeStart, rangeStop);
</script>

<template>
  <div
    class="stages__map-container d-flex flex-column justify-content-center align-items-center"
  >
    <div class="map__stages d-flex">
      <div
        v-for="trimester in 3"
        :key="trimester"
        :class="`map__stages--stage ${
          trimester === chosenTrimester ? 'current' : ''
        }`"
        @click="changeTrimester(trimester)"
      >
        {{ $t("stages.trimester") }} {{ trimester }}
      </div>
    </div>
    <div class="map__weeks d-flex flex-wrap">
      <div
        v-for="element in weeksArray"
        :key="element"
        :class="`map__weeks--week week-${element} ${
          element === chosenWeek ? 'current' : ''
        }`"
        @click="showStage(element)"
      >
        <span>{{ element }}</span>
      </div>
    </div>
  </div>
  <div
    class="stages__information-container d-flex flex-column align-items-center col-xxl-8 mx-auto"
  >
    <div class="stage__information d-flex flex-column">
      <div>
        <h1>{{ $t("stages.week") }} {{ chosenWeek }}</h1>
      </div>
      <p class="h3 text-success text-center">
        {{ $t("stages.informationSectionHeader") }}
      </p>
      <p>
        {{ informationAboutWeek }}
      </p>
    </div>
    <div class="d-flex flex-column align-items-center gap-4">
      <p
        class="h3 text-success text-center"
        v-if="chosenWeek >= firstComparisonToFruitWeek"
      >
        {{ $t("stages.comparisonSectionHeader") }}
      </p>
      <span class="h6" v-if="imageHeader">{{ imageHeader }}</span>
      <img
        class="stage__information--fruit-image"
        :src="getStageImage(chosenWeek)"
        alt="Current week"
      />
    </div>
    <div
      class="stage__information--numbers d-flex flex-column align-items-center gap-4"
      v-if="chosenWeek >= firstComparisonInNumbersWeek"
    >
      <p class="h3 text-success text-center">
        {{ $t("stages.comparisonInNumbersSectionHeader") }}
      </p>
      <div class="numbers__container d-flex gap-5">
        <div class="size d-flex flex-column justify-content-between">
          <span class="text-uppercase">{{
            $t("stages.comparisonInNumbersSectionSize")
          }}</span>
          <span
            ><strong>{{ fetalLength }} cm</strong></span
          >
          <img src="../assets/ruler.svg" />
        </div>
        <div class="weight d-flex flex-column justify-content-between">
          <span class="text-uppercase">{{
            $t("stages.comparisonInNumbersSectionWeight")
          }}</span>
          <span
            ><strong>{{ fetalWeight }}</strong> kg</span
          >
          <img src="../assets/weight-scale.svg" />
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
.stages {
  &__information-container {
    gap: 40px;
    margin-top: 24px;

    .stage__information {
      gap: 24px;

      &--fruit-image {
        width: 150px;
        height: 150px;
        object-fit: contain;
      }

      &--numbers {
        .numbers__container {
          min-height: 120px;
        }
      }
    }
  }

  &__map-container {
    margin-top: 56px;
    gap: 36px;

    .map__stages {
      gap: 24px;

      &--stage {
        cursor: pointer;

        &:hover,
        &.current {
          text-decoration: underline;
        }
      }
    }

    .map__weeks {
      gap: 5px;

      &--week {
        width: 40px;
        height: 30px;
        border-radius: 50px;
        cursor: pointer;

        &:hover {
          background: antiquewhite;

          span {
            font-size: 18px;
            background: antiquewhite;
          }
        }

        span {
          line-height: 30px;
        }

        &.current {
          background: #eeaf56;

          span {
            background: #eeaf56;
          }
        }
      }
    }
  }
}
</style>
