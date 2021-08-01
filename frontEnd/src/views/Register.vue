<template>
  <div class="register-form">
    <NavBar></NavBar>
    <h2 v-if="wrongCred">{{message}}</h2>
    <form @submit.prevent="registerUser">
      <label for="el">Email</label>
      <input type="email" name="el" id="el" v-model="email">
      <label for="Name">Nome Completo</label>
      <input type="text" name="Name" id="Name" v-model="name">
      <label for="pwr">Senha</label>
      <input type="password" name="pwr" id="pwr" v-model="password1">
      <label for="pass">Confirmar Senha</label>
      <input type="password" name="pass" id="pass" v-model="password2">
      <label for="ur">Data de Nasimento</label>
      <input type="date" name="ur" id="ur" v-model="date_of_birth">
      <button type="submit">Register</button>
    </form>
  </div>
</template>

<script>
  import NavBar from '../components/Navbar'
  export default {
    name: 'register',
    components: {
      NavBar
    },
    data () {
      return {
        email: '',
        name: '',
        password1: '',
        password2: '',
        date_of_birth: '',
        wrongCred: false,
        message: ''
      }
    },
    methods: {
      registerUser () {
        this.$store.dispatch('registerUser', {
          email: this.email,
          password1: this.password1,
          password2: this.password2,
          name: this.name,
          date_of_birth: this.date_of_birth
        }).then((response) => {
          this.$router.push({ name: 'login' })
        })
        .catch(err => {
          console.log(err)
          this.wrongCred = true
          this.message = err.response.data
        })
      }
    }
  }
</script>

<style scoped>
  @import url(https://fonts.googleapis.com/css?family=Quicksand) ;
  .register-form {
    background-color: #606366;
    width: 100%;
    margin: 78px auto;
    padding: 0;
    text-align: center;
  }
</style>
