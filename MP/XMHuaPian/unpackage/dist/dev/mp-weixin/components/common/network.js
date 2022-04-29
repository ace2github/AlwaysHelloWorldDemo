"use strict";
var common_vendor = require("../../common/vendor.js");
const baseUrl = "https://res.allinstem.com/edu/";
function getRequest(path, headers = {}) {
  console.log(headers);
  return new Promise(function(resolve, reject) {
    common_vendor.index.request({
      url: baseUrl + path,
      header: headers,
      method: "GET",
      success: (res) => {
        console.log(res.data);
        resolve(res.data);
      },
      fail: (error) => {
        console.log(error);
        reject(error);
      }
    });
  });
}
exports.baseUrl = baseUrl;
exports.getRequest = getRequest;
