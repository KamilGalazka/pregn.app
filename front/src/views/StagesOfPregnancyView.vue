<script setup>
import { ref } from "vue";

let informationAboutWeek = ref(
  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
);
let chosenWeek = ref();

showStage(1);

function showStage(week) {
  chosenWeek = week;
  informationAboutWeek.value += week;

  console.log(informationAboutWeek.value);
}
</script>

<template>
  <div class="stages__map-container">
    <div class="stages__map-start">
      <img src="@/assets/start.png" alt="Start" />
    </div>
    <div
      v-for="element in 40"
      :key="element"
      :class="`stages__map-element week-${element}`"
      @click="showStage(element)"
    >
      <span>{{ element }}</span>
    </div>
  </div>
  <div class="stages__information-container">
    <div class="stage__information">
      <div>
        <h1>{{ $t("stages.week") }} {{ chosenWeek }}</h1>
      </div>
      <p>
        {{ informationAboutWeek }}
      </p>
    </div>
    <div>
      <img src="@/assets/start.png" alt="Start" />
    </div>
  </div>
</template>

<style scoped lang="scss">
.stages {
  &__information-container {
    display: flex;
    gap: 40px;
    align-items: center;
    border: 1px solid black;
    padding: 12px;
    margin-top: 24px;
  }

  &__map-container {
    height: 200px;
    position: relative;
    display: flex;

    .stages__map-start img {
      width: 50px;
      height: 50px;
      margin-top: 50px;
    }

    .stages__map-element {
      position: absolute;
      width: 30px;
      height: 30px;
      top: 0;
      left: 0;
      border: 1px solid black;
      border-radius: 50px;
      cursor: pointer;

      &:hover {
        background: antiquewhite;

        span {
          font-size: 17px;
        }
      }

      span {
        line-height: 30px;
      }

      &.week- {
        &1 {
          top: 100px;
          left: 10px;
        }
        &2 {
          top: 130px;
          left: 20px;
        }
        &3 {
          top: 155px;
          left: 40px;
        }
        &4 {
          top: 135px;
          left: 65px;
        }
        &5 {
          top: 104px;
          left: 70px;
        }
        &6 {
          top: 72px;
          left: 75px;
        }
      }
    }
  }
}
</style>
