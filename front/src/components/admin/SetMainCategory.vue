<script setup>
import axios from "axios";
import { reactive } from "vue";
import BasicButton from "@/components/BasicButton.vue";

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

const saveChanges = () => {
  console.log("todo");
};
</script>

<template>
  <div class="wrapper col-lg-8 mx-auto">
    <table class="table table-striped">
      <thead>
        <tr>
          <th scope="col">#</th>
          <th scope="col">Nazwa kategorii</th>
          <th scope="col">Ścieżka</th>
          <th scope="col">Edycja</th>
        </tr>
      </thead>
      <tbody class="">
        <tr v-for="(item, index) in state.menuList" :key="item">
          <th scope="row">{{ index + 1 }}</th>
          <td>{{ item.name }}</td>
          <td>{{ item.route }}</td>
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
