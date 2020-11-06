<template>
<v-container fluid grid-list-md>
  <v-layout class="mt-5" v-if="isUserLoggedIn && admin" justify-center row wrap>
    <v-flex fill-height xs12 sm10 md9 d-flex class="mt-2">
      <user-panel/>
    </v-flex>
    <v-flex fill-height xs12 sm10 md9 d-flex class="mt-2">
      <admin-panel/>
    </v-flex>
    <v-flex fill-height xs12 sm10 md9 d-flex class="mt-2">
      <team-panel/>
    </v-flex>
  </v-layout>
</v-container>
</template>

<script>
import { mapState } from "vuex";
import AdminPanel from "@/components/Dashboard/Admin/AdminPanel/AdminPanel";
import UserPanel from "@/components/Dashboard/Admin/AdminPanel/UserPanel";
import TeamPanel from "@/components/Dashboard/Admin/AdminPanel/TeamPanel";
import UserService from "@/services/User/UserService";

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
  },
  components: {
    AdminPanel,
    UserPanel,
    TeamPanel
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
