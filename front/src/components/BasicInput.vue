<script setup>
import { defineProps } from "vue";

const props = defineProps({
  for: {
    type: String,
    default: "",
  },
  type: {
    type: String,
    default: "",
  },
  text: {
    type: String,
    default: "",
  },
});
</script>

<template>
  <div class="mb-3">
    <label :for="props.for" class="form-label">{{ props.text }}</label>
    <input :type="props.type" class="form-control" :id="props.for" />
  </div>
</template>

<style scoped lang="scss"></style>
