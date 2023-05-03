import 'package:flutter/material.dart';

class BounceInAnimationPage extends StatefulWidget {
  const BounceInAnimationPage({super.key});

  @override
  State<BounceInAnimationPage> createState() => _BounceInAnimationPageState();
}

class _BounceInAnimationPageState extends State<BounceInAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    var curvedAnimation =
        CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    animation = Tween(begin: 0.0, end: 300.0).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('弹簧放大效果'),
      ),
      body: Center(
        child: Image.asset(
          'assets/images/qiaoba.jpeg',
          width: animation.value,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
