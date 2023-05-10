import 'package:flutter/material.dart';

class AnimatedDecoratedBoxPage extends StatefulWidget {
  const AnimatedDecoratedBoxPage({super.key});

  @override
  State<AnimatedDecoratedBoxPage> createState() =>
      _AnimatedDecoratedBoxPageState();
}

class _AnimatedDecoratedBoxPageState extends State<AnimatedDecoratedBoxPage> {
  Color _decorationColor = Colors.blue;
  var duration = const Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义过渡动画'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedDecocatedBox(
              duration: duration,
              decoration: BoxDecoration(color: _decorationColor),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _decorationColor = Colors.red;
                    // _decorationColor = Colors.blue != _decorationColor ? Colors.blue : Colors.red;
                  });
                },
                child: const Text(
                  'AnimatedDecocatedBox',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// 自定义装饰过渡动画
/// 1. 定义AnimationController 动画时间 动画曲线 需要改变属性的子控件
/// 2. 使用AnimatedBuilder来构建最终的结果
/// 3. 在外面重新赋值时会触发didUpdateWidget(),启动动画
class AnimatedDecocatedBox extends StatefulWidget {
  const AnimatedDecocatedBox(
      {super.key,
      required this.decoration,
      required this.child,
      this.curve = Curves.linear,
      required this.duration,
      this.reverseDuration});

  final Decoration decoration;
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration? reverseDuration;

  @override
  State<AnimatedDecocatedBox> createState() => _AnimatedDecocatedBoxState();
}

class _AnimatedDecocatedBoxState extends State<AnimatedDecocatedBox>
    with SingleTickerProviderStateMixin {
  @protected
  AnimationController get controller => _controller;
  late AnimationController _controller;

  Animation<double> get animation => _animation;
  late Animation<double> _animation;

  late DecorationTween _tween;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return DecoratedBox(
          decoration: _tween.animate(_animation).value,
          child: child,
        );
      },
      child: widget.child,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: widget.duration,
        reverseDuration: widget.reverseDuration);
    _tween = DecorationTween(begin: widget.decoration);
    _updateCurve();
  }

  void _updateCurve() {
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
  }

  @override
  void didUpdateWidget(covariant AnimatedDecocatedBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("===> didUpdateWidget.");
    if (widget.curve != oldWidget.curve) _updateCurve();
    _controller.duration = widget.duration;
    _controller.reverseDuration = widget.reverseDuration;
    //需要的装饰器跟动画执行的最终的结果不一样，开始执行动画
    if (widget.decoration != (_tween.end ?? _tween.begin)) {
      _tween
        ..begin = _tween.evaluate(_animation)
        ..end = widget.decoration;
      _controller
        ..value = 0.0
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
