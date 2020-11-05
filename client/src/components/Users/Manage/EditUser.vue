<template>
  <v-layout v-if="isUserLoggedIn && admin" v-on:keyup.enter="save()" justify-center>
    <v-flex xs6>
      <panel class="mt-5" title="Edit user">
          <v-text-field label="Email" type="name" v-model="userview.email"
          outline clearable>
            <template v-slot:prepend>
              <v-tooltip bottom>
                <template v-slot:activator="{ on }">
                  <v-icon v-on="on">help</v-icon>
                </template>
                Your email must be valid
              </v-tooltip>
            </template>
            <template v-slot:append>
              <v-fade-transition leave-absolute>
                <v-icon>email</v-icon>
              </v-fade-transition>
            </template>
          </v-text-field>
        <br>
          <v-text-field label="Confirm email" type="name" v-model="confirmEmail"
          outline clearable>
            <template v-slot:prepend>
              <v-tooltip bottom>
                <template v-slot:activator="{ on }">
                  <v-icon v-on="on">help</v-icon>
                </template>
                Your email must be the same
              </v-tooltip>
            </template>
            <template v-slot:append>
              <v-fade-transition leave-absolute>
                <v-icon>email</v-icon>
              </v-fade-transition>
            </template>
          </v-text-field>
        <br>
          <v-layout justify-center>
          <v-btn elevation-24 large class="grey darken-1 mr-1 mb-4 font-weight-bold" @click="displayPwd">Change password</v-btn>
          </v-layout>
          <v-text-field
            v-if="changePassword"
            label="Password"
            type="password"
            v-model="userview.password"
            autocomplete="new-password"
            outline
            clearable
          >
            <template v-slot:prepend>
              <v-tooltip bottom>
                <template v-slot:activator="{ on }">
                  <v-icon v-on="on">help</v-icon>
                </template>
                Your password must contain at least 8 characters
              </v-tooltip>
            </template>
            <template v-slot:append>
              <v-fade-transition leave-absolute>
                <v-icon>https</v-icon>
              </v-fade-transition>
            </template>
          </v-text-field>
          <br>
          <v-text-field
            v-if="changePassword"
            label="Confirm password"
            type="password"
            v-model="confirmPassword"
            autocomplete="new-password"
            outline
            clearable
          >
                            <template v-slot:prepend>
              <v-tooltip bottom>
                <template v-slot:activator="{ on }">
                  <v-icon v-on="on">help</v-icon>
                </template>
                Your password must be the same
              </v-tooltip>
            </template>
            <template v-slot:append>
              <v-fade-transition leave-absolute>
                <v-icon>https</v-icon>
              </v-fade-transition>
            </template>
          </v-text-field>
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
import UserService from "@/services/ApiAxios/User/UserService";
import { mapState } from "vuex";
import crypto from "crypto"

export default {
  data() {
    return {
      changePassword: false,
      confirmPassword: null,
      confirmEmail: null,
      userview: {
        email: null,
        password: null,
        salt: null,
        hash: null
      },
      error: null,
      required: value => !!value || "Required."
    };
  },
  computed: {
    ...mapState(["isUserLoggedIn", "route", "user", "admin", "manager"])
  },
  methods: {
    async displayPwd() {
      if (this.changePassword === false) {
        this.changePassword = true
      } else {
        this.changePassword = false
      }
    },
    async save() {
      this.error = null;
      if (this.changePassword) {
        const areAllFieldsFilledIn = Object.keys(this.userview).every(
          key => {
            if (key === 'salt' || key === 'hash') {
              return (true)
            }
            return (!!this.userview[key])
          }
        );
      } else {
        const areAllFieldsFilledIn = Object.keys(this.userview).every(
          key => {
            if (key === 'salt' || key === 'hash' || key === 'password') {
              return (true)
            }
            return (!!this.userview[key])
          }
        );
      }
      if (this.confirmEmail !== this.userview.email) {
        this.error = "The emails don't match"
        return;
      }
      if (this.changePassword) {
        if (this.confirmPassword !== this.userview.password) {
          this.error = "The passwords don't match"
          return;
        }
        this.userview.salt = crypto.randomBytes(16).toString(`hex`)
        this.userview.hash = crypto.pbkdf2Sync(this.userview.password, this.userview.salt, 1000, 64, `sha512`).toString(`hex`)
        this.userview.password = ""
      }
      const userId = this.route.params.userId;
      try {
        await UserService.put(this.userview);
        this.$router.push({
          name: "users"
        });
      } catch (err) {
        console.log(err);
      }
    },
    async undoEdit() {
      this.error = null
      const userId = this.route.params.userId;
      this.userview = (await UserService.getUser(userId)).data;
      this.confirmPassword = this.userview.password
      this.confirmEmail = this.userview.email
    },
    async cancel() {
      this.$router.push({name: 'users'})
    }
  },
  async mounted() {
    try {
      const userId = this.route.params.userId;
      this.userview = (await UserService.getUser(userId)).data;
      this.confirmPassword = this.userview.password
      this.confirmEmail = this.userview.email
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
