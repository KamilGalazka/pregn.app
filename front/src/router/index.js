import { createRouter, createWebHistory } from "vue-router";
import HomeView from "@/views/HomeView.vue";

const routes = [
  {
    path: "/",
    name: "home",
    component: HomeView,
  },
  {
    path: "/about",
    name: "about",
    component: () =>
      import(/* webpackChunkName: "about" */ "../views/AboutView.vue"),
  },
  {
    path: "/health",
    name: "health",
    component: () =>
      import(/* webpackChunkName: "health" */ "../views/HealthView.vue"),
  },
  {
    path: "/:articleCategory/:id",
    name: "article",
    component: () =>
      import(
        /* webpackChunkName: "article" */ "../components/article/ArticleCardPage.vue"
      ),
    props: true,
  },
  {
    path: "/layette",
    name: "layette",
    component: () =>
      import(/* webpackChunkName: "layette" */ "../views/LayetteView.vue"),
  },
  {
    path: "/register",
    name: "register",
    component: () =>
      import(/* webpackChunkName: "register" */ "../views/RegisterView.vue"),
  },
  {
    path: "/login",
    name: "login",
    component: () =>
      import(/* webpackChunkName: "login" */ "../views/LoginView.vue"),
  },
  {
    path: "/stages",
    name: "stages",
    component: () =>
      import(
        /* webpackChunkName: "stages" */ "../views/StagesOfPregnancyView.vue"
      ),
  },
  {
    path: "/admin",
    name: "admin",
    component: () =>
      import(/* webpackChunkName: "admin" */ "../views/AdminView.vue"),
  },
  {
    path: "/calendar",
    name: "calendar",
    component: () =>
      import(/* webpackChunkName: "calendar" */ "../views/CalendarView.vue"),
  },
  {
    path: "/settings",
    name: "settings",
    component: () =>
      import(/* webpackChunkName: "settings" */ "../views/UserPanelView.vue"),
  },
  {
    path: "/images",
    name: "images",
    component: () =>
      import(/* webpackChunkName: "images" */ "../views/UserImagesView.vue"),
  },
  {
    path: "/terms",
    name: "terms",
    component: () =>
      import(/* webpackChunkName: "terms" */ "../components/BasicPage.vue"),
    props: { pageType: "terms" },
  },
  {
    path: "/:pathMatch(.*)*",
    name: "error",
    component: () =>
      import(/* webpackChunkName: "admin" */ "../views/ErrorView.vue"),
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

export default router;
