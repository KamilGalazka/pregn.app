const prefix = "http://localhost:3000";

const routes = Object.freeze({
  user: {
    path: `${prefix}/api/user`,
    login: `${prefix}/api/user/login`,
    tokenRefresh: `${prefix}/api/user/refresh`,
    changeUserData: `${prefix}/api/user/change/data`,
    changeUserPassword: `${prefix}/api/user/change/password`,
    image: `${prefix}/api/user/image`,
  },
  navigation: `${prefix}/api/navigation`,
  stage: `${prefix}/api/stage`,
  calendar: `${prefix}/api/calendar`,
  article: `${prefix}/api/article`,
});

export default routes;
