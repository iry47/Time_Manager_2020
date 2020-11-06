<template>
<v-container fluid grid-list-md>
</v-container>
</template>

<script>
import { mapState } from "vuex";

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