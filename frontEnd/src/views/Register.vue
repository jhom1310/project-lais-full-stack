<template>
  <div>
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
  Body {
  font-family: Calibri, Helvetica, sans-serif;
  background-color: rgb(94, 94, 94);
  padding: 78px ;
  margin: 5%;
}
button {
       background-color: #520202;
       width: 100%;
        color: rgb(255, 255, 255);
        padding: 15px;
        margin: 10px 0px;
        border: none;
        cursor: pointer;
         }
 form {
        border: 3px solid #f1f1f1;
    }
 input[type=text], input[type=password], input[type=email], input[type=date] {
        width: 100%;
        margin: 8px 0;
        padding: 12px 20px;
        display: inline-block;
        border: 2px solid #520202;
        box-sizing: border-box;
    }
 select {
        width: 100%;
        margin: 8px 0;
        padding: 12px 20px;
        display: inline-block;
        border: 2px solid #520202;
        box-sizing: border-box;
    }
 button:hover {
        opacity: 0.7;
    }
  .cancelbtn {
        width: auto;
        padding: 10px 18px;
        margin: 10px 5px;
    }

 .container {
        padding: 70px;
        background-color: rgb(88, 88, 88);
    }
</style>
