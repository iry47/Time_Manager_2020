<template>
<v-container fluid grid-list-md>
  <v-layout class="mt-5" v-if="isUserLoggedIn && admin" justify-center row wrap>
    <!-- <toolbar v-bind:drawer="drawer"/> -->
  </v-layout>
  <v-layout class="mt-5" v-if="isUserLoggedIn && !admin" justify-center row wrap>
    <!-- <toolbar v-bind:drawer="drawer"/> -->
  </v-layout>
</v-container>
</template>

<script>
import { mapState } from "vuex";
import UserService from "@/services/ApiAxios/User/UserService";

export default {
  data() {
    return {
      userview: null
    };
  },
  computed: {
    ...mapState(["isUserLoggedIn", "user", "admin", "manager"])
  },
  async mounted() {
    this.userview = (await UserService.getUser(this.user.id)).data;
  },
  components: {
  },
  props: {
    main: {
      type: Object,
      require: true
    }
  }
};
</script>

<style scoped>
</style>
