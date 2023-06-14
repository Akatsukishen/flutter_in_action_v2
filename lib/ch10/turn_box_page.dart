import 'package:flutter/material.dart';

/// 使用RotationTransition来旋转任意角度
/// 在didUpdateWidget中触发动画
class TurnBoxPage extends StatefulWidget {
  const TurnBoxPage({Key? key}) : super(key: key);

  @override
  State<TurnBoxPage> createState() => _TurnBoxPageState();
}

class _TurnBoxPageState extends State<TurnBoxPage> {
  double _turns = .0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('可任意旋转控件'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TurnBox(
              turns: _turns,
              speed: 500,
              child: const Icon(
                Icons.refresh,
                size: 50,
              ),
            ),
            TurnBox(
              turns: _turns,
              speed: 1000,
              child: const Icon(
                Icons.refresh,
                size: 150,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _turns += 0.2;
                });
              },
              child: const Text('顺时针旋转1/5圈'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _turns -= 0.2;
                });
              },
              child: const Text('逆时针旋转1/5圈'),
            ),
          ],
        ),
      ),
    );
  }
}

class TurnBox extends StatefulWidget {
  const TurnBox({
    super.key,
    required this.turns,
    this.speed = 200,
    required this.child,
  });

  /// 旋转的周数,一圈为360度，如0.25圈90度
  final double turns;

  /// 过渡动画时间执行总时长
  final int speed;
  final Widget child;

  @override
  State<TurnBox> createState() => _TurnBoxState();
}

class _TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, lowerBound: -double.infinity, upperBound: double.infinity);
    _controller.value = widget.turns;
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(covariant TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(widget.turns,
          duration: Duration(milliseconds: widget.speed),
          curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
