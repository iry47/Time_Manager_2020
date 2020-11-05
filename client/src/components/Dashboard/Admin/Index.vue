<template>
<v-container fluid grid-list-md>
  <v-layout class="mt-5" v-if="isUserLoggedIn && admin" justify-center row wrap>
    <v-flex fill-height xs12 sm10 md9 d-flex class="mt-2">
      <users-client-panel/>
    </v-flex>
    <v-flex fill-height xs12 sm10 md9 d-flex class="mt-2">
      <users-admin-panel/>
    </v-flex>
  </v-layout>
</v-container>
</template>

<script>
import { mapState } from "vuex";
import UsersClientPanel from "./ItemUser/UsersClientPanel";
import UsersAdminPanel from "./ItemUser/UsersAdminPanel";
import UserService from "@/services/ApiAxios/User/UserService";

export default {
  data() {
    return {
      users: null
    };
  },
  computed: {
    ...mapState(["isUserLoggedIn", "user", "admin", "manager"])
  },
  async mounted() {
    this.users = (await UserService.index()).data;
  },
  components: {
    UsersClientPanel,
    UsersAdminPanel
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
