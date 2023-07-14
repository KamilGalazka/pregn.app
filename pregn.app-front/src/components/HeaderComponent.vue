<template>
  <nav>
    <RouterLink to="/">
      <img alt="Application logo" src="@/assets/logo.webp" class="nav__logo" />
    </RouterLink>
    <ul>
      <li v-for="item in state.menuList" :key="item">
        <RouterLink :to="item.path">{{ item.name }}</RouterLink>
      </li>
    </ul>
  </nav>
</template>

<script setup>
import axios from "axios";
import { reactive } from "vue";

const state = reactive({
  menuList: {},
});

async function fetchMenuList() {
  const response = await axios({
    method: "GET",
    url: "http://localhost:3000/api/navigation",
  });

  return response.data.response;
}

state.menuList = await fetchMenuList();
</script>

<style scoped lang="scss">
nav {
  display: flex;
  width: 100vw;
  padding: 10px;

  .nav__logo {
    width: 180px;
    height: 60px;
    margin-left: 50px;
  }

  ul {
    display: flex;
    width: 60%;
    justify-content: space-around;
    align-items: center;
    list-style: none;

    a {
      text-decoration: none;
      color: black;
      font-weight: 500;
      letter-spacing: 3px;

      &:hover {
        color: aqua;
      }
    }
  }
}
</style>
