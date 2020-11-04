<template>
<v-layout row align-center justify-center>
  <!-- <v-flex v-if="!isUserLoggedIn" xs12 offset-xs2 sm8 md4> -->
    <!-- <v-layout justify-center> -->
      <v-flex xs10 sm7 md5>
          <v-card>
                <v-card-title justify-center class="mr-3">
                  <h2 v-text="`${msg}`"></h2>
                </v-card-title>
                <v-card-text>
                  <div v-text="`${more}`">{{more}}
                  </div>
                  <a href='mailto:support-timemangement@yopmail.com?subject=INFO' class="">support-timemangement@yopmail.com</a>
                </v-card-text>
          </v-card>
                <v-timeline>
            <v-timeline-item :color="`${steps[0].color}`" dark large right>
              <v-card>
                <v-card-text :class="`${steps[0].color} justify-center`">
                  <h2
                    class=" blue-grey--text text--lighten-5"
                    v-text="`${steps[0].msg}`"
                  ></h2>
                  <br>
                  <v-btn
                    depressed
                    small
                    :class="`font-weight-black mx-0 blue-grey--text text--lighten-5 justify-center ${steps[1].color}`"
                    :to="{name: 'register'}"
                  >Click Here</v-btn>
                </v-card-text>
              </v-card>
            </v-timeline-item>
            <v-timeline-item :color="`${steps[1].color}`" dark left small>
              <v-card>
                <v-card-text :class="`${steps[1].color} justify-center`">
                  <h2
                    class=" blue-grey--text text--lighten-5"
                    v-text="`${steps[1].msg}`"
                  ></h2>
                </v-card-text>
              </v-card>
            </v-timeline-item>
            <v-timeline-item :color="`${steps[2].color}`" dark large right>
              <v-card>
                <v-card-text :class="`${steps[2].color} justify-center`">
                  <h2
                    class=" blue-grey--text text--lighten-5"
                    v-text="`${steps[2].msg}`"
                  ></h2>
                </v-card-text>
              </v-card>
            </v-timeline-item>
            <v-timeline-item :color="`${steps[3].color}`" dark left small>
              <v-card>
                <v-card-text :class="`${steps[3].color} justify-center`">
                  <h2
                    class="mr-3  blue-grey--text text--lighten-5"
                    v-text="`${steps[3].msg}`"
                  ></h2>
                </v-card-text>
              </v-card>
            </v-timeline-item>
            <v-timeline-item :color="`${steps[4].color}`" dark large>
              <v-card>
                <v-card-text :class="`${steps[4].color} justify-center`">
                  <h2
                    class="mr-3  blue-grey--text text--lighten-5"
                    v-text="`${steps[4].msg}`"
                  ></h2>
                </v-card-text>
              </v-card>
            </v-timeline-item>
          </v-timeline>
    </v-flex>
</v-layout>
</template>

<script>
import { mapState } from "vuex";

export default {
  data() {
    return {
      msg: "Time Management",
      more: "This app is made for managing your working time for Epitech Center as an employee or a manager. " +
      "If you need specific assistance, please contact us at:",
      steps: [
        {
          color: "light-blue",
          msg: "For Using the App"
        },
        {
          color: "indigo",
          msg: "See your Dashboard"
        },
        {
          color: "teal",
          msg: "Clock'in when you start or finish work"
        },
        {
          color: "light-green",
          msg: "Manage your Team & your Workingtime"
        },
        {
          color: "purple",
          msg: "Access via your mobile" // Link to the store ?
        }
      ]
    };
  },
  computed: {
    ...mapState(["isUserLoggedIn", "user"])
  }
};
</script>

<style scoped>
</style>
