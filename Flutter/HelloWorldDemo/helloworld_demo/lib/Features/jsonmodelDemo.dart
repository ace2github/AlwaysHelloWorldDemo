import 'dart:convert';

void testJsonModel() {
  String jsonStr = '[{"name":"Jack"},{"name":"Rose"}]';
  List items = json.decode(jsonStr);
  print(items[0]["name"]);

  print('to jsonstr: ${json.encode(items)}');
}