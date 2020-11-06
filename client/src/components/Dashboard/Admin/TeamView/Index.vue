
<template>
  <v-layout class="mt-5" justify-center v-if="isUserLoggedIn && admin">
      <v-flex xs6>
        <team-panel v-bind:teamview="teamview"/>
      </v-flex>
  </v-layout>
</template>

<script>
import { mapState } from "vuex";
import TeamPanel from "@/components/Dashboard/Admin/TeamView/TeamPanel";
import TeamService from "@/services/Team/TeamService";

export default {
  data() {
    return {
      teamview: {}
    };
  },
  computed: {
    ...mapState(["isUserLoggedIn", "user", "route", "admin"])
  },
  async mounted() {
    const teamId = this.route.params.teamId;
    this.teamview = (await TeamService.getTeam(teamId)).data;
  },
  components: {
    TeamPanel
  }
};
</script>

<style scoped>
</style>
