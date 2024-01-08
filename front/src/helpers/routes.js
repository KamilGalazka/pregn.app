const prefix = "http://localhost:3000";

const routes = Object.freeze({
  user: {
    login: `${prefix}/api/user/login`,
    register: `${prefix}/api/user/create`,
    tokenRefresh: `${prefix}/api/user/refresh`,
  },
  navigation: {
    getNavigation: `${prefix}/api/navigation`,
  },
  stage: {
    getStage: `${prefix}/api/stage`,
  },
  calendar: {
    getAllNotes: `${prefix}/api/calendar`,
    addNote: `${prefix}/api/calendar/add`,
    changeNote: `${prefix}/api/calendar/change`,
    deleteNote: `${prefix}/api/calendar/delete`,
  },
});

export default routes;
