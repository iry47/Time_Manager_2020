import axios from 'axios'
import store from '@/store/store'

export default () => {
    return axios.create({
        baseURL: 'http://production-tm-server-elb-113094160.eu-west-2.elb.amazonaws.com/',
        headers: {
            Authorization: `Bearer ${store.state.token}`
        }
    })
}