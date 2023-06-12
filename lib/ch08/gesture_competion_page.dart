import 'package:flutter/material.dart';

/// 每一个手势识别器（GestureRecognizer）都是一个“竞争者”（GestureArenaMember），
/// 当发生指针事件时，他们都要在“竞技场”去竞争本次事件的处理权，
/// 默认情况最终【只有一个“竞争者”】会胜出(win)
class GestureCompetionPage extends StatelessWidget {
  const GestureCompetionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('手势竞争02'),
      ),
      body: Center(
        child: GestureDetector(
          onTapUp: (event) => debugPrint("===> 22"),
          child: Container(
            width: 200,
            height: 200,
            color: Colors.red,
            alignment: Alignment.center,
            child: GestureDetector(
              onTapUp: (event) => debugPrint("===> 11"),
              child: Container(
                width: 50,
                height: 50,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
