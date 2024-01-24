<script setup>
import axios from "axios";
import { reactive } from "vue";
import LocaleChanger from "@/components/LocaleChanger.vue";
import { useStore } from "@/stores/store";
import routes from "@/helpers/routes";
import router from "@/router";
import { useI18n } from "vue-i18n";

const { locale: currentLanguage } = useI18n({ useScope: "global" });
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

  return response.data.response;
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
  <nav class="navbar navbar-expand-xl navbar-light mb-5">
    <div class="container-fluid">
      <RouterLink to="/" class="navbar-brand">
        <img
          :alt="$t('menu.logoAltText')"
          src="@/assets/logo.webp"
          class="d-inline-block align-text-top"
        />
      </RouterLink>

      <button
        class="navbar-toggler"
        type="button"
        data-bs-toggle="collapse"
        data-bs-target="#navbarNav"
        aria-controls="navbarNav"
        aria-expanded="false"
        :aria-label="$t('menu.menuButtonAriaLabel')"
      >
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
          <li
            class="nav-item"
            v-for="category in state.menuList"
            :key="category"
          >
            <RouterLink
              v-if="checkIfCategoryCanBeDisplayed(category)"
              :to="category.route"
              class="nav-link active"
            >
              {{
                currentLanguage === "pl" ? category.name_pl : category.name_en
              }}
            </RouterLink>
          </li>

          <li class="nav-item dropdown">
            <a
              class="nav-link dropdown-toggle"
              href="#"
              id="navbarDropdownMenuLink"
              role="button"
              data-bs-toggle="dropdown"
              aria-expanded="false"
            >
              {{ $t("menu.userDropdownButton") }}
            </a>
            <ul
              class="dropdown-menu px-1 mb-3"
              aria-labelledby="navbarDropdownMenuLink"
            >
              <li v-if="store.isUserLogged" class="dropdown-item">
                <RouterLink to="/settings">
                  {{ $t("menu.settingsButton") }}
                </RouterLink>
              </li>

              <li><hr class="dropdown-divider" /></li>

              <li
                v-if="store.isUserLogged && store.isUserAdmin"
                class="dropdown-item"
              >
                <RouterLink to="/admin">
                  {{ $t("menu.adminPanelButton") }}
                </RouterLink>
              </li>

              <li><hr class="dropdown-divider" /></li>

              <li
                v-if="store.isUserLogged"
                @click="logoutHandler"
                class="dropdown-item nav__logout--button"
                data-cy="header__logout-button"
              >
                {{ $t("menu.logoutButton") }}
              </li>

              <li v-else class="dropdown-item" data-cy="header__login-button">
                <RouterLink to="/login" data-cy="header__login-button">
                  {{ $t("menu.loginButton") }}
                </RouterLink>
              </li>
            </ul>
          </li>

          <li class="nav-item nav-item__locale-changer ms-5">
            <LocaleChanger />
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<style scoped lang="scss">
.navbar-brand img {
  width: 200px;
  height: 70px;
  margin-right: 60px;

  @media (max-width: 400px) {
    margin-right: 0;
    width: 150px;
    height: 55px;
  }
}

#navbarNav {
  #navbarDropdownMenuLink {
    color: black;
  }

  .nav__logout--button {
    cursor: pointer;
  }

  .dropdown-item a {
    color: black;
    text-decoration: none;
  }

  .router-link-active {
    color: $basic-color-blue;
  }

  .nav-item:not(.dropdown):hover a,
  .dropdown-item:hover a,
  .dropdown-item.nav__logout--button:hover {
    color: $basic-color-hover;
  }

  .nav-item__locale-changer {
    width: 80px;
  }
}
</style>
