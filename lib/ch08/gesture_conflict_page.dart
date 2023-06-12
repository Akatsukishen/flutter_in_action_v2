import 'package:flutter/material.dart';

class GestureConflictPage extends StatefulWidget {
  const GestureConflictPage({super.key});

  @override
  State<StatefulWidget> createState() => _GestureConflictPageState();
}

class _GestureConflictPageState extends State<GestureConflictPage> {
  double _leftA = 200.0;
  double _leftB = 100.0;
  double _top = 200.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('多手势冲突'),
      ),
      body: Stack(
        children: [
          Positioned(
            left: _leftA,
            top: _top,
            child: GestureDetector(
              child: const CircleAvatar(child: Text('A')),
              onTapDown: (detail) {
                debugPrint("===> onTapDown");
              },
              onTapUp: (details) {
                /// 在抬起手势时，onTapUp和onHorizontalDragEnd发生冲突，
                /// 如果前面拖动了的话，那么手势竞争失败，此处不会输出
                /// 相反，如果只是点击，那么手势竞争胜出，此处输出
                debugPrint("===> onTapUp");
              },
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _leftA += details.delta.dx;
                });
              },
              onHorizontalDragEnd: (details) {
                debugPrint("===> onHorizontalDragEnd");
              },
            ),
          ),
          Positioned(
            left: _leftB,
            top: 100,
            child: Listener( //包一个Listener 保证处理【onPointerUp】事件
              onPointerDown: (e) {
                debugPrint("===> onPointerDown");
              },
              onPointerUp: (e) {
                debugPrint("===> onPointerUp");
              },
              child: GestureDetector(
                child: const CircleAvatar(child: Text('B')),
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    _leftB += details.delta.dx;
                  });
                },
                onHorizontalDragEnd: (details) {
                  debugPrint("===> B onHorizontalDragEnd.");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
