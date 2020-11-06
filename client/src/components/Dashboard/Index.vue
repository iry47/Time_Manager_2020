<template>
<v-container fluid grid-list-md>
  <v-layout v-if="isUserLoggedIn && admin" justify-center row wrap>
    <dashboard-admin/>
  </v-layout>
  <v-layout v-if="isUserLoggedIn && !admin" justify-center row wrap>
    <dashboard-employee/>
  </v-layout>
</v-container>
</template>

<script>
import { mapState } from "vuex";
import DashboardAdmin from "@/components/Dashboard/Admin/Index";
import DashboardEmployee from "@/components/Dashboard/Employee/Index";

export default {
  data() {
    return {
    };
  },
  computed: {
    ...mapState(["isUserLoggedIn", "user", "admin", "manager"])
  },
  async mounted() {
  },
  components: {
    DashboardAdmin,
    DashboardEmployee
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
