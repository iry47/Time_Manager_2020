import Api from '@/services/ApiAxios/Api'

export default {
    index(search) {
        return Api().get('widgets', {
            params: {
                search: search
            }
        })
    },
    get(widgetId) {
        return Api().get(`widgets/${widgetId}`);
    },
    post(widget) {
        return Api().post('widgets', widget)
    },
    put(widget) {
        return Api().put(`widgets/${widget.id}`, widget)
    },
    delete(widgetId) {
        return Api().delete(`widgets/${widgetId}`)
    }
}