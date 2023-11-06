<script>
import axios from "axios";
export default {
  name: "HelloWorld",
  data() {
    return {
      msg: String,
    };
  },
  created() {
    axios({
      method: "GET",
      url: "http://localhost:3000/api/navigation",
    }).then((response) => {
      // console.log(response);
      this.msg = response.data.response;
    });
  },
};
</script>

<template>
  <pre>{{ msg }}</pre>
  <a>TESTowt</a>
</template>

<style scoped lang="scss">
h3 {
  margin: 40px 0 0;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: inline-block;
  margin: 0 10px;
}

a {
  color: $basic-color-blue;
}
</style>
