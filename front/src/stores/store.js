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
    const userToken = ref();

    function setOpeningPageAsOpened() {
      isOpeningPageClosed.value = true;
    }

    function setUserStatus(status) {
      const { isLogged, isAdmin, token } = status;

      isUserLogged.value = isLogged;
      isUserAdmin.value = isAdmin;
      userToken.value = token;
    }

    return {
      passwordLength,
      isOpeningPageClosed,
      isUserLogged,
      isUserAdmin,
      userToken,
      setOpeningPageAsOpened,
      setUserStatus,
    };
  },
  {
    persist: true,
  }
);
