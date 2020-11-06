<template>
  <v-container fluid grid-list-md justify-center>
    <v-layout class="mt-5" v-if="isUserLoggedIn && (admin || manager)" justify-center wrap>
      <v-flex>
      <grid-widgets/>
    </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import { mapState } from "vuex";

/* GRIDSTER */
import GridWidgets from "@/components/Dashboard/Admin/UserView/DashboardUser";

export default {
  data() {
    return {
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
    GridWidgets
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
