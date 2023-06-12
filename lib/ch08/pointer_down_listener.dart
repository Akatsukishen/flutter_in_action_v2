import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PointerDownPage extends StatelessWidget {
  const PointerDownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('down事件监听'),
      ),
      body: Center(
        child: PointerDownListener(
          child: const Text(
            '点击我',
            style: TextStyle(fontSize: 30),
          ),
          onPointerDown: (event) {
            debugPrint("===> down");
          },
        ),
      ),
    );
  }
}

class PointerDownListener extends SingleChildRenderObjectWidget {
  const PointerDownListener({Key? key, this.onPointerDown, Widget? child})
      : super(key: key, child: child);

  final PointerDownEventListener? onPointerDown;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderPointerDownLisntener()..onPointerDown = onPointerDown;
  }
}

/// 始终通过命中测试，所以在PointerDown事件分发的过程中，始终可以回调OnPointerDown
///
class _RenderPointerDownLisntener extends RenderProxyBox {
  PointerDownEventListener? onPointerDown;

  @override
  bool hitTestSelf(Offset position) => true; //始终通过命中测试

  @override
  void handleEvent(PointerEvent event, covariant HitTestEntry entry) {
    if (event is PointerDownEvent) {
      onPointerDown?.call(event);
    }
  }
}
