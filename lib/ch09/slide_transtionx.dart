import 'package:flutter/material.dart';

class SlideTranstionX extends AnimatedWidget {
  SlideTranstionX(
      {Key? key,
      required Animation<double> position,
      this.transationHitTests = true,
      this.direction = AxisDirection.down,
      required this.child})
      : super(key: key, listenable: position) {
    switch (direction) {
      case AxisDirection.up: //下入上出
        _tween = Tween(begin: const Offset(0, 1), end: const Offset(0, 0));
        break;
      case AxisDirection.right: //左入右出
        _tween = Tween(begin: const Offset(-1, 0), end: const Offset(0, 0));
        break;
      case AxisDirection.down: //上入下出
        _tween = Tween(begin: const Offset(0, -1), end: const Offset(0, 0));
        break;
      case AxisDirection.left: //右入左出
        _tween = Tween(begin: const Offset(1, 0), end: const Offset(0, 0));
        break;
    }
  }

  final bool transationHitTests;

  final Widget child;

  final AxisDirection direction;

  late final Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    var position = listenable as Animation<double>;
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
        default:
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transationHitTests,
      child: child,
    );
  }
}
