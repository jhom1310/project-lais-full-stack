import axios from 'axios'
import store from '../store'
const APIUrl = 'http://192.168.1.7:8000'

const axiosBase = axios.create({
  baseURL: APIUrl,
  headers: { contentType: 'application/json' }
})
const getAPI = axios.create({
  baseURL: APIUrl
})
getAPI.interceptors.response.use(undefined, function (err) {
  if (err.config && err.response && err.response.status === 401) {
    store.dispatch('refreshToken')
      .then(access => {
        console.log('token refresh')
      })
      .catch(err => {
        return Promise.reject(err)
      })
  }
})

export { axiosBase, getAPI }
