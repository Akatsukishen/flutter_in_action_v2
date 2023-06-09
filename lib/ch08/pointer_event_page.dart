import 'package:flutter/material.dart';

/// event.localPosition 触摸点相对于【down控件左上角坐标的距离】
/// 如下示例中，如果先触摸了蓝色区域，那down控件就是蓝色的Container
/// 后续一直滑动，滑动的event.localPosition都是相对于 蓝色的Container左上角的距离，哪怕已经滑出Container的区域
///
/// event.position 是相对于屏幕右上角的全局距离
/// 
/// AbsorbPointer 和 IgnorePointer 都阻止 【子组件】触发触摸事件。
/// 不过 AbsorbPointer在子组件不能获得事件的情况下，自己是可以触发触摸事件的
/// 但是 IgnorePointer做的更狠，在子组件不能获得事件的情况下，自己也不触发触摸事件。
///
class PointerEventPage extends StatefulWidget {
  const PointerEventPage({Key? key}) : super(key: key);

  @override
  State<PointerEventPage> createState() => _PointerEventPageState();
}

class _PointerEventPageState extends State<PointerEventPage> {
  PointerEvent? _event;
  bool? absorbPointerChild;
  bool? absorbPointer;

  bool? ignorePointerChild;
  bool? ignorePointer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('事件监听'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Listener(
              child: Container(
                color: Colors.blue,
                width: 300,
                height: 150,
                alignment: Alignment.center,
                child: Text(
                  //localPosition 触摸点相对于组件左上角的位置
                  '${_event?.localPosition ?? ''} — ${_event?.position ?? ''}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              onPointerDown: (PointerDownEvent event) {
                setState(() {
                  _event = event;
                });
              },
              onPointerMove: (PointerMoveEvent event) {
                setState(() {
                  _event = event;
                });
              },
              onPointerUp: (PointerUpEvent event) {
                setState(() {
                  _event = event;
                });
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Listener(
              child: AbsorbPointer(
                child: Listener(
                  child: Container(
                    color: Colors.red,
                    width: 300,
                    height: 150,
                    alignment: Alignment.center,
                    child: Text(
                      true == absorbPointerChild ? '子控件触摸事件' : (true == absorbPointer ? 'absorbPointer触摸事件' : '' ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  onPointerDown: (PointerDownEvent event) {
                    debugPrint("===> AbsorbPointer child down event");
                    setState(() {
                      absorbPointerChild = true;
                    });
                  },
                ),
              ),
              onPointerDown: (PointerDownEvent event) {
                debugPrint("===> AbsorbPointer down event");
                setState(() {
                  absorbPointer = true;
                });
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Listener(
              child: IgnorePointer(
                child: Listener(
                  child: Container(
                    color: Colors.green,
                    width: 300,
                    height: 150,
                    alignment: Alignment.center,
                    child: Text(
                      true == ignorePointerChild ? '子控件触摸事件' : (true == ignorePointer ? 'ignorePointer触摸事件' : '' ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  onPointerDown: (PointerDownEvent event) {
                    debugPrint("===> IgnorePointer child down event");
                    setState(() {
                      ignorePointerChild = true;
                    });
                  },
                ),
              ),
              onPointerDown: (PointerDownEvent event) {
                debugPrint("===> IgnorePointer down event");
                setState(() {
                  ignorePointer = true;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
