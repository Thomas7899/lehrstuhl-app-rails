import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      redirect: '/dashboard'
    },
    {
      path: '/dashboard',
      name: 'dashboard',
      component: () => import('../views/DashboardView.vue')
    },
    {
      path: '/seminare',
      name: 'seminare',
      component: () => import('../views/SeminareView.vue')
    },
    {
      path: '/students',
      name: 'students',
      component: () => import('../views/StudentsView.vue')
    },
    {
      path: '/theses',
      name: 'theses',
      component: () => import('../views/ThesesView.vue')
    },
    {
      path: '/chat',
      name: 'chat',
      component: () => import('../views/ChatView.vue')
    }
  ]
})

export default router
