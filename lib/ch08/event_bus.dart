typedef EventCallback = void Function(Object arg);

class EventBus {
  EventBus._internal();

  static final EventBus _singleton = EventBus._internal();

  factory EventBus() => _singleton;

  final _emap = <Object, List<EventCallback>?>{};

  void on(eventName, EventCallback f) {
    _emap[eventName] ??= <EventCallback>[];
    _emap[eventName]!.add(f);
  }

  void off(eventName, [EventCallback? f]) {
    var list = _emap[eventName];
    if (eventName == null || list == null) {
      return;
    }
    if (f == null) {
      _emap[eventName] = null;
    } else {
      list.remove(f);
    }
  }

  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null) {
      return;
    }
    int len = list.length - 1;
    for (var i = len; i > -1; i--) {
      //反向遍历，防止订阅者在回调中移除自身带来的下标错位
      list[i](arg);
    }
  }
}

/// 定义top-level变量，页面引入该文件可以直接使用bus
var bus = EventBus();
