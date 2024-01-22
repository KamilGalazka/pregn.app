<script setup></script>

<template>
  <footer class="footer">
    <span>{{ $t("basic.footerText") }}</span>
  </footer>
</template>

<style scoped lang="scss">
.footer {
  height: 50px;
  margin-top: 20px;
  border-top: 1px solid black;
  text-align: center;

  span {
    line-height: 50px;
  }
}
</style>
