import 'dart:math';

import 'package:flutter/material.dart';

/// CustomPaint 组件通过自定义 绘制的区域Size和绘制的画笔Painter 来自定义绘制的内容。
/// Size 画布的大小
/// Painter 继承自CustomPainter ，实现抽象函数 paint(Canvas canvas, Size size)来绘制内容。
/// 
/// RepaintBoundary在绘制时创建一个新的绘制层，其子组件的绘制在新的层上面，而父组件在原来Layer上绘制
/// 也就是RepaintBoundary子组件的绘制与父组件隔离分开，相互独立
class CustomPaintPage extends StatelessWidget {
  const CustomPaintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('棋盘绘制'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RepaintBoundary( 
              child: CustomPaint(
                size: const Size(300, 300),
                painter: ChessPainter(),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('刷新'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChessPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    debugPrint("===> paint");
    var rect = Offset.zero & size;
    // 绘制棋盘
    drawChessBoard(canvas, rect);
    // 绘制旗子
    drawChessPiece(canvas, rect);
  }

  void drawChessBoard(Canvas canvas, Rect rect) {
    //棋盘背景
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = const Color(0xFFDCC48C);
    canvas.drawRect(rect, paint);

    //绘制棋盘风格
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.black38
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 15; ++i) {
      double dy = rect.top + rect.height / 15 * i;
      canvas.drawLine(Offset(rect.left, dy), Offset(rect.right, dy), paint);
    }

    for (int i = 0; i <= 15; ++i) {
      double dx = rect.left + rect.width / 15 * i;
      canvas.drawLine(Offset(dx, rect.top), Offset(dx, rect.bottom), paint);
    }
  }

  void drawChessPiece(Canvas canvas, Rect rect) {
    double eWidth = rect.width / 15.0;
    double eHeight = rect.height / 15.0;
    //画一个黑子
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;

    canvas.drawCircle(
      Offset(rect.center.dx - eWidth / 2, rect.center.dy - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );
    //画一个白子
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(rect.center.dx + eWidth / 2, rect.center.dy - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
