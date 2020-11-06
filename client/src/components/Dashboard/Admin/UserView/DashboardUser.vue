<template>
  <div class="demo">
    <v-switch large color="red" v-model="active" label="Modify Grid">
      <template v-slot:prepend>
        <v-tooltip bottom>
          <template v-slot:activator="{ on }">
            <v-icon v-on="on">help</v-icon>
          </template>
          Dragging / Resizing / Pushing / Margin
        </v-tooltip>
      </template>
    </v-switch>
    <div v-if="active">
      <input type="checkbox" v-model="options.draggable.enabled" />Drag
      <input type="checkbox" v-model="options.resizable.enabled" />Resize
      <input type="checkbox" v-model="options.pushing" />Push
      <input type="checkbox" v-model="options.floating" />Float
      <input type="checkbox" v-model="options.swapping" />Swap
      <select v-model="options.mobileBreakPoint">
        <option :value="600">600</option>
        <option :value="Number.MAX_VALUE">MAX</option>
        <option :value="Number.MIN_VALUE">MIN</option>
      </select>
      Margin
      <input type="text" v-model.number="options.margins[0]" size="2" />x
      <input type="text" v-model.number="options.margins[1]" size="2" />
    </div>
    <gridster :options="options">
      <gridster-item v-for="(item, index) in items" :item="item" :key="index">
        <!-- 0 to 4 depending on size array items -->
        <widget-badge class="widget" v-if="index === 0"></widget-badge>
        <widget-workinghour class="widget" v-if="index === 1"></widget-workinghour>
        <graph-one class="widget" v-if="index === 2"></graph-one>
        <graph-two class="widget" v-if="index === 3"></graph-two>
      </gridster-item>
    </gridster>
  </div>
</template>

<script>
import { mapState } from "vuex";
/* ####################################################################### */
/* GRIDSTER */
import "@/components/Vuegridster/css/vue-gridster.css";
import Gridster from "@/components/Vuegridster/vue-gridster.vue";
import GridsterItem from "@/components/Vuegridster/vue-gridster-item.vue";
/* ####################################################################### */
/* SERVICE */
// import User from "@/services/ApiAxios/User/UserService";
// import Service from "@/services/ApiAxios/Service/Service";
// import ServiceUser from "@/services/ApiAxios/Service/ServiceUser";
// import ServiceWidget from "@/services/ApiAxios/Service/ServiceWidget";
// import WidgetUser from "@/services/ApiAxios/Widget/WidgetUser";
// import Widget from "@/services/ApiAxios/Widget/Widget";
/* ####################################################################### */
/* WIDGET */
import GraphOne from '@/components/Dashboard/Admin/UserView/Widgets/GraphOne';
import GraphTwo from '@/components/Dashboard/Admin/UserView/Widgets/GraphTwo';
import WidgetBadge from '@/components/Dashboard/Admin/UserView/Widgets/WidgetBadge';
import WidgetWorkinghour from '@/components/Dashboard/Admin/UserView/Widgets/WidgetWorkinghour';

export default {
  computed: {
    ...mapState(["isUserLoggedIn", "user", "servicesUser", "servicesActive", "admin", "manager", "dark", "grad"])
  },
  components: {
    Gridster,
    GridsterItem,
    GraphOne,
    GraphTwo,
    WidgetBadge,
    WidgetWorkinghour
  },
  data() {
    return {
      userview: null,
      services: null,
      servicesWidgets: null,
      servicesUsers: null,
      widgetsUsers: null,
      widgets: null,
      active: false,
      items: [
        { sizeX: 2, sizeY: 2, row: 0, col: 0 },
        { sizeX: 2, sizeY: 2, row: 0, col: 2 },
        { sizeX: 2, sizeY: 2, row: 4, col: 0 },
        { sizeX: 2, sizeY: 2, row: 4, col: 2 }
      ],
      options: {
        margins: [10, 10],
        isMobile: false,
        pushing: true,
        floating: true,
        swapping: false,
        mobileBreakPoint: 1000,
        draggable: { enabled: true },
        resizable: { enabled: true }
      }
    };
  },
  watch: {
    active: async function() {
      if (this.active) {
        this.userview.gridster = true;
        await User.put(this.userview);
      } else {
        this.userview.gridster = false;
        await User.put(this.userview);
        this.options.draggable.enabled = false;
        this.options.resizable.enabled = false;
        this.options.pushing = false;
        this.options.floating = false;
        this.options.swapping = false;
      }
    }
  },
  methods: {},
  async mounted() {
    this.options.draggable.enabled = false;
    this.options.resizable.enabled = false;
    this.options.pushing = false;
    this.options.floating = false;
    this.options.swapping = false;
    this.userview = (await User.getUser(this.user.id)).data;
    if (this.userview.gridster) {
      this.active = true;
    }
    this.services = (await Service.index()).data;
    this.servicesUsers = (await ServiceUser.getUserService(this.user.id)).data;
    this.servicesWidgets = (await ServiceWidget.index()).data;
    this.widgets = (await Widget.index()).data;
    this.widgetsUsers = (await WidgetUser.getUserWidget(this.user.id)).data;
  }
};
</script>
<style>
demo {
  font-family: "Helvetica Neue", Arial, sans-serif;
  background: black;
  color: #fff;
  margin: 100px;
}

.widget {
  height: 100%;
  width: 100%;
}

.gridster .gridster-item {
  -webkit-box-shadow: 0 0 5px rgba(0, 0, 0, 0.3);
  -moz-box-shadow: 0 0 5px rgba(0, 0, 0, 0.3);
  box-shadow: 0 0 5px rgba(0, 0, 0, 0.3);
  color: black;
  background: whitesmoke;
  padding: 10px;
}
</style>
