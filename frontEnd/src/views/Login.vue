<template>
  <div class="login-form">
    <NavBar></NavBar>
    <div class="lg">
      <h2 v-if="wrongCred">Credenciais incorretas! Por favor, insira seus dados corretos.</h2>
      <form v-on:submit.prevent="loginUser">
        <label for="user">Email</label>
        <input type="text" name="email" id="user" v-model="email">
        <label for="pass">Password</label>
        <input type="password" name="password" id="pass" v-model="password">
        <button type="submit">Login</button>
      </form>
    </div>
  </div>
</template>

<script>
  import NavBar from '../components/Navbar'
  export default {
    name: 'login',
    components: {
      NavBar
    },
    data () {
      return {
        email: '',
        password: '',
        wrongCred: false // activates appropriate message if set to true
      }
    },
    methods: {
      loginUser () { // call loginUSer action
        this.$store.dispatch('loginUser', {
          email: this.email,
          password: this.password
        })
            .then(() => {
              this.$router.push({ name: 'locais' })
            })
          .catch(err => {
            console.log(err)
            console.log(err.response)
            this.wrongCred = true // if the credentials were wrong set wrongCred to true
          })
        }
      }
  }
</script>

<style scoped>
  @import url(https://fonts.googleapis.com/css?family=Quicksand) ;
  .login-form {
    margin: 0;
    padding: 0;
  }
  .lg {
    background-color: #606366;
    text-align: center;
    color: white;
    font-family: 'Quicksand', sans-serif;
    padding: 0;
    margin: 78px 0;
  }
</style>
