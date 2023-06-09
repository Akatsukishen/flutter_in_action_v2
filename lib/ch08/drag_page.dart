import 'package:flutter/material.dart';

/// 通过GestureDetector的 onPanXXX事件 来处理拖拽。
class DragPage extends StatefulWidget {
  const DragPage({Key? key}) : super(key: key);

  @override
  State<DragPage> createState() => _DragPageState();
}

class _DragPageState extends State<DragPage> {
  double _top = 100.0;
  double _left = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('拖拽事件'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: const CircleAvatar(
                child: Text('A'),
              ),
              onPanDown: (DragDownDetails e) {
                debugPrint("===> 拖拽起始位置:${e.globalPosition}");
              },
              onPanUpdate: (DragUpdateDetails e) {
                setState(() {
                  _left += e.delta.dx;
                  _top += e.delta.dy;
                });
              },
              onPanEnd: (DragEndDetails e) {
                debugPrint("===> 结束时速度: ${e.velocity}");
              },
            ),
          )
        ],
      ),
    );
  }
}
