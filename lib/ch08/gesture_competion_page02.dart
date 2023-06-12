import 'package:flutter/material.dart';

/// 此示例中设置了两个监听【onVerticalDragUpdate】和 【onHorizontalDragUpdate】
/// 在滑动的过程中两者存在【竞争】，
/// 且在第一次滑动的过程中 水平方向 和 竖直方向 滑动距离【较大者】胜出，
/// 此后一直由【胜出者】处理后续滑动事件。
class GestureCompetionPage02 extends StatefulWidget {
  const GestureCompetionPage02({super.key});

  @override
  State<GestureCompetionPage02> createState() => _GestureCompetionPage02State();
}

class _GestureCompetionPage02State extends State<GestureCompetionPage02> {
  var _top = 200.0;
  var _left = 200.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('手势竞争02'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: const CircleAvatar(child: Text('A')),
              onVerticalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _top += details.delta.dy;
                  _left += details.delta.dx;
                });
              },
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _top += details.delta.dy;
                  _left += details.delta.dx;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
