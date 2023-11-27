import { defineStore } from "pinia";
import { ref } from "vue";

export const useStore = defineStore(
  "store",
  () => {
    //global config
    const passwordLength = 6;

    const isOpeningPageClosed = ref(false);
    const isUserLogged = ref(false);
    const isUserAdmin = ref(false);

    function setOpeningPageAsOpened() {
      isOpeningPageClosed.value = true;
    }

    function setUserStatus(status) {
      const { isLogged, isAdmin } = status;

      isUserLogged.value = isLogged;
      isUserAdmin.value = isAdmin;
    }

    return {
      passwordLength,
      isOpeningPageClosed,
      isUserLogged,
      isUserAdmin,
      setOpeningPageAsOpened,
      setUserStatus,
    };
  },
  {
    persist: true,
  }
);
