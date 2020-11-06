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
import UserService from "@/services/User/UserService";
import TeamService from "@/services/Team/TeamService";
import TeamUserService from "@/services/Team/TeamUserService";
import WidgetService from "@/services/Widget/WidgetService";
import WidgetUserService from "@/services/Widget/WidgetUserService";
import WorkingtimeService from "@/services/Workingtime/WorkingtimeService";
/* ####################################################################### */
/* WIDGET */
import GraphOne from '@/components/Dashboard/Employee/Widgets/GraphOne';
import GraphTwo from '@/components/Dashboard/Employee/Widgets/GraphTwo';
import WidgetBadge from '@/components/Dashboard/Employee/Widgets/WidgetBadge';
import WidgetWorkinghour from '@/components/Dashboard/Employee/Widgets/WidgetWorkinghour';

export default {
  computed: {
    ...mapState(["isUserLoggedIn", "user", "admin", "manager", "dark", "grad"])
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
      await UserService.put(this.userview);
      this.userview.gridster = this.active;
      await UserService.put(this.userview);
      this.options.draggable.enabled = false;
      this.options.resizable.enabled = false;
      this.options.pushing = false;
      this.options.floating = false;
      this.options.swapping = false;
    }
  },
  methods: {},
  async mounted() {
    this.options.draggable.enabled = false;
    this.options.resizable.enabled = false;
    this.options.pushing = false;
    this.options.floating = false;
    this.options.swapping = false;
    this.userview = (await UserService.get(this.user.id)).data;
    if (this.userview.gridster) {
      this.active = true;
    }
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
