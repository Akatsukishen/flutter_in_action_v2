import 'package:flutter/material.dart';

import 'slide_transtionx.dart';

/// 实现效果 自增数字时 新数字右边进来，老数字左边出去
/// 使用默认的SlideAnimation
///   由于新控件是启动正向动画，老控件执行的是方向(reverse)动画
///   那么右边进去，自然是右边出去
///
///
class AnimatedSwitcherPage2 extends StatefulWidget {
  const AnimatedSwitcherPage2({super.key});

  @override
  State<AnimatedSwitcherPage2> createState() => _AnimatedSwitcherPage2State();
}

class _AnimatedSwitcherPage2State extends State<AnimatedSwitcherPage2> {
  var _num1 = 0;
  var _num2 = 0;
  var _num3 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('动画切换组件2'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50.0,
            width: double.infinity,
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              var tweenAimation = Tween<Offset>(
                begin: const Offset(1, 0),
                end: const Offset(0, 0),
              ).animate(animation);
              return SlideTransition(
                position: tweenAimation,
                child: child,
              ); //新控件执行正向动画，老控件执行方向动画
            },
            child: Text(
              '$_num1',
              key: ValueKey(_num1),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _num1++;
              });
            },
            child: const Text('addNum1'),
          ),
          const SizedBox(
            height: 50.0,
            width: double.infinity,
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              var tweenAimation = Tween<Offset>(
                begin: const Offset(1, 0),
                end: const Offset(0, 0),
              ).animate(animation);
              return MySlideAnimation(
                position: tweenAimation,
                child: child,
              ); 
            },
            child: Text(
              '$_num2',
              key: ValueKey(_num2),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _num2++;
              });
            },
            child: const Text('addNum2'),
          ),
          const SizedBox(
            height: 50.0,
            width: double.infinity,
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) {
              return SlideTranstionX(
                position: animation,
                direction: AxisDirection.down, //上入下出
                child: child,
              ); 
            },
            child: Text(
              '$_num3',
              key: ValueKey(_num3),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _num3++;
              });
            },
            child: const Text('addNum3'),
          ),
        ],
      ),
    );
  }
}

class MySlideAnimation extends AnimatedWidget {
  const MySlideAnimation(
      {super.key,
      required Animation<Offset> position,
      this.transformHitTests = true,
      required this.child})
      : super(listenable: position);

  final bool transformHitTests;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final position = listenable as Animation<Offset>;
    Offset offset = position.value;
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
