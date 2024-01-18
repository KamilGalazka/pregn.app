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
const isValidOldPassword = ref(true);
const isValidNewPassword = ref(true);
const isValidRepeatedNewPassword = ref(true);

const isOldPasswordVisible = ref(false);
const isNewPasswordVisible = ref(false);
const isRepeatedNewPasswordVisible = ref(false);

const changeDataSuccess = ref();
const isCorrectOldPassword = ref(true);

const getUserData = async () => {
  let response;

  try {
    response = await axios({
      method: "GET",
      url: routes.user.path,
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
  isCorrectOldPassword.value = true;
};

const deleteAccount = async () => {
  let response;

  try {
    response = await axios({
      method: "DELETE",
      url: routes.user.path,
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
    isCorrectOldPassword.value = false;
    console.log(error);
  }
};

const validateDataHandler = (isNewPassword) => {
  if (isNewPassword) {
    isValidOldPassword.value = useValidation.validatePassword(
      oldPassword.value
    );
    isValidNewPassword.value = useValidation.validatePassword(
      newPassword.value
    );
    isValidRepeatedNewPassword.value = useValidation.validateRepeatedPassword(
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
      isValidOldPassword.value &&
      isValidNewPassword.value &&
      isValidRepeatedNewPassword.value
    );
  }

  return isValidName.value && isValidLastname.value && isValidEmail.value;
};

const showOldPassword = () => {
  if (!oldPassword.value) return;

  isOldPasswordVisible.value = !isOldPasswordVisible.value;
};

const showNewPassword = () => {
  if (!newPassword.value) return;

  isNewPasswordVisible.value = !isNewPasswordVisible.value;
};

const showRepeatedNewPassword = () => {
  if (!repeatedNewPassword.value) return;

  isRepeatedNewPasswordVisible.value = !isRepeatedNewPasswordVisible.value;
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
        <div class="form-floating">
          <input
            type="text"
            :class="`form-control ${isValidName ? '' : 'is-invalid'}`"
            data-cy="input-name"
            id="inputName"
            :placeholder="$t('basic.namePlaceholder')"
            required
            v-model="name"
          />
          <label for="inputName">{{
            upperFirstLetter($t("basic.name"))
          }}</label>
          <div class="invalid-feedback" data-cy="invalid-field__name">
            {{ $t("error.incorrectField") }}
          </div>
        </div>
      </div>

      <div>
        <div class="form-floating">
          <input
            type="text"
            :class="`form-control ${isValidLastname ? '' : 'is-invalid'}`"
            data-cy="input-lastname"
            id="inputLastname"
            :placeholder="$t('basic.lastnamePlaceholder')"
            required
            v-model="lastname"
          />
          <label for="inputLastname">{{
            upperFirstLetter($t("basic.lastname"))
          }}</label>
          <div class="invalid-feedback" data-cy="invalid-field__lastname">
            {{ $t("error.incorrectField") }}
          </div>
        </div>
      </div>

      <div>
        <div class="form-floating">
          <input
            type="email"
            :class="`form-control ${isValidEmail ? '' : 'is-invalid'}`"
            data-cy="input-email"
            id="inputEmail"
            :placeholder="$t('basic.emailPlaceholder')"
            required
            v-model="email"
          />
          <label for="inputEmail">{{
            upperFirstLetter($t("basic.email"))
          }}</label>
          <div class="invalid-feedback" data-cy="invalid-field__email">
            {{ $t("error.incorrectEmail") }}
          </div>
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

      <div v-if="!isCorrectOldPassword" class="alert alert-danger">
        {{ $t("settings.wrongOldPassword") }}
      </div>

      <div class="input-group has-validation">
        <div class="form-floating form-floating__password">
          <input
            :type="isOldPasswordVisible ? 'text' : 'password'"
            :class="`form-control ${isValidOldPassword ? '' : 'is-invalid'}`"
            data-cy="input-password"
            id="inputOldPassword"
            :placeholder="$t('basic.oldPasswordPlaceholder')"
            required
            v-model="oldPassword"
          />
          <label for="inputOldPassword">{{
            upperFirstLetter($t("basic.oldPassword"))
          }}</label>
          <div class="invalid-feedback" data-cy="invalid-field__password">
            {{ $t("error.incorrectPassword") }}
          </div>
        </div>
        <span
          :class="`input-group-text ${isValidOldPassword ? '' : 'is-invalid'}`"
          @click="showOldPassword"
        >
          <font-awesome-icon v-if="!isOldPasswordVisible" icon="eye" />
          <font-awesome-icon v-else icon="eye-slash" />
        </span>
      </div>

      <div class="input-group has-validation">
        <div class="form-floating form-floating__password">
          <input
            :type="isNewPasswordVisible ? 'text' : 'password'"
            :class="`form-control ${isValidNewPassword ? '' : 'is-invalid'}`"
            data-cy="input-password"
            id="inputNewPassword"
            :placeholder="$t('basic.newPasswordPlaceholder')"
            required
            v-model="newPassword"
          />
          <label for="inputNewPassword">{{
            upperFirstLetter($t("basic.newPassword"))
          }}</label>
          <div class="invalid-feedback" data-cy="invalid-field__password">
            {{ $t("error.incorrectPassword") }}
          </div>
        </div>
        <span
          :class="`input-group-text ${isValidNewPassword ? '' : 'is-invalid'}`"
          @click="showNewPassword"
        >
          <font-awesome-icon v-if="!isNewPasswordVisible" icon="eye" />
          <font-awesome-icon v-else icon="eye-slash" />
        </span>
      </div>

      <div class="input-group has-validation">
        <div class="form-floating form-floating__password">
          <input
            :type="isRepeatedNewPasswordVisible ? 'text' : 'password'"
            :class="`form-control ${isValidNewPassword ? '' : 'is-invalid'}`"
            data-cy="input-password"
            id="inputRepeatNewPassword"
            :placeholder="$t('basic.repeatNewPasswordPlaceholder')"
            required
            v-model="repeatedNewPassword"
          />
          <label for="inputRepeatNewPassword">{{
            upperFirstLetter($t("basic.repeatNewPassword"))
          }}</label>
          <div class="invalid-feedback" data-cy="invalid-field__password">
            {{ $t("error.incorrectPassword") }}
          </div>
        </div>
        <span
          :class="`input-group-text ${
            isValidRepeatedNewPassword ? '' : 'is-invalid'
          }`"
          @click="showRepeatedNewPassword"
        >
          <font-awesome-icon v-if="!isRepeatedNewPasswordVisible" icon="eye" />
          <font-awesome-icon v-else icon="eye-slash" />
        </span>
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

  #inputOldPassword,
  #inputNewPassword,
  #inputRepeatNewPassword {
    border-right: none;
    border-bottom-right-radius: 0;
    border-top-right-radius: 0;
  }

  .form-floating__password {
    width: calc(100% - 44px);
  }

  .input-group-text {
    width: 45px;
    max-height: 58px;
    background: none;
    border-left: none;
    cursor: pointer;

    &.is-invalid {
      border-color: #dc3545;
    }
  }
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
