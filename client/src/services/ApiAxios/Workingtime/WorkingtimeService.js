import Api from '@/services/ApiAxios/Api'

export default {
    index(userId) {
        return Api().get(`workingtimes/${userId}`)
    },
    get(userId, workingtimeId) {
        return Api().get(`workingtimes/${userId}/${workingtimeId}`)
    },
    post(workingtime) {
        return Api().post('workingtimes', workingtime)
    },
    put(workingtime) {
        return Api().put(`workingtimes/${workingtime.id}`, workingtime)
    },
    delete(workingtimeId) {
        return Api().delete(`workingtimes/${workingtimeId}`)
    }
}