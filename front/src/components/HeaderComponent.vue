<script setup>
import axios from "axios";
import { reactive } from "vue";
import LocaleChanger from "@/components/LocaleChanger.vue";
import { useStore } from "@/stores/store";
import routes from "@/helpers/routes";
import router from "@/router";

const state = reactive({
  menuList: {},
});
const store = useStore();

state.menuList = await fetchMenuList();

async function fetchMenuList() {
  const response = await axios({
    method: "GET",
    url: routes.navigation,
  });

  return response.data.response; //todo language check
}

function logoutHandler() {
  store.setUserStatus({
    isLogged: false,
    isAdmin: false,
    token: "",
  });

  fetchMenuList();
  router.push("/");
}

function checkIfCategoryCanBeDisplayed(category) {
  if (!category.published) return false;

  return !(category.user_only && !store.isUserLogged);
}
</script>

<template>
  <nav class="nav">
    <RouterLink to="/">
      <img alt="Application logo" src="@/assets/logo.webp" class="nav__logo" />
    </RouterLink>

    <ul class="nav__list">
      <li
        v-for="category in state.menuList"
        :key="category"
        class="nav__list--item"
      >
        <RouterLink
          v-if="checkIfCategoryCanBeDisplayed(category)"
          :to="category.route"
        >
          {{ category.name_pl }}
        </RouterLink>
      </li>
    </ul>

    <div class="d-flex gap-3 align-items-center">
      <div v-if="store.isUserLogged">
        <RouterLink to="/settings">
          <font-awesome-icon icon="sliders" />
        </RouterLink>
      </div>
      <div v-if="store.isUserLogged && store.isUserAdmin">
        <RouterLink to="/admin">
          <font-awesome-icon icon="gears" />
        </RouterLink>
      </div>
      <div
        v-if="store.isUserLogged"
        @click="logoutHandler"
        class="nav__logout--button"
        data-cy="header__logout-button"
      >
        <font-awesome-icon icon="right-from-bracket" />
      </div>
      <div v-else>
        <RouterLink to="/login" data-cy="header__login-button">
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
