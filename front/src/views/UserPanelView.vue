<script setup>
import axios from "axios";
import routes from "@/helpers/routes";
import router from "@/router";
import { useStore } from "@/stores/store";
import BasicButton from "@/components/BasicButton.vue";
import { onMounted, ref } from "vue";
import upperFirstLetter from "@/helpers/upperFirstLetter";
import * as useValidation from "@/composables/useValidation";

const store = useStore();
const userData = ref({});

const email = ref();
const name = ref();
const lastname = ref();
const oldPassword = ref();
const newPassword = ref();
const repeatedNewPassword = ref();

const isValidName = ref(true);
const isValidLastname = ref(true);
const isValidEmail = ref(true);
const isCorrectOldPassword = ref(true);
const isCorrectNewPassword = ref(true);
const isCorrectRepeatedNewPassword = ref(true);

const changeDataSuccess = ref();

const getUserData = async () => {
  let response;

  try {
    response = await axios({
      method: "GET",
      url: routes.user.getUserData,
      headers: {
        Authorization: `Bearer ${store.userToken}`,
      },
    });
  } catch (error) {
    console.log(error);
  }

  if (response.status === 200) {
    userData.value = response.data.response;
    fillValueForEditForm();
  }
};

const fillValueForEditForm = () => {
  email.value = userData.value.email;
  name.value = userData.value.name;
  lastname.value = userData.value.lastname;
};

const clearChangePasswordForm = () => {
  newPassword.value = "";
  oldPassword.value = "";
  repeatedNewPassword.value = "";
};

const deleteAccount = async () => {
  let response;

  try {
    response = await axios({
      method: "DELETE",
      url: routes.user.delete,
      headers: {
        Authorization: `Bearer ${store.userToken}`,
      },
    });
  } catch (error) {
    console.log(error);
  }

  if (response?.status === 200) {
    store.setUserStatus({
      isLogged: false,
      isAdmin: false,
      token: "",
    });

    await router.push("/");
  }
};

const changeUserData = async () => {
  if (!checkIfAllFieldsAreValid(false)) return;

  try {
    await axios({
      method: "PATCH",
      url: routes.user.changeUserData,
      headers: {
        Authorization: `Bearer ${store.userToken}`,
      },
      data: {
        name: name.value,
        lastname: lastname.value,
        email: email.value,
      },
    });

    changeDataSuccess.value = true;
  } catch (error) {
    console.log(error);
  }
};

const changeUserPassword = async () => {
  if (!checkIfAllFieldsAreValid(true)) return;

  try {
    await axios({
      method: "PATCH",
      url: routes.user.changeUserPassword,
      headers: {
        Authorization: `Bearer ${store.userToken}`,
      },
      data: {
        oldPassword: oldPassword.value,
        newPassword: newPassword.value,
      },
    });

    changeDataSuccess.value = true;
    clearChangePasswordForm();
  } catch (error) {
    console.log(error);
  }
};

const validateDataHandler = (isNewPassword) => {
  if (isNewPassword) {
    isCorrectOldPassword.value = useValidation.validatePassword(
      oldPassword.value
    );
    isCorrectNewPassword.value = useValidation.validatePassword(
      newPassword.value
    );
    isCorrectRepeatedNewPassword.value = useValidation.validateRepeatedPassword(
      newPassword.value,
      repeatedNewPassword.value
    );
  } else {
    isValidName.value = useValidation.validateName(name.value);
    isValidLastname.value = useValidation.validateLastname(lastname.value);
    isValidEmail.value = useValidation.validateEmail(email.value);
  }
};

const checkIfAllFieldsAreValid = (isNewPassword) => {
  validateDataHandler(isNewPassword);

  if (isNewPassword) {
    return (
      isCorrectOldPassword.value &&
      isCorrectNewPassword.value &&
      isCorrectRepeatedNewPassword.value
    );
  }

  return isValidName.value && isValidLastname.value && isValidEmail.value;
};

onMounted(() => {
  getUserData();
});
</script>

