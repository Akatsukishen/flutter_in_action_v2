import 'dart:math';

import 'package:flutter/material.dart';

class GradientCircularIndicatorPage extends StatefulWidget {
  const GradientCircularIndicatorPage({super.key});

  @override
  State<GradientCircularIndicatorPage> createState() =>
      _GradientCircularIndicatorPageState();
}

class _GradientCircularIndicatorPageState
    extends State<GradientCircularIndicatorPage> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    bool isForward = true;
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      } else if (status == AnimationStatus.reverse) {
        isForward = false;
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义渐变进度条'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        children: [
                          Wrap(
                            spacing: 10.0,
                            runSpacing: 16.0,
                            children: [
                              GradientCircularIndicator(
                                  radius: 50.0,
                                  colors: const [Colors.blue, Colors.blue],
                                  strokeWidth: 3.0,
                                  value: _animationController.value),
                              GradientCircularIndicator(
                                  radius: 50.0,
                                  colors: const [Colors.red, Colors.orange],
                                  strokeWidth: 3.0,
                                  value: _animationController.value),
                              GradientCircularIndicator(
                                  radius: 50.0,
                                  colors: const [
                                    Colors.red,
                                    Colors.orange,
                                    Colors.red
                                  ],
                                  strokeWidth: 5.0,
                                  value: _animationController.value),
                              GradientCircularIndicator(
                                  radius: 50.0,
                                  colors: const [Colors.teal, Colors.cyan],
                                  strokeWidth: 5.0,
                                  strokeCapRound: true,
                                  value: CurvedAnimation(
                                          parent: _animationController,
                                          curve: Curves.decelerate)
                                      .value),
                              RotatedBox(
                                quarterTurns: 1,
                                child: GradientCircularIndicator(
                                  colors: [
                                    Colors.blue.shade700,
                                    Colors.blue.shade100,
                                  ],
                                  radius: 50.0,
                                  strokeWidth: 3.0,
                                  strokeCapRound: true,
                                  backgroundColor: Colors.transparent,
                                  value: _animationController.value,
                                ),
                              ),
                              GradientCircularIndicator(
                                  radius: 50.0,
                                  strokeWidth: 5.0,
                                  strokeCapRound: true,
                                  colors: [
                                    Colors.red,
                                    Colors.amber,
                                    Colors.cyan,
                                    Colors.green.shade200,
                                    Colors.blue,
                                    Colors.red
                                  ],
                                  value: _animationController.value)
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientCircularIndicator extends StatelessWidget {
  const GradientCircularIndicator({
    super.key,
    this.strokeWidth = 2.0,
    required this.radius,
    required this.colors,
    this.stops,
    this.strokeCapRound = false,
    this.backgroundColor = const Color(0XFFEEEEEE),
    this.totalAngle = 2 * pi,
    required this.value,
  });

  ///粗细
  final double strokeWidth;

  ///圆半径
  final double radius;

  ///两端是否为圆角
  final bool strokeCapRound;

  ///当前进度[0.0,1.0]
  final double value;

  ///进度条背景色
  final Color backgroundColor;

  ///进度条总的弧度数，2*PI为整圆，小于2*PI则不是整圆
  final double totalAngle;

  ///渐变数组
  final List<Color>? colors;

  ///渐变色终点
  final List<double>? stops;

  @override
  Widget build(BuildContext context) {
    double _offset = .0;
    if (strokeCapRound) {
      _offset = asin(strokeWidth / (radius * 2 - strokeWidth));
    }
    var _colors = colors;
    if (_colors == null) {
      Color color = Theme.of(context).colorScheme.secondary;
      _colors = [color, color];
    }
    return Transform.rotate(
      angle: -pi / 2.0 - _offset,
      child: CustomPaint(
        size: Size.fromRadius(radius),
        painter: _GradientCircularProgressPainter(
          strokeWidth: strokeWidth,
          strokeCapRound: strokeCapRound,
          backgroundColor: backgroundColor,
          value: value,
          total: totalAngle,
          radius: radius,
          colors: _colors,
        ),
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  _GradientCircularProgressPainter({
    this.strokeWidth = 10.0,
    this.strokeCapRound = false,
    this.backgroundColor = const Color(0XFFEEEEEE),
    required this.radius,
    this.total = 2 * pi,
    required this.colors,
    this.stops,
    required this.value,
  });

  final double strokeWidth;
  final bool strokeCapRound;
  final double value;
  final Color backgroundColor;
  final List<Color> colors;
  final double total;
  final double radius;
  final List<double>? stops;

  @override
  void paint(Canvas canvas, Size size) {
    size = Size.fromRadius(radius);
    double _offset = strokeWidth / 2.0;
    double _value = (value ?? .0);
    _value = _value.clamp(.0, 1.0) * total;
    double _start = .0;

    if (strokeCapRound) {
      _start = asin(strokeWidth / (size.width - strokeWidth));
    }

    Rect rect = Offset(_offset, _offset) &
        Size(
          size.width - strokeWidth,
          size.height - strokeWidth,
        );

    var paint = Paint()
      ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth;

    /// 先画背景
    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, _start, total, false, paint);
    }

    /// 再画前景
    if (_value > 0) {
      paint.shader = SweepGradient(
              startAngle: 0.0, endAngle: _value, colors: colors, stops: stops)
          .createShader(rect);
      canvas.drawArc(rect, _start, _value, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
