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
  }
};
</script>

<style scoped></style>
