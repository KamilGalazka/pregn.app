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
    url: routes.navigation.getNavigation,
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
          <th scope="col">Nazwa kategorii PL</th>
          <th scope="col">Nazwa kategorii EN</th>
          <th scope="col">Ścieżka</th>
          <th scope="col">Publikacja</th>
          <th scope="col">Widoczność</th>
          <th scope="col">Edycja</th>
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
