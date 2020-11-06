import Api from '@/services/Api'

export default {
    index() {
        return Api().get('widgetusers');
    },
    getWidgetUser(widgetId) {
        return Api().get(`widgetusers/${widgetId}`);
    },
    getUserWidget(userId) {
        return Api().get(`userwidgets/${userId}`);
    },
    post(widgetUser) {
        return Api().post('widgetusers', widgetUser);
    },
    delete(widgetUserId) {
        return Api().delete(`widgetusers/${widgetUserId}`);
    },
    put(widgetUser) {
        return Api().put(`widgetusers/${widgetUser.id}`, widgetUser)
    }
}