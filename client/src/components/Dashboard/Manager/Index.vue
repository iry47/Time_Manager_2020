<template>
<v-container fluid grid-list-md>
  <v-layout class="mt-5" v-if="isUserLoggedIn && manager" justify-center row wrap>
    <teams></teams>
  </v-layout>
</v-container>
</template>

<script>
import { mapState } from "vuex";
import Teams from '@/components/Dashboard/Manager/Team/Teams';

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