"use strict";
var common_vendor = require("../../common/vendor.js");
function showLoading(show, title) {
  if (show) {
    common_vendor.index.showLoading({
      title: title ? title : "\u52A0\u8F7D\u4E2D..."
    });
  } else {
    common_vendor.index.hideLoading();
  }
}
exports.showLoading = showLoading;
