import { createApp } from "vue";
import { createPinia } from "pinia";
import { createI18n } from "vue-i18n";
import piniaPluginPersistedstate from "pinia-plugin-persistedstate";
import App from "./App.vue";
import router from "./router";
import { library } from "@fortawesome/fontawesome-svg-core";
import {
  faPenToSquare,
  faGears,
  faUser,
  faRightFromBracket,
} from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";

import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap";

import pl from "@/locales/pl.json";
import en from "@/locales/en.json";

const i18n = createI18n({
  locale: "pl",
  fallbackLocale: "pl",
  messages: { pl, en },
});

library.add(faPenToSquare, faGears, faUser, faRightFromBracket);

const pinia = createPinia();
pinia.use(piniaPluginPersistedstate);

const app = createApp(App);

app.use(pinia);
app.use(router);
app.use(i18n);
app.component("font-awesome-icon", FontAwesomeIcon);

app.mount("#app");
