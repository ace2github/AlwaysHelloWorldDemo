import 'package:flutter/material.dart';

class HttpConfig {
  static String baseUrl = "";
  static const timeout = 5000;

  static realUrl(String uri) {
    return baseUrl + uri;
  }
}

class HttpMethods {
  static const String post = "post";
  static const String get = "get";
}
