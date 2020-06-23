import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import CyaHome from '@/components/CyaHome'
import CyaBranch from '@/components/CyaBranch'
import CyaDept from '@/components/CyaDept'
import CyaStaff from '@/components/CyaStaff'
import CyaCustomer from '@/components/CyaCustomer'
import CyaAccount from '@/components/CyaAccount'
import CyaLoan from '@/components/CyaLoan'
import CyaStat from '@/components/CyaStat'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/test',
      name: 'HelloWorld',
      component: HelloWorld
    },
    {
      path: '/home',
      name: 'CyaHome',
      component: CyaHome
    },
    {
      path: '/branch',
      name: 'CyaBranch',
      component: CyaBranch
    },
    {
      path: '/dept',
      name: 'CyaDept',
      component: CyaDept
    },
    {
      path: '/staff',
      name: 'CyaStaff',
      component: CyaStaff
    },
    {
      path: '/customer',
      name: 'CyaCustomer',
      component: CyaCustomer
    },
    {
      path: '/account',
      name: 'CyaAccount',
      component: CyaAccount
    },
    {
      path: '/loan',
      name: 'CyaLoan',
      component: CyaLoan
    },
    {
      path: '/stat',
      name: 'CyaStat',
      component: CyaStat
    }
  ]
})
