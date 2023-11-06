<script setup>
import axios from "axios";
import { reactive } from "vue";
import LocaleChanger from "@/components/LocaleChanger.vue";

const state = reactive({
  menuList: {},
});

state.menuList = await fetchMenuList();

async function fetchMenuList() {
  const response = await axios({
    method: "GET",
    url: "http://localhost:3000/api/navigation",
  });

  return response.data.response;
}
</script>

<template>
  <nav class="nav">
    <RouterLink to="/">
      <img alt="Application logo" src="@/assets/logo.webp" class="nav__logo" />
    </RouterLink>
    <ul class="nav__list">
      <li v-for="item in state.menuList" :key="item" class="nav__list--item">
        <RouterLink :to="item.path">{{ item.name }}</RouterLink>
      </li>
    </ul>
    <LocaleChanger />
  </nav>
</template>

<style scoped lang="scss">
.nav {
  display: flex;
  align-items: center;
  justify-content: space-around;
  padding: 10px 0;

  &__logo {
    width: 180px;
    height: 60px;
    margin-left: 50px;
  }

  &__list {
    display: flex;
    width: 60%;
    justify-content: space-around;
    align-items: center;
    list-style: none;

    a {
      text-decoration: none;
      color: black;
      font-weight: 300;
      letter-spacing: 3px;

      &:hover {
        color: #727272;
      }
    }
  }
}
</style>
