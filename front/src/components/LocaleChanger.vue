<script setup>
const langs = [
  { code: "pl", text: "Polski" },
  { code: "en", text: "English" },
];
</script>

<template>
  <div class="locale-changer">
    <select v-model="$i18n.locale">
      <option v-for="(lang, i) in langs" :key="`Lang${i}`" :value="lang.code">
        {{ lang.text }}
      </option>
    </select>
  </div>
</template>

<style scoped lang="scss"></style>
