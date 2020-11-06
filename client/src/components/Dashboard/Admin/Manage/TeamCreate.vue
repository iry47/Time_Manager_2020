<template>
  <v-layout class="mt-5" v-if="isUserLoggedIn && admin" v-on:keyup.enter="create({name: 'dashboard'})" justify-center>
    <v-flex xs6>
      <panel title="Create Team">
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
        <v-layout column align-center justify-center class="mb-4">
        <span class="danger-alert">{{error}}</span>
        <v-layout class="mt-2" row justify-center align-center>
          <v-btn elevation-24 large class="grey darken-1 mb-4 font-weight-bold" 
          @click="create({name: 'dashboard'})">
          Create</v-btn>
          <v-btn elevation-24 large class="grey darken-1 ml-1 mb-4 font-weight-bold" 
          @click="cancel()">
          Cancel</v-btn>
        </v-layout>
        </v-layout>
      </panel>
    </v-flex>
  </v-layout>
</template>

<script>
import { mapState } from "vuex";
import TeamService from "@/services/Team/TeamService"

export default {
  data() {
    return {
      max: 50,
      teamview: {
        name: null
      },
      error: null,
      required: value => !!value || "Required."
    };
  },
  computed: {
    ...mapState(["isUserLoggedIn", "user", "admin", "manager"])
  },
  methods: {
    async create(route) {
      this.error = null;
      const areAllFieldsFilledIn = Object.keys(this.teamview).every(
        key => {
          if (key === 'name') {
            return (true)
          }
          return (!!this.teamview[key])
        }
      );
      if (!areAllFieldsFilledIn || !this.teamview.name) {
        this.error = "Please fill in all the required fields.";
        return;
      }
      try {
        await TeamService.post(this.teamview);
        this.$router.push(route);
      } catch (err) {
        console.log(err);
      }
    },
    async cancel() {
      this.$router.push({name: 'dashboard'})
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
