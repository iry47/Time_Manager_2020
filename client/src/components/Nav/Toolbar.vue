<template>
  <v-app-bar
    :clipped-left="drawer.clipped" 
    app 
    :dark="dark">
    <img
      v-if="!isUserLoggedIn"
      src="../../assets/Logo.png"
      aspect-ratio="0.9"
      @click="navTo({name: 'home'}, 'none')"
    />
    <img
      v-if="isUserLoggedIn"
      src="../../assets/Logo.png"
      aspect-ratio="0.9"
      @click="navTo({name: 'dashboard'}, 'one')"
    />
    <v-spacer></v-spacer>
    <v-btn v-if="!admin && isUserLoggedIn" :href="'mailto:support-timemangement@yopmail.com?subject=SUPPORT'" icon small x-large>
      <v-icon>email</v-icon>
    </v-btn>
      <v-btn text v-if="isUserLoggedIn" @click="navTo({name: 'settings'}, 'three')" class="hidden-sm-and-down body-1s font-weight-bold">
        {{this.user.firstname}} {{this.user.lastname}}
      </v-btn>
    <v-toolbar-items>
    <v-btn v-if="!isUserLoggedIn" text :to="{name: 'signin'}" class="body-2 font-weight-bold">Sign in</v-btn>
    <v-btn v-if="!isUserLoggedIn" small :to="{name: 'register'}" class="body-2 font-weight-bold">Register</v-btn>
    <v-btn v-if="isUserLoggedIn" text @click="logout" class="body-1s font-weight-bold">Log out</v-btn>
    </v-toolbar-items>
  </v-app-bar>
</template>

<script>
import { mapState } from "vuex";

export default {
  data() {
    return {
    }
  },
  props: {
    drawer: {
      type: Object,
      required: true
    }
  },
  computed: {
    ...mapState(["user", "isUserLoggedIn", "dark", "admin", "manager", "active"])
  },
  methods: {
    async logout() {
      this.$store.dispatch("setToken", null);
      this.$store.dispatch("setUser", null);
      this.$store.dispatch("setDark", false);
      this.$store.dispatch("setGrad", "to top right, #5D29A9, #CBC8D0");
      // this.$store.dispatch("setReset");
      this.$router.push({
        name: "home"
      });
    },
    async navTo(route, active) {
      if (active === "none") {
        this.$router.push(route);
      } else {
        this.$store.dispatch('setActive', active)
        this.$router.push(route);
      }
    }
  }
};
</script>

<style scoped>
.v-toolbar {
  opacity: 0.9;
}

@media screen and (max-width: 720px) {
  .nonePhone {
    display: none !important;
  }
}
</style>
