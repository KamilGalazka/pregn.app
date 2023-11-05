const { defineConfig } = require("@vue/cli-service");

module.exports = defineConfig({
  transpileDependencies: true,
  devServer: {
    proxy: {
      "/api": {
        target: "http://localhost:3000",
        pathRewrite: { "^/api": "" },
      },
    },
  },
  css: {
    loaderOptions: {
      sass: {
        additionalData: `
          @import "@/scss/_basic.scss";
          @import "@/scss/_variables.scss";
        `,
      },
    },
  },
});
