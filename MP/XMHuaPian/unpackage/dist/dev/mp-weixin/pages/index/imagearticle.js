"use strict";
var common_vendor = require("../../common/vendor.js");
var components_common_network = require("../../components/common/network.js");
const _sfc_main = {
  data() {
    return {
      imageList: [],
      shareText: "\u53A6\u95E8\u5B66\u6821\u5212\u7247\u4FE1\u606F"
    };
  },
  methods: {
    previewPhoto(index) {
      if (index < this.imageList.length) {
        common_vendor.index.previewImage({
          urls: this.imageList,
          current: this.imageList[index]
        });
      }
    }
  },
  onLoad(arg) {
    this.shareText = arg.share || "\u53A6\u95E8\u5B66\u6821\u5212\u7247\u4FE1\u606F";
    common_vendor.index.setNavigationBarTitle({
      title: this.shareText
    });
    let imgs = JSON.parse(arg.d || []);
    for (var i = 0; i < imgs.length; i++) {
      let key = imgs[i];
      if (key && key.length) {
        if (key.length > 4 && key.substring(0, 4) == "http") {
          this.imageList.push(key);
        } else {
          this.imageList.push(components_common_network.baseUrl + key);
        }
      }
    }
    console.log(this.imageList);
  },
  onShareAppMessage(obj) {
    return {
      title: this.shareText
    };
  },
  onShareTimeline(obj) {
    return {
      title: this.shareText
    };
  }
};
function _sfc_render(_ctx, _cache, $props, $setup, $data, $options) {
  return {
    a: common_vendor.f($data.imageList, (img, index, i0) => {
      return {
        a: img,
        b: common_vendor.o(($event) => $options.previewPhoto(index))
      };
    })
  };
}
var MiniProgramPage = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["render", _sfc_render], ["__scopeId", "data-v-0553fcde"], ["__file", "/Users/chaohuichen/Documents/GitWorkSpace/MineCustom/MP/XMHuaPian/pages/index/imagearticle.vue"]]);
_sfc_main.__runtimeHooks = 6;
wx.createPage(MiniProgramPage);
