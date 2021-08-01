import Vue from 'vue'
import Vuex from 'vuex'
import { axiosBase } from './api/axios-base'

Vue.use(Vuex)
export default new Vuex.Store({
  state: {
     accessToken: localStorage.getItem('access_token') || null, // makes sure the user is logged in even after
    // refreshing the page
     refreshToken: localStorage.getItem('refresh_token') || null,
     user_id: localStorage.getItem('user_id') || null,
     APIData: '' // received data from the backend API is stored here.
  },
  getters: {
    loggedIn (state) {
      return state.accessToken != null
    }
  },
  mutations: {
    updateLocalStorage (state, { access, refresh }) {
      localStorage.setItem('access_token', access)
      localStorage.setItem('refresh_token', refresh)
      state.accessToken = access
      state.refreshToken = refresh
    },
    updateAccess (state, access) {
      state.accessToken = access
    },
    destroyToken (state) {
      state.accessToken = null
      state.refreshToken = null
    },
    updateUserId (state, id) {
      localStorage.setItem('user_id', id)
      state.user_id = id
    }
  },
  actions: {
    // run the below action to get a new access token on expiration
    refreshToken (context) {
      return new Promise((resolve, reject) => {
        axiosBase.post('/api/token/refresh/', {
          refresh: context.state.refreshToken
        }) // send the stored refresh token to the backend API
          .then(response => { // if API sends back new access and refresh token update the store
            console.log('New access successfully generated')
            context.commit('updateAccess', response.data.access)
            resolve(response.data.access)
          })
          .catch(err => {
            console.log('error in refreshToken Task')
            reject(err) // error generating new access and refresh token because refresh token has expired
          })
      })
    },
    registerUser (context, data) {
      return new Promise((resolve, reject) => {
        axiosBase.post('/rest-auth/registration/', {
          email: data.email,
          name: data.name,
          password1: data.password1,
          password2: data.password2,
          date_of_birth: data.date_of_birth
        })
          .then(response => {
            console.log({
              email: data.email,
              name: data.name,
              password1: data.password1,
              password2: data.password2,
              date_of_birth: data.date_of_birth
            })
            resolve(response)
          })
          .catch(error => {
            console.log({
              email: data.email,
              name: data.name,
              password1: data.password1,
              password2: data.password2,
              date_of_birth: data.date_of_birth
            })
            reject(error)
          })
      })
    },
    logoutUser (context) {
      if (context.getters.loggedIn) {
        return new Promise((resolve, reject) => {
          axiosBase.post('/rest-auth/logout')
            .then(response => {
              localStorage.removeItem('access_token')
              localStorage.removeItem('refresh_token')
              context.commit('destroyToken')
            })
            .catch(err => {
              localStorage.removeItem('access_token')
              localStorage.removeItem('refresh_token')
              context.commit('destroyToken')
              resolve(err)
            })
        })
      }
    },
    loginUser (context, credentials) {
      return new Promise((resolve, reject) => {
        // send the username and password to the backend API:
        axiosBase.post('/api-token-auth/', {
          email: credentials.email,
          password: credentials.password
        })
        // if successful update local storage:
          .then(response => {
            context.commit('updateLocalStorage', { access: response.data.access, refresh: response.data.refresh }) // store the access and refresh token in localstorage
            axiosBase.post('/rest-auth/login/', {
              email: credentials.email,
              password: credentials.password
            })
            .then(res => {
              console.log(res.data.user.id)
              context.commit('updateUserId', res.data.user.id)
              console.log('captura de id')
              console.log(localStorage.getItem('user_id'))
              resolve()
            })
            .catch(err => {
              console.log('erro ao capturar id')
              console.log(err)
            })
            resolve()
            console.log(response.data)
          })
          .catch(err => {
            reject(err)
          })
      })
    }
  }
})
