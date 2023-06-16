import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

class CustomCheckBoxPage extends StatefulWidget {
  const CustomCheckBoxPage({super.key});

  @override
  State<CustomCheckBoxPage> createState() => _CustomCheckBoxPageState();
}

class _CustomCheckBoxPageState extends State<CustomCheckBoxPage> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('大小可定义的自定义checkbox'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCheckBox(
              value: _checked,
              onChanged: _onChange,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                width: 16,
                height: 16,
                child: CustomCheckBox(
                  strokeWidth: 1,
                  radius: 1,
                  value: _checked,
                  onChanged: _onChange,
                ),
              ),
            ),
            SizedBox(
              width: 30,
              height: 30,
              child: CustomCheckBox(
                strokeWidth: 3,
                radius: 3,
                value: _checked,
                onChanged: _onChange,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onChange(value) {
    setState(() {
      _checked = value;
    });
  }
}

class CustomCheckBox extends LeafRenderObjectWidget {
  const CustomCheckBox(
      {Key? key,
      this.strokeWidth = 2.0,
      this.value = false,
      this.strokeColor = Colors.white,
      this.fillColor = Colors.blue,
      this.radius = 2.0,
      this.onChanged})
      : super(key: key);

  final double strokeWidth;
  final Color strokeColor;
  final Color? fillColor;
  final bool value;
  final double radius;
  final ValueChanged<bool>? onChanged;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomCheckBox(
        value: value,
        strokeWidth: strokeWidth,
        strokeColor: strokeColor,
        fillColor: fillColor ?? Theme.of(context).primaryColor,
        radius: radius);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderCustomCheckBox renderObject) {
    if (renderObject.value != value) {
      renderObject.animationStatus =
          value ? AnimationStatus.forward : AnimationStatus.reverse;
    }

    renderObject
      ..strokeWidth = strokeWidth
      ..strokeColor = strokeColor
      ..fillColor = fillColor ?? Theme.of(context).primaryColor
      ..radius = radius
      ..value = value
      ..onChanged = onChanged;
  }
}

class RenderCustomCheckBox extends RenderBox with RenderObjectMixin {
  RenderCustomCheckBox({
    required this.value,
    required this.strokeWidth,
    required this.strokeColor,
    required this.fillColor,
    required this.radius,
    this.onChanged,
    this.pointerId = -1,
  }) {
    progress = value ? 1 : 0;
  }

  bool value;
  int pointerId;
  double strokeWidth;
  Color strokeColor;
  Color fillColor;
  double radius;
  ValueChanged<bool>? onChanged;

  /// 背景动画时间占比 （背景动画要在前40%的时间内执行完毕,之后执行打勾动画）
  final double bgAnimationInterval = .4;

  @override
  bool get isRepaintBoundary => true;

  @override
  void performLayout() {
    size = constraints
        .constrain(constraints.isTight ? Size.infinite : const Size(25, 25));
  }

  @override
  void doPaint(PaintingContext context, Offset offset) {
    Rect rect = offset & size;
    _drawBackground(context, rect);
    _drawCheckMask(context, rect);
  }

  void _drawBackground(PaintingContext context, Rect rect) {
    Color color = value ? fillColor : Colors.grey;
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;

    // 我们需要算出每一帧里面矩形的大小，为此我们可以直接根据矩形插值方法来确定里面矩形
    //radius四角的角度
    final outer = RRect.fromRectXY(rect, radius, radius);
    var rects = [
      rect.inflate(-strokeWidth),
      Rect.fromCenter(center: rect.center, width: 0, height: 0)
    ];

    var rectProgress = Rect.lerp(rects[0], rects[1],
        min(progress, bgAnimationInterval) / bgAnimationInterval);

    final inner = RRect.fromRectXY(rectProgress!, 0, 0);

    context.canvas.drawDRRect(outer, inner, paint);
  }

  void _drawCheckMask(PaintingContext context, Rect rect) {
    // 在画好背景后再画前景
    if (progress > bgAnimationInterval) {
      // 确定中间拐点位置
      final secondOffset =
          Offset(rect.left + rect.width / 2.5, rect.bottom - rect.height / 4);

      final lastOffset =
          Offset(rect.right - rect.width / 6, rect.top + rect.height / 4);

      final _lastOffset = Offset.lerp(
        secondOffset,
        lastOffset,
        (progress - bgAnimationInterval) / (1 - bgAnimationInterval),
      );

      ///将三个点连起来
      final path = Path()
        ..moveTo(rect.left + rect.width / 7, rect.top + rect.height / 2)
        ..lineTo(secondOffset.dx, secondOffset.dy)
        ..lineTo(_lastOffset!.dx, _lastOffset.dy);

      final paint = Paint()
        ..isAntiAlias = true
        ..style = PaintingStyle.stroke
        ..color = strokeColor
        ..strokeWidth = strokeWidth;

      context.canvas.drawPath(path, paint);
    }
  }

  //只有通过命中测试 才能响应点击事件
  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, covariant BoxHitTestEntry entry) {
    if (event.down) {
      pointerId = event.pointer;
    } else if (event.pointer == pointerId) {
      // 手指抬起时触发回调
      if (size.contains(event.localPosition)) {
        onChanged?.call(!value);
      }
    }
  }
}

mixin RenderObjectMixin on RenderObject {
  double _progress = 0;
  int? _lastTimeStamp;

  Duration get duration => const Duration(milliseconds: 800);

  AnimationStatus _animationStatus = AnimationStatus.completed;

  //设置动画状态
  set animationStatus(AnimationStatus v) {
    if (_animationStatus != v) {
      markNeedsPaint();
    }
    _animationStatus = v;
  }

  double get progress => _progress;
  set progress(double v) {
    _progress = v.clamp(0.0, 1.0);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    doPaint(context, offset);
    _scheduleAnimation();
  }

  void doPaint(PaintingContext context, Offset offset);

  void _scheduleAnimation() {
    if (_animationStatus != AnimationStatus.completed) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        if (_lastTimeStamp != null) {
          double delta = (timeStamp.inMilliseconds - _lastTimeStamp!) /
              duration.inMilliseconds;
          //可能在一帧中连续的往frameCallback中添加了多次
          if (delta == 0) {
            markNeedsPaint();
            return;
          }
          if (_animationStatus == AnimationStatus.reverse) {
            delta = -delta;
          }
          _progress = _progress + delta;
          if (progress >= 1 || _progress <= 0) {
            _animationStatus = AnimationStatus.completed;
            _progress = _progress.clamp(0.0, 1.0);
          }
          markNeedsPaint();
          _lastTimeStamp = timeStamp.inMilliseconds;
        }
        markNeedsPaint();
        _lastTimeStamp = timeStamp.inMilliseconds;
      });
    }
  }
}
