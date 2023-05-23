import 'package:flutter/material.dart';

class ScaleAnimationPage extends StatefulWidget {
  const ScaleAnimationPage({Key? key}) : super(key: key);

  @override
  State<ScaleAnimationPage> createState() => _ScaleAnimationPageState();
}

class _ScaleAnimationPageState extends State<ScaleAnimationPage>
    with SingleTickerProviderStateMixin {
  //需要监听屏幕刷新
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    //动画控制器
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    //动画值区间
    animation = Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        //监听每一帧的变化
        setState(() {});
      });
    //启动动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('放大动画'),
      ),
      body: Center(
          child: Image.asset(
        'assets/images/qiaoba.jpeg',
        width: animation.value,
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose(); //防止内存泄漏
  }
}
