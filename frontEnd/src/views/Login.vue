<template>
  <div>
    <NavBar></NavBar>
    <form v-on:submit.prevent="loginUser">
        <div class="container">
            <label>Email : </label>
            <input v-model="email" type="text" placeholder="Informe seu email" name="email" required >
            <label>Senha : </label>
            <input v-model="password" type="password" placeholder="Informe sua senha" name="password" required>
            <button type="submit">Login</button>
            <h2 v-if="wrongCred">Credenciais incorretas! Por favor, insira seus dados corretos.</h2>
        </div>
    </form>
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

<style>
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
 input[type=text], input[type=password] {
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
