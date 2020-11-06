<template>
<v-container v-on:keyup.enter="signin">
  <v-layout align-center justify-center>
    <v-flex elevation-24 xs12 sm8 md6 v-if="!isUserLoggedIn">
      <panel title="Sign in">
        <form name="sandbox-form" autocomplete="on">
          <v-text-field class="mt-5" 
            label="Email" 
            v-model="email" 
            autocomplete="on"
            outline 
            clearable>
            <template v-slot:append>
              <v-fade-transition leave-absolute>
                <v-icon>email</v-icon>
              </v-fade-transition>
            </template>
          </v-text-field>
          <v-text-field
            label="Password"
            type="password"
            v-model="password"
            autocomplete="new-password"
            outline
            clearable
          >
            <template v-slot:append>
              <v-fade-transition leave-absolute>
                <v-icon>https</v-icon>
              </v-fade-transition>
            </template>
          </v-text-field>
          <v-layout class="mb-4" column justify-center align-center>
            <span class="danger-alert">{{error}}</span>
            <v-layout class="mt-2" justify-center align-center row>
              <v-btn elevation-24 large class="grey darken-1 mb-4 font-weight-bold" @click="signin">Sign in</v-btn>
              <v-icon @click="undoSettings()">refresh</v-icon>
            </v-layout>
          </v-layout>
        </form>
      </panel>
    </v-flex>
  </v-layout>
</v-container>

</template>

<script>
import { mapState } from "vuex";
import AuthenticationService from "@/services/Authen/AuthenticationService";
import Swal from 'sweetalert2'
import axios from 'axios'

export default {
  data() {
    return {
      email: "",
      password: "",
      error: null
    };
  },
  props: {
    drawer: {
      type: Object,
      require: true
    }
  },
  computed: {
    ...mapState(["isUserLoggedIn", "user", "admin", "manager", "active"])
  },
  methods: {    
    async undoSettings() {
      this.error = null
      this.email = null
      this.password = null
    },
    async signin() {
      try {
        const newUser = {
          email: this.email,
          password: this.password         
        }
        const response = (await AuthenticationService.signin(newUser)).data;
        this.$store.dispatch("setUser", response.user);
        this.$store.dispatch("setAdmin", response.user.admin);
        this.$store.dispatch("setManager", response.user.manager);
        this.$store.dispatch("setToken", response.token);
        this.$store.dispatch("setDark", true);
        this.$store.dispatch("setGrad", "to top right, #FFFFFF, #ECE9E6");
        this.$store.dispatch("setActive", 'one')
        this.$router.push({
          name: "dashboard"
        });
        Swal.fire({
          position: 'top-end',
          type: 'success',
          title: 'You sign in with email : ',
          text: this.email,
          showConfirmButton: false,
          timer: 2000
        })
      } catch (error) {
        this.error = error.response.error;
        Swal.fire({
          position: 'top-end',
          type: 'error',
          title: 'Wrong login, please retry',
          text: this.email,
          showConfirmButton: false,
          timer: 2000
        })
      }
    }
  }
};
</script>

<style scoped>
.danger-alert {
  color: red;
}
.btn-google {
  margin: spacing(0, 0, 1);
  display: flex;
  background-color: #DD4B39;
  height: 36px;
  cursor: pointer;
  text-decoration: none;
}
.wrapper-google {
  margin-top: 1px;
  margin-left: 1px;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 34px;
  height: 34px;
  border-radius: 2px;
  background-color: #fff;
}
.icon-google {
  width: 18px;
  height: 18px;
}
.text-google {
  margin: 0 34px 0 0;
  color: #fff;
  font-size: 14px;
  font-size: 14px;
  font-weight: bold;
  text-transform: uppercase;
  flex-grow: 1;
  text-align: center;
  align-self: center;
}
</style>
