<template>
  <v-layout justify-center>
    <v-flex xs12 md10>
    <panel title="Team">
   <v-btn
      class="grey darken-3"
      slot="action"
      :to="{name: 'team-create'}"
      light
      medium
      absolute
      right
      middle
      fab
    >
      <v-icon>add</v-icon>
    </v-btn>
      <v-card>
      <v-card-title>
      <v-spacer></v-spacer>
      <v-text-field v-model="search" append-icon="search" label="Search" single-line hide-details></v-text-field>
      </v-card-title>
      <v-data-table
        :headers="headers" 
        :items-per-page="5"
        :loading="isData(teams)" 
        loading-text="No data for the moment"
        class="elevation-12"
        :search="search"
        :items="teams">
          <template v-slot:item.email="{item}">
          <a :href="'mailto:' + item.email + '?subject=INFO'" class="text-xs-left">{{item.email}}</a>
          </template>
          <template v-slot:item.id="{item}">
            <v-layout align-center justify-center>
            <v-btn
              class="grey darken-1 font-weight-bold ml-1 mt-1"
              :to="{
                  name: 'team-edit',
                  params: {
                    teamId: item.id}
              }"
            >Edit</v-btn>
            <v-btn
              class="grey darken-1 font-weight-bold ml-1 mt-1"
              :to="{
                  name: 'team',
                  params: {
                    teamId: item.id}
              }"
            >View</v-btn>
            <v-btn
              class="grey darken-1 font-weight-bold ml-1 mt-1"
              @click="deleteTeam(item.id)"
            >Delete</v-btn>
            </v-layout>
          </template>
      </v-data-table>
      </v-card>
    </panel>
    </v-flex>
  </v-layout>
</template>
<script>
import { mapState } from "vuex";
import TeamService from "@/services/Team/TeamService"
import Swal from 'sweetalert2'

export default {
  data () {
    return {
      search: '',
      headers: [
        {text: "Name", value: "name", sortable: false, align: "center"},
        {text: "", value: "id"}
      ],
      teams: []
    }
  },
  async mounted() {
    this.teams = (await TeamService.index()).data;
  },
  methods: {
    isData(data) {
      if (data) {
        return (false)
      } else {
        return (true)
      }
    },
    async deleteTeam(teamId) {
      await TeamService.delete(teamId)
      this.teams = (await TeamService.index()).data;
    },
    async mailTo(email) {
      return ('mailto:' + email + "?subject=INFO")
    }
  },
  computed: {
    ...mapState(["isUserLoggedIn", "user", "admin", "manager"])
  },
  watch: {
    async teams() {
      await setTimeout(async () => {
        this.teams = (await TeamService.index()).data;
      }, 5000)
    }
  }
};
</script>

<style scoped>

</style>
