<template>
  <div class="locais">
    <NavBar></NavBar>
    <div class="bod">
      <h1>Preencha o formulario para realizar o agendamento</h1>
      <h2>Cidade : {{city}}</h2>
    </div>
    <h2>{{message}}</h2>
    <div v-if="vizu === false">
      <form v-on:submit.prevent="create_agend">
        <label>Ponto de Vacinação: </label>
          <select v-model="local_select">
            <option v v-for="local in dataLocal"
            :key="local.nom_estab"
            :value="local"
            v-text="local.nom_estab"></option>
          </select>
        <label>Grupo: </label>
          <select v-model="grupo_select">
            <option v v-for="grupo in dataGrupo"
            :key="grupo.name"
            :value="grupo"
            v-text="grupo.name +' - '+ grupo.min_age "></option>
          </select>
        <label>Data e Horario: </label>
          <input v-model="datatime" type="datetime-local">
        <label>Idade: </label>
          <input v-model="age" type="number" min="0">
        <button type="submit">Agendar</button>
      </form>
    </div>
    <hr>
  </div>
</template>

<script>
  import NavBar from '../components/Navbar'
  import { getAPI } from '../api/axios-base'
  import { mapState } from 'vuex'
   import axios from 'axios'
  export default {
    name: 'agendar',
    onIdle () { // dispatch logoutUser if no activity detected
      this.$store.dispatch('logoutUser')
        .then(response => {
          this.$router.push('/login')
        })
    },
    data () {
      return {
        city: '',
        local_select: '',
        grupo_select: '',
        dataLocal: {},
        dataGrupo: {},
        user_id: 0,
        age: 0,
        datatime: '',
        message: '',
        vizu: false
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
            this.dataLocal = response.data
          })
          .catch(err => {
            console.log(err)
          })
        })
        .then((response) => {
          getAPI('/api/vacinas/groups/', { headers: { Authorization: `Bearer ${this.$store.state.accessToken}` } })
          .then(response => {
            console.log('Sucesso ao obter grupos')
            this.dataGrupo = response.data
          })
          .catch(err => {
            console.log(err)
          })
        })
        .then((data) => {
          this.user_id = this.$store.state.user_id
        })
    },
    methods: {
      create_agend () {
        console.log(this.$store.state.accessToken)
        console.log({
          local: this.local_select.nom_estab,
          user: this.user_id,
          status: 1,
          groups: this.grupo_select.name,
          datatime: this.datatime,
          age: this.age
        })
        axios.post('http://192.168.1.7:8000/api/vacinas/agendamentos/', {
          local: this.local_select.nom_estab,
          user: this.user_id,
          status: 1,
          groups: this.grupo_select.name,
          datatime: this.datatime,
          age: this.age
        }, { headers: { Authorization: `Bearer ${this.$store.state.accessToken}` } }
        )
        .then(response => {
          this.message = 'Agendamento realizado com sucesso!'
          this.vizu = true
          console.log(response.data)
        })
        .catch(err => {
          this.message = err.response.data
          console.log(err.response)
        })
      }
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
