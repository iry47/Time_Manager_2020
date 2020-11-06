<template>
  <widget v-if="isUserLoggedIn">
  </widget>
</template>

<script>
import { mapState } from "vuex";

export default {
  data() {
    return {};
  },
  computed: {
    ...mapState(["isUserLoggedIn", "user", "servicesUser", "route"])
  },
  methods: {
  },
  async mounted() {
  },
  watch: {}
};
</script>

<style scoped></style>
