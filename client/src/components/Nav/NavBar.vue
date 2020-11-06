<template>
  <v-layout @mouseover="isMini()">
  <v-navigation-drawer 
      :width="170"
      v-model="drawer.model"
      :permanent="drawer.type === 'permanent'"
      :clipped="drawer.clipped"
      :floating="drawer.floating"
      :mini-variant="drawer.mini"
      overflow
      app
      :dark="dark"
  >
    <v-list>
      <v-list-item v-if="isUserLoggedIn" class="mt-3" title="test" @click="navTo({name: 'dashboard'}, 'one')"
      :class="active.one">
        <v-list-item-action>
          <v-icon>dashboard</v-icon>
        </v-list-item-action>
        <v-list-item-content>
          <v-list-item-title>Dashboard</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
      <v-list-item class="mt-2" v-if="isUserLoggedIn && manager" @click="navTo({name: 'teams'}, 'two')"
      :class="active.two">
        <v-list-item-action>
          <v-icon>people</v-icon>
        </v-list-item-action>
        <v-list-item-content>
          <v-list-item-title>Teams</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
      <v-list-item class="mt-2" v-if="isUserLoggedIn" @click="navTo({name: 'settings'}, 'three')"
      :class="active.three">
        <v-list-item-action>
          <v-icon>settings</v-icon>
        </v-list-item-action>
        <v-list-item-content>
          <v-list-item-title>Settings</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </v-list>
    <!-- <template v-slot:append>
      <v-list-item v-if="!admin" class="accent mt-5" @click="goToUrl('https://katsarosia.gitbook.io/')">
        <v-list-item-action>
          <v-icon x-large>help</v-icon>
        </v-list-item-action>
        <v-list-item-content>
          <v-list-item-title>Help</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
      <v-list-item v-if="admin" class="accent mt-5" @click="goToUrl('https://documenter.getpostman.com/')">
        <v-list-item-action>
          <v-icon x-large>help</v-icon>
        </v-list-item-action>
        <v-list-item-content>
          <v-list-item-title>Help</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </template> -->
  </v-navigation-drawer>
</v-layout>
</template>

<script>
import Swal from 'sweetalert2'
import { mapState } from "vuex";

export default {
  computed: {
    ...mapState(["user", "isUserLoggedIn", "admin", "manager", "dark", "active"])
  },
  props: {
    drawer: {
      type: Object,
      require: true
    }
  },
  methods: {
    async goToUrl(url) {
      window.open(url, '_blank')
    },
    async isMini() {
      if (this.drawer.mini) {
        this.drawer.mini = false
      }
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

</style>
