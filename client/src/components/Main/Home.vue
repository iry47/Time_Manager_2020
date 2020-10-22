<template>
<v-layout row align-center>
  <v-flex v-if="!isUserLoggedIn" xs12 offset-xs2 sm8 md4>
      <!-- <v-flex xs6 class="mt-5">
        <v-layout justify-center>
        <h1
          class="display-3 mr-3 white--text font-weight-black blue-grey--text text--darken-2"
        >{{ msg }}</h1>
        </v-layout>
      </v-flex> -->
      <!-- <v-flex xs6> -->
          <!-- <v-card>
                <v-card-title justify-center class="mr-3">
                  <h2 v-text="`${msg}`"></h2>
                </v-card-title>
                <v-card-text>
                  <div v-text="`${more}`">{{more}}
                  </div>
                  <a href='mailto:dspp@al-enterprise.com?subject=INFO' class="">dspp@al-enterprise.com</a>
                </v-card-text>
          </v-card> -->

  </v-flex>
</v-layout>
</template>

<script>
import { mapState } from "vuex";

export default {
  name: "Hello",
  data() {
    return {
      msg: "Time manager",
      about: "Project Epitech for Pool MSc",
      more: "Made with Elixir / Phoenix Back-end and Vue Front-end",
    };
  },
  computed: {
    ...mapState(["isUserLoggedIn", "user"])
  }
};
</script>

<style scoped>
</style>
