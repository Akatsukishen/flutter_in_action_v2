import 'package:flutter/material.dart';

/// 不用主动调用 setState()和addListener
class AnimatedImg extends AnimatedWidget {
  const AnimatedImg({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Image.asset(
        'assets/images/qiaoba.jpeg',
        width: animation.value,
      ),
    );
  }
}

class AnimatedWidgetPage extends StatefulWidget {
  const AnimatedWidgetPage({Key? key}) : super(key: key);

  @override
  State<AnimatedWidgetPage> createState() => _AnimatedWidgetPageState();
}

class _AnimatedWidgetPageState extends State<AnimatedWidgetPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation = Tween(begin: 0.0, end: 300.0).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AmimatedWidget使用'),
      ),
      body: AnimatedImg(animation: animation),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.forward();
  }
}
