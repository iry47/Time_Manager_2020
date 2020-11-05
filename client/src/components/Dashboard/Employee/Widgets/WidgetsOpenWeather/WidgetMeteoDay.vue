<template>
  <widget v-if="isUserLoggedIn">
    <div id="openweather-current"></div>
  </widget>
</template>

<script>
import OpenWeatherService from "@/services/OpenWeather/OpenWeatherService";
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
  mounted() {
    generateCurrentWeather(this.servicesUser.townOpenWeather)
  },
  watch: {}
};
</script>

<style scoped></style>
