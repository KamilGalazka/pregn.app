const prefix = "http://localhost:3000";

const routes = Object.freeze({
  user: {
    getUserData: `${prefix}/api/user/info`,
    login: `${prefix}/api/user/login`,
    register: `${prefix}/api/user/create`,
    tokenRefresh: `${prefix}/api/user/refresh`,
    changeUserData: `${prefix}/api/user/change/data`,
    changeUserPassword: `${prefix}/api/user/change/password`,
    delete: `${prefix}/api/user/delete`,
  },
  navigation: {
    getNavigation: `${prefix}/api/navigation`,
  },
  stage: {
    getStage: `${prefix}/api/stage`,
  },
  calendar: {
    getAllNotes: `${prefix}/api/calendar/get`,
    addNote: `${prefix}/api/calendar/add`,
    changeNote: `${prefix}/api/calendar/change`,
    deleteNote: `${prefix}/api/calendar/delete`,
  },
  article: {
    getArticle: `${prefix}/api/article`,
  },
});

export default routes;
