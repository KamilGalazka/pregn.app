<script setup></script>

<template>
  <div class="error-page col-4">
    <h1 class="error-page__header">{{ $t("error.header404") }}</h1>
    <p class="error-page__info text-center">{{ $t("error.info404") }}</p>
  </div>
</template>

<style scoped lang="scss">
.error-page {
  margin: 120px auto 0;

  &__header {
    border: none;
    text-align: center;
    margin-bottom: 24px;
  }
}
</style>
