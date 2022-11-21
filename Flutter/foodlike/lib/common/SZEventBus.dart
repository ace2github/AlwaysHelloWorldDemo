///
/// 简易事件总线，非线程安全，有待补充
///

// 事件回调函数
typedef void SZEventCallBackHandler(info);

class SZEventBus {
  SZEventBus._internal(); // 私有构造函数
  // 构造单例模式
  static SZEventBus _singleton = SZEventBus._internal();
  factory SZEventBus() => _singleton;

  var _eventMap = Map<Object, List<SZEventCallBackHandler>>();

  void register(name, SZEventCallBackHandler handler) {
    if (null == name || null == handler) return;

    _eventMap[name] ??= <SZEventCallBackHandler>[];
    _eventMap[name]!.add(handler);
  }

  void unreister(name, SZEventCallBackHandler? handler) {
    if (null == name) return;

    var list = _eventMap[name];
    if (null == list) return;

    if (null == handler) {
      _eventMap.remove(name);
    } else {
      list.remove(handler);
    }
  }

  void emit(name, info) {
    if (null == name) return;

    var list = _eventMap[name];
    if (null == list) return;
    list.forEach((element) {
      element(info);
    });
  }
}
