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

void test() {
  SZEventBus ebus = SZEventBus();
  ebus.register('gogo', (info) { 
    print('gogo:${info}');
  });

  ebus.register('gogo', (info) { 
    print('gogo:${info}');
  });

  ebus.register('123', (info) { 
    print('123:${info}');
  });

  ebus.register('5', (info) { 
    print('5:${info}');
  });

  ebus.emit('gogo', '请接收消息了');
  ebus.emit('123', '请接收消息了');
  ebus.emit('5', '请接收消息了');

  ebus.unreister('5', null);

  ebus.emit('gogo', ['请接收消息了', 'message']);
  ebus.emit('123', '请接收消息了');
  ebus.emit('5', '请接收消息了');
}
