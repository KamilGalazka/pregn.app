<template>
  <div class="wrapper">
    <!--    <div class="banner__shape"></div>-->
    <div id="heart"></div>
  </div>
</template>

<script setup></script>

<style scoped lang="scss">
.banner__shape {
  background-color: black;
  width: 500px;
  height: 500px;
  margin: 0 auto;
}

#heart {
  position: relative;
  width: 100px;
  height: 90px;
}
#heart:before,
#heart:after {
  position: absolute;
  content: "";
  left: 50px;
  top: 0;
  width: 50px;
  height: 80px;
  background: red;
  border-radius: 50px 50px 0 0;
  transform: rotate(-45deg);
  transform-origin: 0 100%;
}
#heart:after {
  left: 0;
  transform: rotate(45deg);
  transform-origin: 100% 100%;
}
</style>
