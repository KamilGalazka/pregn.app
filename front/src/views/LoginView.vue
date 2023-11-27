<script setup>
import axios from "axios";
import BasicButton from "@/components/BasicButton.vue";
import upperFirstLetter from "../helpers/upperFirstLetter";
import { useStore } from "@/stores/store";
import { ref } from "vue";
import router from "@/router";

let email = ref();
let password = ref();
let isValidEmail = ref(true);
let isCorrectPassword = ref(true);
let isLoginSuccess = ref(true);
let isPasswordWrong = ref(false);
const store = useStore();

const validateEmail = () => {
  isValidEmail.value = /^\S+@\S+\.\S+$/.test(email.value);
};

const validatePassword = () => {
  if (password.value)
    isCorrectPassword.value = password.value.length >= store.passwordLength;
  else isCorrectPassword.value = false;
};

const submitHandler = async () => {
  validateEmail();
  validatePassword();

  if (!isValidEmail.value || !isCorrectPassword.value) return;

  try {
    const response = await axios({
      method: "POST",
      url: "http://localhost:3000/api/user/login",
      data: {
        email: email.value,
        password: password.value,
      },
    });

    store.setUserStatus({
      isLogged: true,
      isAdmin: response.data.role === "admin",
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
  <form class="row g-3" @submit.prevent="submitHandler" novalidate>
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
        id="inputEmail"
        :placeholder="$t('basic.emailPlaceholder')"
        required
        v-model="email"
      />
      <div v-if="!isValidEmail" class="invalid-field">
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
        id="inputPassword"
        :placeholder="$t('basic.passwordPlaceholder')"
        required
        v-model="password"
      />
      <div v-if="!isCorrectPassword" class="invalid-field">
        {{ $t("error.incorrectPassword") }}
      </div>
    </div>
    <div>
      <RouterLink to="/register">{{ $t("login.noAccount") }}</RouterLink>
    </div>
    <div id="submitButton" class="col-6">
      <BasicButton :buttonText="$t('login.button')" />
    </div>
  </form>
</template>

<style scoped lang="scss">
form {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  gap: 20px;
  max-width: 500px;
  margin: 100px auto 0;
  text-align: left;
  padding: 20px;
}

#submitButton {
  padding-top: 2em;
}
</style>
