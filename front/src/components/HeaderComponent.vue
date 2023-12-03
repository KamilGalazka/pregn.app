<script setup>
import axios from "axios";
import { reactive } from "vue";
import LocaleChanger from "@/components/LocaleChanger.vue";
import { useStore } from "@/stores/store";

const state = reactive({
  menuList: {},
});
const store = useStore();

state.menuList = await fetchMenuList();

async function fetchMenuList() {
  const response = await axios({
    method: "GET",
    url: "http://localhost:3000/api/navigation",
  });

  return response.data.response;
}

function logoutHandler() {
  store.setUserStatus({
    isLogged: false,
  });
}
</script>

<template>
  <nav class="nav">
    <RouterLink to="/">
      <img alt="Application logo" src="@/assets/logo.webp" class="nav__logo" />
    </RouterLink>

    <ul class="nav__list">
      <li v-for="item in state.menuList" :key="item" class="nav__list--item">
        <RouterLink :to="item.route">{{ item.name }}</RouterLink>
      </li>
    </ul>

    <div class="d-flex gap-3 align-items-center">
      <div v-if="store.isUserLogged && store.isUserAdmin">
        <RouterLink to="/admin">
          <font-awesome-icon icon="gears" />
        </RouterLink>
      </div>
      <div
        v-if="store.isUserLogged"
        @click="logoutHandler"
        class="nav__logout--button"
      >
        <font-awesome-icon icon="right-from-bracket" />
      </div>
      <div v-else>
        <RouterLink to="/login">
          <font-awesome-icon icon="user" />
        </RouterLink>
      </div>
      <LocaleChanger />
    </div>
  </nav>
</template>

<style scoped lang="scss">
.nav {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px 0 60px;

  &__logo {
    width: 180px;
    height: 60px;
  }

  &__list {
    display: flex;
    justify-content: flex-end;
    gap: 40px;
    width: 60%;
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

  &__logout--button {
    cursor: pointer;
  }
}
</style>
