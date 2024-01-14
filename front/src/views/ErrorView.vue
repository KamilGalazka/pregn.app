<script setup></script>

<template>
  <div class="error-page col-4 d-flex flex-column align-items-center m-auto">
    <img class="error-page__img" src="../assets/lost-child.svg" />
    <h1 class="error-page__header">{{ $t("error.header404") }}</h1>
    <p class="error-page__info">{{ $t("error.info404") }}</p>
  </div>
</template>

<style scoped lang="scss">
.error-page {
  &__img {
    width: 450px;
    height: 400px;
  }

  &__header {
    font-size: 64px;
    border: none;
  }
}
</style>
