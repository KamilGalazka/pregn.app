<script setup>
import axios from "axios";
import BasicButton from "@/components/BasicButton.vue";
import upperFirstLetter from "../helpers/upperFirstLetter";
import { ref } from "vue";
import router from "@/router";
import routes from "@/helpers/routes";
import "@/composables/useValidation";
import * as useValidation from "@/composables/useValidation";

const email = ref();
const password = ref();
const name = ref();
const lastname = ref();
const repeatedPassword = ref();
const terms = ref();
const registrationSuccess = ref(false);
const isValidName = ref(true);
const isValidLastname = ref(true);
const isValidEmail = ref(true);
const isCorrectPassword = ref(true);
const isCorrectRepeatedPassword = ref(true);
const isTermsChecked = ref(true);
const isRegistrationSuccess = ref(true);
const isUserExists = ref(false);

const validateDataHandler = () => {
  isValidEmail.value = useValidation.validateEmail(email.value);
  isCorrectPassword.value = useValidation.validatePassword(password.value);
  isCorrectRepeatedPassword.value = useValidation.validateRepeatedPassword(
    password.value,
    repeatedPassword.value
  );
  isValidName.value = useValidation.validateName(name.value);
  isValidLastname.value = useValidation.validateLastname(lastname.value);
  isTermsChecked.value = useValidation.validateTerms(terms.value);
};

const checkIfAllFieldsAreValid = () => {
  validateDataHandler();

  return (
    isValidName.value &&
    isValidLastname.value &&
    isValidEmail.value &&
    isCorrectPassword.value &&
    isCorrectRepeatedPassword.value &&
    isTermsChecked.value
  );
};

const submitHandler = async () => {
  if (!checkIfAllFieldsAreValid()) return;

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
  <form class="row" @submit.prevent="submitHandler" novalidate>
    <h1>{{ $t("registration.header") }}</h1>

    <div v-if="!isRegistrationSuccess" class="alert alert-danger">
      {{ $t("error.global") }}
    </div>

    <div v-if="isUserExists" class="alert alert-danger">
      {{ $t("error.userAlreadyExists") }}
    </div>

    <div
      v-if="registrationSuccess"
      class="alert alert-success"
      data-cy="registration-successful-alert"
    >
      {{ $t("registration.success") }}
    </div>

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
        data-cy="input-repeat-password"
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
          type="checkbox"
          class="form-check-input"
          data-cy="checkbox-terms"
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
      <BasicButton
        :buttonText="$t('registration.button')"
        data-cy="register-button"
      />
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
