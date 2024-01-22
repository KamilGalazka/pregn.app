<script setup>
import { useStore } from "@/stores/store";
import router from "@/router";
import { computed, markRaw, ref } from "vue";
import SetMainCategory from "@/components/admin/SetMainCategory.vue";
import SetBasicLayout from "@/components/admin/SetBasicLayout.vue";
import ErrorView from "@/views/ErrorView.vue";
import { useI18n } from "vue-i18n";

const { locale: currentLanguage } = useI18n({ useScope: "global" });

const items = computed(() => {
  return [
    {
      name: `${
        currentLanguage.value === "pl" ? "Kategorie główne" : "Main category"
      }`,
      component: markRaw(SetMainCategory),
    },
    {
      name: `${currentLanguage.value === "pl" ? "Wygląd" : "Layout"}`,
      component: markRaw(SetBasicLayout),
    },
  ];
});

const store = useStore();
const currentTab = ref(items.value[0].component);

if (!store.isUserLogged) router.push("/login");
</script>

<template>
  <div v-if="store.isUserLogged && store.isUserAdmin" class="admin">
    <h1>{{ $t("admin.header") }}</h1>
    <div class="admin__container">
      <div class="admin__menu col-2">
        <ul class="admin__menu--list">
          <li v-for="item in items" :key="item" class="admin__menu--item">
            <span @click="currentTab = item.component">
              {{ item.name }}
            </span>
          </li>
        </ul>
      </div>
      <div class="admin__actions col-10">
        <h3 class="admin__actions--header">{{ $t("admin.options") }}</h3>
        <Suspense>
          <component :is="currentTab"></component>
          <template #fallback> Loading</template>
        </Suspense>
      </div>
    </div>
  </div>
  <ErrorView v-else />
</template>

<style scoped lang="scss">
.admin {
  &__container {
    display: flex;
    padding-top: 24px;
  }

  &__menu {
    border-right: 1px solid $basic-border-color;

    &--list {
      list-style: none;
    }

    &--item {
      cursor: pointer;

      &:hover {
        color: $basic-color-hover;
      }
    }
  }

  &__actions {
    padding: 24px;

    &--header {
      border: none;
      color: black;
      text-align: center;
      margin-bottom: 24px;
    }
  }
}
</style>
