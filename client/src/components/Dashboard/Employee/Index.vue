<template>
  <v-container fluid grid-list-md justify-center>
    <v-layout class="mt-5" v-if="isUserLoggedIn && !admin" justify-center wrap>
      <v-flex>
      <dashboard/>
    </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import { mapState } from "vuex";

/* GRIDSTER */
import Dashboard from "@/components/Dashboard/Employee/Dashboard";

/* SERVICE */
// import ServiceUser from "@/services/Service/ServiceUser";
// import Service from "@/services/Service/Service";

export default {
  data() {
    return {
      servicesUsers: null,
      services: null
    };
  },
  computed: {
    ...mapState([
      "isUserLoggedIn",
      "user",
      "servicesUser",
      "servicesActive",
      "admin",
      "dark",
      "grad"
    ])
  },
  components: {
    Dashboard
  },
  props: {
    main: {
      type: Object,
      require: true
    }
  },
  methods: {
  },
  async mounted() {
    try {
      // this.servicesUsers = (
      //   await ServiceUser.getUserService(this.user.id)
      // ).data;
      // this.servicesUsers.forEach(data => {
      //   if (data.ServiceId === 1) {
      //     this.$store.dispatch("setServiceActiveOpenWeather", true);
      //     this.$store.dispatch("setServiceUserTown", data.data);
      //   } 
      // });
    } catch (err) {
      console.log(err);
    }
  }
};
</script>

<style scoped></style>
