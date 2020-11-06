import Api from '@/services/ApiAxios/Api'

export default {
    index() {
        return Api().get('teamusers');
    },
    getTeamUser(teamId) {
        return Api().get(`teamusers/${teamId}`);
    },
    getUserTeam(userId) {
        return Api().get(`userteams/${userId}`);
    },
    post(teamuser) {
        return Api().post('teamusers', teamuser);
    },
    put(teamuser) {
        return Api().put(`teamusers/${teamuser.id}`, teamuser)
    },
    delete(teamuserId) {
        return Api().delete(`teamusers/${teamuserId}`);
    }
}