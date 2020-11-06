<template>
  <v-layout class="mt-5 ml-5" justify-center v-if="isUserLoggedIn" row>
    <v-layout class="mt-5" justify-center wrap v-if="isUserLoggedIn">
      <v-flex fill-height xs12 sm8 md6 v-if="isUserLoggedIn">
        <settings-user />
      </v-flex>
    </v-layout>
  </v-layout>
</template>

<script>
import { mapState } from "vuex";
import SettingsUser from "@/components/Settings/SettingPanel/SettingsUser";

export default {
  data() {
    return {
      vlabs: null
    };
  },
  computed: {
    ...mapState(["isUserLoggedIn", "user", "admin", "manager"])
  },
  async mounted() {},
  components: {
    SettingsUser
  },
  props: {
    main: {
      type: Object,
      require: true
    }
  }
};
</script>

<style scoped></style>
