import 'package:flutter/material.dart';

import 'custom_check_box_page.dart';

class DoneWidgetPage extends StatefulWidget {
  const DoneWidgetPage({super.key});

  @override
  State<DoneWidgetPage> createState() => _DoneWidgetPageState();
}

class _DoneWidgetPageState extends State<DoneWidgetPage> {
  var _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义done组件'),
      ),
      body: Center(
        child: Column(
          key: ValueKey(_color),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const DoneWidget(),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 40,
              height: 40,
              child: DoneWidget(
                color: _color,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 40,
              height: 40,
              child: DoneWidget(
                color: _color,
                outline: true,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _color =
                      Colors.blue == _color ? Colors.deepOrange : Colors.blue;
                });
              },
              child: const Text('刷新'),
            ),
          ],
        ),
      ),
    );
  }
}

class DoneWidget extends LeafRenderObjectWidget {
  final double strokeWidth;
  final Color color;
  final bool outline;

  const DoneWidget(
      {super.key,
      this.strokeWidth = 2.0,
      this.color = Colors.green,
      this.outline = false});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderDoneObject(strokeWidth, color, outline)..animationStatus=AnimationStatus.forward;
  }

  @override
  void updateRenderObject(BuildContext context, RenderDoneObject renderObject) {
    renderObject
      ..strokeWidth = strokeWidth
      ..outline = outline
      ..color = color;
  }
}

class RenderDoneObject extends RenderBox with RenderObjectAnimationMixin {
  double strokeWidth;
  Color color;
  bool outline;

  ValueChanged<bool>? onChanged;

  RenderDoneObject(this.strokeWidth, this.color, this.outline);

  @override
  Duration get duration => const Duration(milliseconds: 300);

  @override
  void doPaint(PaintingContext context, Offset offset) {
    Curve curve = Curves.easeIn;

    final _progress = curve.transform(progress);

    Rect rect = offset & size;
    final paint = Paint()
      ..isAntiAlias = true
      ..style = outline ? PaintingStyle.stroke : PaintingStyle.fill
      ..color = color;

    if (outline) {
      paint.strokeWidth = strokeWidth;
      rect = rect.deflate(strokeWidth);
    }

    //画背景图
    context.canvas.drawCircle(rect.center, rect.shortestSide / 2, paint);

    paint
      ..style = PaintingStyle.stroke
      ..color = outline ? color : Colors.white
      ..strokeWidth = strokeWidth;

    final path = Path();

    Offset firstOffset =
        Offset(rect.left + rect.width / 6, rect.top + rect.height / 2.1);

    final secondOffset =
        Offset(rect.left + rect.width / 2.5, rect.bottom - rect.height / 3.3);

    path.moveTo(firstOffset.dx, firstOffset.dy);

    const adjustProgress = .6;

    if (_progress < adjustProgress) {
      Offset animSecondOffset =
          Offset.lerp(firstOffset, secondOffset, _progress / adjustProgress)!;
      path.lineTo(animSecondOffset.dx, animSecondOffset.dy);
    } else {
      path.lineTo(secondOffset.dx, secondOffset.dy);

      final lastOffset =
          Offset(rect.right - rect.width / 5, rect.top + rect.height / 3.5);

      Offset animLastOffset = Offset.lerp(secondOffset, lastOffset,
          (progress - adjustProgress) / (1 - adjustProgress))!;
      path.lineTo(animLastOffset.dx, animLastOffset.dy);
    }

    context.canvas.drawPath(path, paint..style = PaintingStyle.stroke);
  }

  @override
  void performLayout() {
    size = constraints
        .constrain(constraints.isTight ? Size.infinite : const Size(25, 25));
  }
}
