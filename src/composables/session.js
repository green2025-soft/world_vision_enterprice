// src/composables/session.js
import { ref } from 'vue'
import axios from 'axios'

const SESSION_DURATION = 6 * 60 * 60 * 1000 // 6 hours in ms
let logoutTimer = null

export const isLoggedIn = ref(!!localStorage.getItem('authToken'))

export function startSessionTimer() {
    clearTimeout(logoutTimer)
    logoutTimer = setTimeout(() => {
        logoutUser()
    }, SESSION_DURATION)
}

export async function refreshSession() {
    if (!isLoggedIn.value) return
    try {
        await axios.get('/api/refresh-session') // backend call
        startSessionTimer()
        console.log('Session refreshed')
    } catch (error) {
        console.log('Session expired')
        logoutUser()
    }
}

export function loginUser(token) {
    localStorage.setItem('authToken', token)
    axios.defaults.headers.common['Authorization'] = `Bearer ${token}`
    isLoggedIn.value = true
    startSessionTimer()
}

export function logoutUser() {
    localStorage.removeItem('authToken')
    delete axios.defaults.headers.common['Authorization']
    isLoggedIn.value = false
    clearTimeout(logoutTimer)
    window.location.href = '/login' // redirect to login page
}

// call refreshSession periodically
setInterval(refreshSession, 5 * 60 * 1000) // every 5 minutes
