<template>
  <div class="locais">
    <NavBar></NavBar>
    <div class="bod">
      <h1>Bem vindo ao sistema de Agendamentos</h1>
      <h2>Pontos de vacinação na sua cidade : {{city}}</h2>
      <h2></h2>
    </div>
    <div v-for="mod in APIData" :key="mod.id">
        <div class="card-body">
          <h3 class="card-title">{{mod.nom_estab}}</h3>
          <p class="card-text">ENDEREÇO: {{mod.dsc_endereco}}</p>
          <p class="card-text">BAIRRO: {{mod.dsc_bairro}}</p>
        </div>
        <hr>
      </div>
  </div>

</template>

<script>
  import NavBar from '../components/Navbar'
  import { getAPI } from '../api/axios-base'
  import { mapState } from 'vuex'
   import axios from 'axios'
  export default {
    name: 'Locais',
    onIdle () {
      this.$store.dispatch('logoutUser')
        .then(response => {
          this.$router.push('/login')
        })
    },
    data () {
      return {
        city: ''
      }
    },
    components: {
      NavBar
    },
    computed: mapState(['APIData']),
    created () {
        axios.get('http://ipinfo.io?token=51f53271aa0776')
        .then((response) => {
          this.city = response.data['city']
          // console.log(this.city)
        })
        .catch(err => {
          console.log(err)
        })
        .then((response) => {
          getAPI.get('/api/vacinas/locals/?cidade=' + this.city, { headers: { Authorization: `Bearer ${this.$store.state.accessToken}` } })
          .then(response => {
            console.log('Sucesso ao obter locais')
            this.$store.state.APIData = response.data
          })
          .catch(err => {
            console.log(err)
          })
        })
    }
  }
</script>

<style scoped>
  @import url(https://fonts.googleapis.com/css?family=Quicksand) ;
  .locais {
    margin: 0;
    padding: 0;
  }
  .bod {
    background-color: #606366;
    width: 100%;
    text-align: center;
    color: white;
    font-family: 'Quicksand', sans-serif;
    padding: 0;
    margin: 78px auto;
  }
  .bod h1 {
    background-color: #292b2d;
    padding: 40px 0 40px 0;
    font-size: 32px;
    margin: 0;
  }
  .bod h2 {
    margin: 0;
    padding: 10px 0 10px 0;
  }
</style>
