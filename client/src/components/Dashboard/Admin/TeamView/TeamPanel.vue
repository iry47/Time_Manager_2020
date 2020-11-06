<template>
  <panel v-if="isUserLoggedIn && admin" title="User view">
    <v-layout column justify-center align-center> 
        <v-flex xs6 class="team-name">
          <h4> Team name :
          {{teamview.name}}
          </h4>
          <br>
        </v-flex>
      <v-flex xs6>
      <v-btn large
        class="grey darken-1 font-weight-bold"
        :to="{name: 'team-edit', params () {
            return {
              teamId: teamview.id
            }
          }}">Edit</v-btn>
      </v-flex>
    </v-layout>
  </panel>
</template>

<script>
import { mapState } from "vuex";
export default {
  computed: {
    ...mapState(["isUserLoggedIn", "user", "admin"])
  },
  props: ['teamview']
};
</script>

<style scoped>
.team {
  padding: 20px;
  height: 200px;
  overflow: hidden;
}
.team-name {
  font-size: 20px;
}
</style>
