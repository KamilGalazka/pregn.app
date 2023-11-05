<template>
  <h1>{{ upperFirstLetter($t("headers.registration")) }}</h1>
  <form
    class="row g-3 align-self-center"
    @submit.prevent="submitHandler"
    novalidate
  >
    <div class="col-6">
      <label for="inputFirstName" class="form-label">First Name</label>
      <input
        type="text"
        class="form-control"
        id="inputFirstName"
        placeholder="John"
        required
        v-model="firstName"
        @blur="validateEachField"
      />
      <div class="invalid-feedback" v-if="v$.firstName.$error">
        {{ v$.firstName.$errors[0].$message }}
      </div>
    </div>
    <div class="col-6">
      <label for="inputLastName" class="form-label">Last Name</label>
      <input
        type="text"
        class="form-control"
        id="inputLastName"
        placeholder="Smith"
        required
        v-model="lastName"
        @blur="validateEachField"
      />
      <div class="invalid-feedback" v-if="v$.lastName.$error">
        {{ v$.lastName.$errors[0].$message }}
      </div>
    </div>

    <div class="col-6">
      <label for="inputEmail" class="form-label">Email</label>
      <input
        type="email"
        class="form-control"
        id="inputEmail"
        placeholder="example@ecample.com"
        required
        v-model="email"
        @blur="validateEachField"
      />
      <div class="invalid-feedback" v-if="v$.email.$error">
        {{ v$.email.$errors[0].$message }}
      </div>
    </div>

    <div class="col-6">
      <label for="inputPassword" class="form-label">Password</label>
      <input
        type="password"
        class="form-control"
        id="inputPassword"
        placeholder="password"
        required
        v-model="password"
        @blur="validateEachField"
      />
      <div class="invalid-feedback" v-if="v$.password.$error">
        {{ v$.password.$errors[0].$message }}
      </div>
    </div>
    <div class="col-6">
      <label for="inputConfirmPassword" class="form-label"
        >Confirm Password</label
      >
      <input
        type="password"
        class="form-control"
        id="inputConfirmPassword"
        placeholder="confirm your password"
        required
        v-model="confirmPassword"
        @blur="validateEachField"
      />
      <div class="invalid-feedback" v-if="v$.confirmPassword.$error">
        {{ v$.confirmPassword.$errors[0].$message }}
      </div>
    </div>

    <div class="col-6">
      <div class="form-check">
        <input
          class="form-check-input"
          type="checkbox"
          id="inputTerms"
          v-model="terms"
          @blur="validateEachField"
        />
        <label class="form-check-label" for="inputTerms">
          Please confirm that you agree to our
          <router-link id="termsLink" to="/temp" style="color: inherit">
            terms & conditions
          </router-link>
        </label>
      </div>
    </div>
    <div id="submitButton" class="col-6">
      <button type="submit" class="btn btn-dark col-12">
        {{ upperFirstLetter($t("registration.button")) }}
      </button>
    </div>
  </form>
</template>

<script>
import useValidate from "@vuelidate/core";
import {
  required,
  email,
  minLength,
  helpers,
  sameAs,
} from "@vuelidate/validators";
import axios from "axios";
import upperFirstLetter from "../helpers/upperFirstLetter";

export default {
  name: "RegistrationPage",
  data() {
    return {
      v$: useValidate(),
      firstName: "",
      lastName: "",
      email: "",
      password: "",
      confirmPassword: "",
      terms: false,
    };
  },
  validations() {
    return {
      firstName: {
        required,
        min: minLength(2),
      },
      lastName: {
        required,
        min: minLength(2),
      },
      email: {
        required,
        min: minLength(6),
        email,
      },
      password: {
        required,
        min: minLength(6),
      },
      confirmPassword: {
        required,
        min: minLength(6),
        isConfirmed: helpers.withMessage(
          "Confirm password must be the same as the password!",
          (confirmPassword) => confirmPassword === this.password
        ),
      },
      terms: {
        sameAs: sameAs(true),
      },
    };
  },
  methods: {
    upperFirstLetter,
    validateEachField(e) {
      //  Generate code for validate field
      let codeToRun = "this.v$.";
      codeToRun += e.target.id.slice(5).charAt(0).toLowerCase();
      codeToRun += e.target.id.slice(6);
      codeToRun += ".$touch()";

      //  Validate field
      eval(codeToRun);

      //  Generate code for checking errors
      codeToRun = codeToRun.slice(0, codeToRun.length - 9);
      codeToRun += ".$error";

      //  Get input and add valid/invalid class for it
      const input = document.getElementById(e.target.id);
      if (eval(codeToRun)) {
        input.classList.remove("is-valid");
        input.classList.add("is-invalid");
      } else {
        input.classList.remove("is-invalid");
        input.classList.add("is-valid");
      }
    },
    validateAllFields() {
      //  Check form
      this.v$.$touch();

      let isValid = true;

      //  Get all inputs
      document.querySelectorAll("input").forEach((input) => {
        let codeToRun = "this.v$.";
        //  Get input id
        codeToRun += input.id.slice(5).charAt(0).toLowerCase();
        codeToRun += input.id.slice(6);

        codeToRun += ".$error";

        //  Add valid/invalid class for inputs
        if (eval(codeToRun)) {
          input.classList.remove("is-valid");
          input.classList.add("is-invalid");
          isValid = false;
        } else {
          input.classList.remove("is-invalid");
          input.classList.add("is-valid");
        }
      });

      return isValid;
    },
    async submitHandler() {
      if (this.validateAllFields()) {
        try {
          const result = await axios.post(
            "http://localhost:3000/api/user/create",
            {
              name: this.firstName,
              lastname: this.lastName,
              email: this.email,
              password: this.password,
            }
          );

          console.log(result);
        } catch (err) {
          alert(err.message);
        }
      } else {
        alert("Something went wrong! Please try again");
      }
    },
  },
};
</script>

<style scoped lang="scss">
h1 {
  margin-top: 50px;
  text-align: center;
}

form {
  display: flex;
  flex-direction: column;
  align-items: center;
}

#title {
  padding-top: 0.5em;
  padding-bottom: 1em;
}

#submitButton {
  padding-top: 2em;
}

#termsLink {
  font-weight: bold;
}
</style>