<template>
  <div>
    <h1>{{ $t("settings.header") }}</h1>
    <div v-if="changeDataSuccess" class="alert alert-success">
      {{ $t("settings.dataChangedText") }}
    </div>
    <form class="row" @submit.prevent="changeUserData" novalidate>
      <h3>{{ $t("settings.dataSectionHeader") }}</h3>
      <div>
        <label for="inputName" class="form-label">{{
          upperFirstLetter($t("basic.name"))
        }}</label>
        <input
          type="text"
          class="form-control"
          data-cy="input-name"
          id="inputName"
          :placeholder="$t('basic.namePlaceholder')"
          required
          v-model="name"
        />
        <div v-if="!isValidName" class="invalid-field text-danger">
          {{ $t("error.incorrectField") }}
        </div>
      </div>

      <div>
        <label for="inputLastname" class="form-label">{{
          upperFirstLetter($t("basic.lastname"))
        }}</label>
        <input
          type="text"
          class="form-control"
          data-cy="input-lastname"
          id="inputLastname"
          :placeholder="$t('basic.lastnamePlaceholder')"
          required
          v-model="lastname"
        />
        <div v-if="!isValidLastname" class="invalid-field text-danger">
          {{ $t("error.incorrectField") }}
        </div>
      </div>

      <div>
        <label for="inputEmail" class="form-label">{{
          upperFirstLetter($t("basic.email"))
        }}</label>
        <input
          type="email"
          class="form-control"
          data-cy="input-email"
          id="inputEmail"
          :placeholder="$t('basic.emailPlaceholder')"
          required
          v-model="email"
        />
        <div v-if="!isValidEmail" class="invalid-field text-danger">
          {{ $t("error.incorrectEmail") }}
        </div>
      </div>

      <div id="submitButton" class="col-6">
        <BasicButton
          :buttonText="$t('settings.changeUserDataButton')"
          data-cy="register-button"
        />
      </div>
    </form>

    <form class="row" @submit.prevent="changeUserPassword" novalidate>
      <h3>{{ $t("settings.passwordSectionHeader") }}</h3>

      <div>
        <label for="inputOldPassword" class="form-label">{{
          upperFirstLetter($t("basic.oldPassword"))
        }}</label>
        <input
          type="password"
          class="form-control"
          data-cy="input-password"
          id="inputOldPassword"
          :placeholder="$t('basic.oldPasswordPlaceholder')"
          required
          v-model="oldPassword"
        />
        <div v-if="!isCorrectOldPassword" class="invalid-field text-danger">
          {{ $t("error.incorrectPassword") }}
        </div>
      </div>

      <div>
        <label for="inputNewPassword" class="form-label">{{
          upperFirstLetter($t("basic.newPassword"))
        }}</label>
        <input
          type="password"
          class="form-control"
          data-cy="input-password"
          id="inputNewPassword"
          :placeholder="$t('basic.newPasswordPlaceholder')"
          required
          v-model="newPassword"
        />
        <div v-if="!isCorrectNewPassword" class="invalid-field text-danger">
          {{ $t("error.incorrectPassword") }}
        </div>
      </div>

      <div>
        <label for="inputRepeatNewPassword" class="form-label">{{
          upperFirstLetter($t("basic.repeatNewPassword"))
        }}</label>
        <input
          type="password"
          class="form-control"
          data-cy="input-repeat-password"
          id="inputRepeatNewPassword"
          :placeholder="$t('basic.repeatNewPasswordPlaceholder')"
          required
          v-model="repeatedNewPassword"
        />
        <div
          v-if="!isCorrectRepeatedNewPassword"
          class="invalid-field text-danger"
        >
          {{ $t("error.incorrectRepeatedPassword") }}
        </div>
      </div>

      <div id="submitButton" class="col-6">
        <BasicButton
          :buttonText="$t('settings.changeUserDataButton')"
          data-cy="register-button"
        />
      </div>
    </form>
    <div class="settings__delete-account row">
      <h3>{{ $t("settings.deleteAccountHeader") }}</h3>
      <p class="my-3">{{ $t("settings.deleteAccountInformation") }}</p>
      <BasicButton
        :buttonText="$t('settings.deleteAccountButton')"
        @click="deleteAccount"
      />
    </div>
  </div>
</template>

<style scoped lang="scss">
form {
  gap: 20px;
  max-width: 500px;
  margin: 50px auto 0;
  padding: 20px;
}

.settings__delete-account {
  max-width: 500px;
  margin: 50px auto 0;
  padding: 20px;

  button {
    margin-left: 12px;
    width: 122px;
  }
}
</style>
