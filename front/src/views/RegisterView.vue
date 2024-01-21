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
const isPasswordVisible = ref(false);
const isRepeatedPasswordVisible = ref(false);

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
      url: routes.user.path,
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

const showPassword = () => {
  if (!password.value) return;

  isPasswordVisible.value = !isPasswordVisible.value;
};

const showRepeatedPassword = () => {
  if (!repeatedPassword.value) return;

  isRepeatedPasswordVisible.value = !isRepeatedPasswordVisible.value;
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
        <label for="inputName">{{ upperFirstLetter($t("basic.name")) }}</label>
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

    <div class="input-group has-validation">
      <div class="form-floating form-floating__password">
        <input
          :type="isPasswordVisible ? 'text' : 'password'"
          :class="`form-control ${isCorrectPassword ? '' : 'is-invalid'}`"
          data-cy="input-password"
          id="inputPassword"
          :placeholder="$t('basic.passwordPlaceholder')"
          required
          v-model="password"
        />
        <label for="inputPassword">{{
          upperFirstLetter($t("basic.password"))
        }}</label>
        <div class="invalid-feedback" data-cy="invalid-field__password">
          {{ $t("error.incorrectPassword") }}
        </div>
      </div>
      <span
        :class="`input-group-text ${isCorrectPassword ? '' : 'is-invalid'}`"
        @click="showPassword"
      >
        <font-awesome-icon v-if="!isPasswordVisible" icon="eye" />
        <font-awesome-icon v-else icon="eye-slash" />
      </span>
    </div>

    <div class="input-group has-validation">
      <div class="form-floating form-floating__password">
        <input
          :type="isRepeatedPasswordVisible ? 'text' : 'password'"
          :class="`form-control ${
            isCorrectRepeatedPassword ? '' : 'is-invalid'
          }`"
          data-cy="input-repeat-password"
          id="inputRepeatPassword"
          :placeholder="$t('basic.repeatPasswordPlaceholder')"
          required
          v-model="repeatedPassword"
        />
        <label for="inputRepeatPassword">{{
          upperFirstLetter($t("basic.repeatPassword"))
        }}</label>
        <div
          class="invalid-feedback"
          data-cy="invalid-field__repeated-password"
        >
          {{ $t("error.incorrectRepeatedPassword") }}
        </div>
      </div>
      <span
        :class="`input-group-text ${
          isCorrectRepeatedPassword ? '' : 'is-invalid'
        }`"
        @click="showRepeatedPassword"
      >
        <font-awesome-icon v-if="!isRepeatedPasswordVisible" icon="eye" />
        <font-awesome-icon v-else icon="eye-slash" />
      </span>
    </div>

    <div>
      <div class="form-check">
        <input
          type="checkbox"
          :class="`form-check-input ${isTermsChecked ? '' : 'is-invalid'}`"
          data-cy="checkbox-terms"
          id="inputTerms"
          required
          v-model="terms"
        />
        <label class="form-check-label" for="inputTerms">
          <RouterLink to="/terms" target="_blank">
            {{ $t("registration.terms") }}
          </RouterLink>
        </label>
        <div class="invalid-feedback" data-cy="invalid-field__terms">
          {{ $t("error.termsNotChecked") }}
        </div>
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

  #inputPassword,
  #inputRepeatPassword {
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
</style>
