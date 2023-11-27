<script setup>
import { defineProps } from "vue";

const props = defineProps({
  buttonText: {
    type: String,
    default: "",
  },
});
</script>

<template>
  <button class="btn">{{ props.buttonText }}</button>
</template>

<style scoped lang="scss">
.btn {
  color: white;
  margin-top: 10px;
  background-color: $basic-color-blue;
  border-color: $basic-color-blue;
  height: 48px;

  &:focus {
    border-color: lighten($basic-color-blue, 30%);
    box-shadow: 0 0 0 0.25rem lighten($basic-color-blue, 30%);
  }
}
</style>
