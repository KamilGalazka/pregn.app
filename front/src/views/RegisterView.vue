<script setup>
import axios from "axios";
import BasicButton from "@/components/BasicButton.vue";
import upperFirstLetter from "../helpers/upperFirstLetter";
import { useStore } from "@/stores/store";
import { ref } from "vue";
import router from "@/router";
import routes from "@/helpers/routes";

let email = ref();
let password = ref();
let name = ref();
let lastname = ref();
let repeatedPassword = ref();
let terms = ref();
let registrationSuccess = ref(false);
let isValidName = ref(true);
let isValidLastname = ref(true);
let isValidEmail = ref(true);
let isCorrectPassword = ref(true);
let isCorrectRepeatedPassword = ref(true);
let isTermsChecked = ref(true);
let isRegistrationSuccess = ref(true);
let isUserExists = ref(false);
const store = useStore();

const validateEmail = () => {
  isValidEmail.value = /^\S+@\S+\.\S+$/.test(email.value);
};

const validatePassword = () => {
  if (password.value)
    isCorrectPassword.value = password.value.length >= store.passwordLength;
  else isCorrectPassword.value = false;
};

const validateRepeatedPassword = () => {
  if (repeatedPassword.value && repeatedPassword.value === password.value)
    isCorrectRepeatedPassword.value = true;
  else isCorrectRepeatedPassword.value = false;
};

const validateNameAndLastname = () => {
  isValidName.value = name.value?.length || false;
  isValidLastname.value = lastname.value?.length || false;
};

const validateTerms = () => {
  isTermsChecked.value = terms?.value || false;
};

const validateDataHandler = () => {
  validateNameAndLastname();
  validateEmail();
  validatePassword();
  validateRepeatedPassword();
  validateTerms();
};

const submitHandler = async () => {
  validateDataHandler();

  if (
    !isValidName.value ||
    !isValidLastname.value ||
    !isValidEmail.value ||
    !isCorrectPassword.value ||
    !isCorrectRepeatedPassword.value ||
    !isTermsChecked.value
  )
    return;

  try {
    await axios({
      method: "POST",
      url: routes.user.register,
      data: {
        name: name.value,
        lastname: lastname.value,
        email: email.value,
        password: password.value,
      },
    });

    registrationSuccess.value = true;

    setTimeout(() => router.push("/login"), 3000);
  } catch (error) {
    error.response.status === 409
      ? (isUserExists.value = true)
      : (isRegistrationSuccess.value = false);
  }
};
</script>

<template>
  <form class="row g-3" @submit.prevent="submitHandler" novalidate>
    <h1>{{ $t("registration.header") }}</h1>

    <div v-if="!isRegistrationSuccess" class="alert alert-danger">
      {{ $t("error.global") }}
    </div>

    <div v-if="isUserExists" class="alert alert-danger">
      {{ $t("error.userAlreadyExists") }}
    </div>

    <div v-if="registrationSuccess" class="alert alert-success">
      {{ $t("registration.success") }}
    </div>

    <div>
      <label for="inputName" class="form-label">{{
        upperFirstLetter($t("basic.name"))
      }}</label>
      <input
        type="text"
        class="form-control"
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
        id="inputEmail"
        :placeholder="$t('basic.emailPlaceholder')"
        required
        v-model="email"
      />
      <div v-if="!isValidEmail" class="invalid-field text-danger">
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
      <div v-if="!isCorrectPassword" class="invalid-field text-danger">
        {{ $t("error.incorrectPassword") }}
      </div>
    </div>

    <div>
      <label for="inputRepeatPassword" class="form-label">{{
        upperFirstLetter($t("basic.repeatPassword"))
      }}</label>
      <input
        type="password"
        class="form-control"
        id="inputRepeatPassword"
        :placeholder="$t('basic.repeatPasswordPlaceholder')"
        required
        v-model="repeatedPassword"
      />
      <div v-if="!isCorrectRepeatedPassword" class="invalid-field text-danger">
        {{ $t("error.incorrectRepeatedPassword") }}
      </div>
    </div>

    <div>
      <div class="d-flex align-items-center gap-1">
        <input
          class="form-check-input"
          type="checkbox"
          id="inputTerms"
          required
          v-model="terms"
        />
        <label class="form-check-label" for="inputTerms">
          {{ $t("registration.terms") }}
        </label>
      </div>
      <div v-if="!isTermsChecked" class="invalid-field text-danger">
        {{ $t("error.termsNotChecked") }}
      </div>
    </div>

    <div id="submitButton" class="col-6">
      <BasicButton :buttonText="$t('registration.button')" />
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
