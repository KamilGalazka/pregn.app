<script setup>
import axios from "axios";
import BasicButton from "@/components/BasicButton.vue";
import upperFirstLetter from "../helpers/upperFirstLetter";
import { useStore } from "@/stores/store";
import { ref } from "vue";
import router from "@/router";
import routes from "@/helpers/routes";
import { validateEmail, validatePassword } from "@/composables/useValidation";

const email = ref();
const password = ref();
const isValidEmail = ref(true);
const isCorrectPassword = ref(true);
const isLoginSuccess = ref(true);
const isPasswordWrong = ref(false);
const store = useStore();

const checkIfAllFieldsAreValid = () => {
  isValidEmail.value = validateEmail(email.value);
  isCorrectPassword.value = validatePassword(password.value);

  return isValidEmail.value && isCorrectPassword.value;
};

const submitHandler = async () => {
  if (!checkIfAllFieldsAreValid()) return;

  try {
    const response = await axios({
      method: "POST",
      url: routes.user.login,
      data: {
        email: email.value,
        password: password.value,
      },
    });

    store.setUserStatus({
      isLogged: true,
      isAdmin: response.data.role === "admin",
      token: response.data.token,
    });

    await router.push("/");
  } catch (error) {
    error.response.status === 401
      ? (isPasswordWrong.value = true)
      : (isLoginSuccess.value = false);
  }
};
</script>

<template>
  <form class="row" @submit.prevent="submitHandler" novalidate>
    <h1>{{ $t("login.header") }}</h1>

    <div v-if="!isLoginSuccess" class="alert alert-danger">
      {{ $t("error.global") }}
    </div>

    <div v-if="isPasswordWrong" class="alert alert-danger">
      {{ $t("error.wrongPasswordOrEmail") }}
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
      <div
        v-if="!isValidEmail"
        class="invalid-field text-danger"
        data-cy="invalid-field__email"
      >
        {{ $t("error.incorrectEmail") }}
      </div>
    </div>

    <div>
      <label for="inputPassword" class="form-label">{{
        upperFirstLetter($t("basic.password"))
      }}</label>
      <input
        type="password"
        class="form-control"
        data-cy="input-password"
        id="inputPassword"
        :placeholder="$t('basic.passwordPlaceholder')"
        required
        v-model="password"
      />
      <div
        v-if="!isCorrectPassword"
        class="invalid-field text-danger"
        data-cy="invalid-field__password"
      >
        {{ $t("error.incorrectPassword") }}
      </div>
    </div>
    <div>
      <span style="margin-right: 4px">{{ $t("login.noAccountPrefix") }}</span>
      <RouterLink to="/register" data-cy="register-account__button">{{
        $t("login.noAccountPostfix")
      }}</RouterLink>
    </div>
    <div id="submitButton" class="col-6" data-cy="login-button">
      <BasicButton :buttonText="$t('login.button')" />
    </div>
  </form>
</template>

<style scoped lang="scss">
form {
  gap: 20px;
  max-width: 500px;
  margin: 50px auto 0;
  padding: 20px;
}
</style>
