"use strict";
var common_vendor = require("../../common/vendor.js");
var components_common_network = require("../../components/common/network.js");
var components_common_tools = require("../../components/common/tools.js");
var _imports_0 = "/static/icon_arrow.png";
const _sfc_main = {
  data() {
    return {
      newList: []
    };
  },
  methods: {
    cellClickHandler(index) {
      var item = this.newList[index];
      common_vendor.index.navigateTo({
        url: "../index/imagearticle?d=" + JSON.stringify(item.imgs) + "&share=" + item.title
      });
    },
    startRequestNewList(isRefresh) {
      components_common_tools.showLoading(true);
      let time = parseInt(new Date().getTime() / 1e3 / 60 / 5);
      components_common_network.getRequest("plan?" + time, { "Cache-Control": "no-cache, max-age=360" }).then((response) => {
        let res = response.plan;
        this.newList = res.articleList;
        console.log(this.newList);
        components_common_tools.showLoading(false);
      }).catch((e) => {
        components_common_tools.showLoading(false);
      });
    }
  },
  onLoad() {
    this.startRequestNewList(true);
  },
  onReachBottom() {
  },
  onPullDownRefresh() {
  },
  onShareAppMessage(obj) {
    return {
      title: "\u53A6\u95E8\u5E7C\u513F\u56ED\u3001\u5C0F\u5B66\u3001\u521D\u4E2D\u5212\u7247\u8D44\u8BAF~~~"
    };
  },
  onShareTimeline(obj) {
    return {
      title: "\u53A6\u95E8\u5E7C\u513F\u56ED\u3001\u5C0F\u5B66\u3001\u521D\u4E2D\u5212\u7247\u8D44\u8BAF~~~"
    };
  }
};
function _sfc_render(_ctx, _cache, $props, $setup, $data, $options) {
  return {
    a: common_vendor.f($data.newList, (item, index, i0) => {
      return {
        a: common_vendor.t(item.title),
        b: common_vendor.o(($event) => $options.cellClickHandler(index))
      };
    }),
    b: _imports_0
  };
}
var MiniProgramPage = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["render", _sfc_render], ["__scopeId", "data-v-7671f29d"], ["__file", "/Users/chaohuichen/Documents/GitWorkSpace/MineCustom/MP/XMHuaPian/pages/index/planlist.vue"]]);
_sfc_main.__runtimeHooks = 6;
wx.createPage(MiniProgramPage);
