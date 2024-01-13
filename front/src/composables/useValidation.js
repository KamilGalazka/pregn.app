import { useStore } from "@/stores/store";

const validateEmail = (email) => {
  return /^\S+@\S+\.\S+$/.test(email);
};

const validatePassword = (password) => {
  const store = useStore();

  if (!password) return false;

  return password.length >= store.passwordLength;
};

const validateRepeatedPassword = (password, repeatedPassword) => {
  return repeatedPassword && repeatedPassword === password;
};

const validateName = (name) => {
  if (!name) return false;

  return !!name.length;
};

const validateLastname = (lastname) => {
  if (!lastname) return false;

  return !!lastname.length;
};

const validateTerms = (terms) => {
  if (!terms) return false;

  return terms;
};

export {
  validateEmail,
  validatePassword,
  validateRepeatedPassword,
  validateName,
  validateLastname,
  validateTerms,
};
