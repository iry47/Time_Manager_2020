import Vue from 'vue'
import Router from 'vue-router'
/* HOME */
import Home from '@/components/Main/Home'
/* AUTHEN */
import Register from '@/components/Main/Register'
import SignIn from '@/components/Main/SignIn'
/* DASHBOARD */
import Dashboard from '@/components/Dashboard/Index'
/* SETTINGS */
import Settings from '@/components/Settings/Index'
/* USER */
import UserCreate from '@/components/Dashboard/Admin/Manage/UserCreate'
import UserEdit from '@/components/Dashboard/Admin/Manage/UserEdit'
import UserView from '@/components/Dashboard/Admin/UserView/Index'
/* TEAM */
import Teams from '@/components/Dashboard/Manager/Index'
import TeamView from '@/components/Dashboard/Manager/Team/TeamView'
import TeamEdit from '@/components/Dashboard/Manager/Team/Manage/TeamEdit'
import TeamCreate from '@/components/Dashboard/Manager/Team/Manage/TeamCreate'

Vue.use(Router)

export default new Router({
    hashbang: false,
    hash: false,
    routes: [{
            path: '*',
            redirect: '/'
        },
        {
            path: '/',
            name: 'home',
            component: Home
        },
        {
            path: '/register',
            name: 'register',
            component: Register
        },
        {
            path: '/signin',
            name: 'signin',
            component: SignIn
        },
        {
            path: '/settings',
            name: 'settings',
            component: Settings
        },
        {
            path: '/dashboard',
            name: 'dashboard',
            component: Dashboard
        },
        {
            path: '/teams',
            name: 'teams',
            component: Teams
        },
        {
            path: '/teams/:teamId',
            name: 'team',
            component: TeamView
        },
        {
            path: '/teams/create',
            name: 'team-create',
            component: TeamCreate
        },
        {
            path: '/teams/edit/:teamId',
            name: 'team-edit',
            component: TeamEdit
        },
        {
            path: '/users/:userId',
            name: 'user',
            component: UserView
        },
        {
            path: '/users/create',
            name: 'user-create',
            component: UserCreate
        },
        {
            path: '/users/edit/:userId',
            name: 'edit-user',
            component: UserEdit
        }
    ]
})