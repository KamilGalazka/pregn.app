<script setup>
import axios from "axios";
import { reactive } from "vue";
import BasicButton from "@/components/BasicButton.vue";
import routes from "@/helpers/routes";

const state = reactive({
  menuList: {},
});

state.menuList = await fetchMenuList();

async function fetchMenuList() {
  const response = await axios({
    method: "GET",
    url: routes.navigation,
  });

  return response.data.response;
}

const saveChanges = () => {
  console.log("todo");
};
</script>

<template>
  <div class="wrapper col-lg-12 mx-auto">
    <table class="table table-striped">
      <thead>
        <tr>
          <th scope="col">#</th>
          <th scope="col">{{ $t("admin.menu.tableTitlePl") }}</th>
          <th scope="col">{{ $t("admin.menu.tableTitleEn") }}</th>
          <th scope="col">{{ $t("admin.menu.tablePath") }}</th>
          <th scope="col">{{ $t("admin.menu.tablePublished") }}</th>
          <th scope="col">{{ $t("admin.menu.tableVisibility") }}</th>
          <th scope="col">{{ $t("admin.menu.tableEdit") }}</th>
        </tr>
      </thead>
      <tbody class="">
        <tr v-for="(item, index) in state.menuList" :key="item">
          <th scope="row">{{ index + 1 }}</th>
          <td>{{ item.name_pl }}</td>
          <td>{{ item.name_en }}</td>
          <td>{{ item.route }}</td>
          <td>{{ item.published }}</td>
          <td>{{ item.user_only }}</td>
          <td>
            <font-awesome-icon icon="pen-to-square" />
          </td>
        </tr>
      </tbody>
    </table>
    <BasicButton :buttonText="$t('admin.saveChanges')" @click="saveChanges" />
  </div>
</template>

<style scoped lang="scss"></style>
