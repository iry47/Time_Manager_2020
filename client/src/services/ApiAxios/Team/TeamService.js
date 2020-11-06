import Api from '@/services/ApiAxios/Api'

export default {
    index(search) {
        return Api().get('teams', {
            params: {
                search: search
            }
        })
    },
    get(teamId) {
        return Api().get(`teams/${teamId}`)
    },
    post(team) {
        return Api().post('teams', team)
    },
    put(team) {
        return Api().put(`teams/${team.id}`, team)
    },
    delete(teamId) {
        return Api().delete(`teams/${teamId}`)
    }
}