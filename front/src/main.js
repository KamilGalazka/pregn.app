import { createApp } from "vue";
import { createPinia } from "pinia";
import { createI18n } from "vue-i18n";
import App from "./App.vue";
import router from "./router";

import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap";

import pl from "@/locales/pl.json";
import en from "@/locales/en.json";

const i18n = createI18n({
  locale: "pl",
  fallbackLocale: "pl",
  messages: { pl, en },
});

const pinia = createPinia();
const app = createApp(App);

app.use(pinia);
app.use(router);
app.use(i18n);

app.mount("#app");
