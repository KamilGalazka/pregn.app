<script setup>
import { onMounted, ref } from "vue";
import axios from "axios";
import routes from "@/helpers/routes";
import { useI18n } from "vue-i18n";

const { locale: currentLanguage } = useI18n({ useScope: "global" });

const fetalInformation = ref({});
const chosenWeek = ref(1);
const chosenTrimester = ref(1);
const rangeStart = ref(1);
const rangeStop = ref(13);
const weeksArray = ref([]);
const firstComparisonToFruitWeek = 4;
const firstComparisonInNumbersWeek = 8;

const showStage = async (week) => {
  chosenWeek.value = week;

  const responseData = await axios({
    method: "GET",
    url: `${routes.stage}/${week}`,
  });

  const { response } = responseData.data;

  fetalInformation.value = response;
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

onMounted(() => {
  showStage(1);
  evaluateRange(rangeStart, rangeStop);
});
</script>

<template>
  <h1>{{ $t("stages.header") }}</h1>
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

    <div
      class="trimester__information-container container-lg m-auto p-5 mb-5 d-flex justify-content-center align-items-center"
    >
      <p class="text-center">
        {{ $t(`stages.trimesterInformation[${chosenTrimester - 1}]`) }}
      </p>
    </div>

    <div class="map__weeks d-flex flex-wrap justify-content-between">
      <div class="map__weeks--line"></div>
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
  <div class="stages__information-wrapper container-lg m-auto py-5">
    <div
      class="stages__information-container m-auto row d-flex justify-content-center flex-md-row flex-column align-items-center align-items-lg-start"
    >
      <div class="stage__information col-12 col-lg-6 mb-5">
        <p class="h3 text-success text-center mb-6">
          {{ $t("stages.informationSectionHeader") }}
        </p>
        <p class="text-center">
          {{
            currentLanguage === "pl"
              ? fetalInformation.description_pl
              : fetalInformation.description_en
          }}
        </p>
      </div>
      <div class="col-12 col-lg-6 d-flex flex-column gap-5">
        <div class="d-flex flex-column align-items-center gap-4">
          <p
            class="h3 text-success text-center"
            v-if="chosenWeek >= firstComparisonToFruitWeek"
          >
            {{ $t("stages.comparisonSectionHeader") }}
          </p>
          <span
            class="h6 text-center"
            v-if="currentLanguage === 'pl' && fetalInformation.image_header_pl"
          >
            {{ fetalInformation.image_header_pl }}
          </span>
          <span
            class="h6"
            v-else-if="
              currentLanguage === 'en' && fetalInformation.image_header_en
            "
          >
            {{ fetalInformation.image_header_en }}
          </span>
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
              <span class="text-uppercase text-center">{{
                $t("stages.comparisonInNumbersSectionSize")
              }}</span>
              <span class="text-center"
                ><strong>{{ fetalInformation.length_cm }}</strong> cm</span
              >
              <img src="../assets/ruler.svg" />
            </div>
            <div class="weight d-flex flex-column justify-content-between">
              <span class="text-uppercase text-center">{{
                $t("stages.comparisonInNumbersSectionWeight")
              }}</span>
              <span class="text-center"
                ><strong>{{ fetalInformation.weight_kg }}</strong> kg</span
              >
              <img src="../assets/weight-scale.svg" />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
.stages {
  &__information-wrapper {
    min-height: 500px;
    background: linear-gradient(
      90deg,
      rgba(255, 236, 236, 1) 0%,
      rgba(251, 192, 192, 1) 100%
    );
    border-radius: 50px;
  }

  &__information-container {
    max-width: 900px;

    .stage__information {
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
    margin-bottom: 56px;
    gap: 36px;

    .map__stages {
      gap: 24px;

      @media (max-width: 360px) {
        flex-direction: column;
        gap: 8px;
      }

      &--stage {
        cursor: pointer;

        &:hover,
        &.current {
          text-decoration: underline;
        }
      }
    }

    .map__weeks {
      max-width: 900px;
      width: 100%;
      position: relative;

      &--week {
        width: 40px;
        height: 40px;
        border-radius: 50px;
        cursor: pointer;
        text-align: center;
        background: $basic-color-blue;
        color: white;

        &:hover {
          background: darken($basic-color-blue, 20);

          span {
            font-size: 18px;
          }
        }

        span {
          line-height: 40px;
        }

        &.current {
          background: #eeaf56;

          span {
            background: #eeaf56;
          }
        }
      }

      &--line {
        position: absolute;
        top: 19px;
        left: 0;
        height: 2px;
        width: calc(100% - 2px);
        z-index: -1;
        background-color: black;
      }
    }
  }
}

.trimester__information-container {
  min-height: 270px;
  background: linear-gradient(
    90deg,
    rgba(251, 192, 192, 1) 0%,
    rgba(255, 236, 236, 1) 100%
  );
  border-radius: 50px;
}
</style>
