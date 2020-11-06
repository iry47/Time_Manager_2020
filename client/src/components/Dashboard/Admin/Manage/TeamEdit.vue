<template>
  <v-layout v-if="isUserLoggedIn && admin" v-on:keyup.enter="save()" justify-center>
    <v-flex xs6>
      <panel class="mt-5" title="Edit Team">
          <v-text-field label="Name" type="name" v-model="teamview.name"
          outline clearable>
            <template v-slot:prepend>
              <v-tooltip bottom>
                <template v-slot:activator="{ on }">
                  <v-icon v-on="on">help</v-icon>
                </template>
                Your name must be valid
              </v-tooltip>
            </template>
            <template v-slot:append>
              <v-fade-transition leave-absolute>
                <v-icon>email</v-icon>
              </v-fade-transition>
            </template>
          </v-text-field>
        <br>
        <v-layout column class="mb-4" justify-center align-center>
        <span class="danger-alert">{{error}}</span>
        <v-layout class="mt-2" row justify-center align-center>
        <v-btn elevation-24 large class="grey darken-1 mb-4 font-weight-bold"
        @click="save()">Save</v-btn>
        <v-btn elevation-24 large class="grey darken-1 ml-1 mb-4 font-weight-bold"
        @click="cancel()">Cancel</v-btn>
        <v-icon @click="undoEdit()">refresh</v-icon>
        </v-layout>
        </v-layout>
      </panel>
    </v-flex>
  </v-layout>
</template>

<script>
import TeamService from "@/services/Team/TeamService";
import { mapState } from "vuex";

export default {
  data() {
    return {
      teamview: {
        name: null
      },
      error: null,
      required: value => !!value || "Required."
    };
  },
  computed: {
    ...mapState(["isUserLoggedIn", "route", "user", "admin", "manager"])
  },
  methods: {
    async save() {
      this.error = null;
      const areAllFieldsFilledIn = Object.keys(this.teamview).every(
        key => {
          return (!!this.teamview[key])
        }
      );
      if (!areAllFieldsFilledIn || !this.teamview.name) {
        this.error = "Please fill in all the required fields.";
        return;
      }
      const teamId = this.route.params.teamId;
      try {
        await TeamService.put(this.teamview);
        this.$router.push({
          name: "dashboard"
        });
      } catch (err) {
        console.log(err);
      }
    },
    async undoEdit() {
      this.error = null
      const teamId = this.route.params.teamId;
      this.teamview = (await TeamService.get(teamId)).data;
    },
    async cancel() {
      this.$router.push({name: 'dashboard'})
    }
  },
  async mounted() {
    try {
      const teamId = this.route.params.teamId;
      this.teamview = (await TeamService.get(teamId)).data;
    } catch (err) {
      console.log(err);
    }
  }
};
</script>

<style scoped>
.danger-alert {
  color: red;
}
.padding-input {
  margin: auto;
  /* margin-left: 32px; */
}
</style>
