<script setup>
import BasicButton from "@/components/BasicButton.vue";

const items = [
  {
    name: "Kolor 1",
    value: "#7ea85a",
  },
  {
    name: "Kolor 2",
    value: "#5992a1",
  },
  {
    name: "Kolor 3",
    value: "#efda57",
  },
  {
    name: "Kolor 4",
    value: "#f1f1f1",
  },
  {
    name: "Kolor 5",
    value: "#727272",
  },
  {
    name: "Kolor 6",
    value: "#E2E2E2",
  },
];

const saveChanges = () => {
  console.log("todo");
};
</script>

<template>
  <div class="col-2 m-auto">
    <ul class="admin__actions--list">
      <li
        v-for="(item, index) in items"
        :key="item"
        class="admin__actions--item"
      >
        <span class="item-key">{{ item.name }}</span>
        <input
          :id="`color${index}`"
          type="color"
          :value="item.value"
          class="item-value"
        />
      </li>
    </ul>
    <BasicButton :buttonText="$t('admin.saveChanges')" @click="saveChanges" />
  </div>
</template>

<style scoped lang="scss">
.admin {
  &__actions {
    &--list {
      list-style: none;
      padding: 0;
    }

    &--item {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin: 16px 0;
    }
  }
}
</style>
