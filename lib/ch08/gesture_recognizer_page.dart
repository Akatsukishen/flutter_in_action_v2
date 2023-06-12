import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// GestureRecognizer 手势识别 是【抽象类】
/// 具体的点击识别类是 TapGestureRecognizer.
/// GestureRecognizer要记得及时销毁，避免内存的泄漏。
///
/// 富文本
///   Text.rich(
///     TextSpan( // 创建Span
///       children: [ //每段的内容
///         TextSpan(text: text1),
///         TextSpan(text: text2),
///         TextSpan(text: text3),
///       ]
///     )
///   )
///
class GestureRecognizerPage extends StatefulWidget {
  const GestureRecognizerPage({super.key});

  @override
  State<GestureRecognizerPage> createState() => _GestureRecognizerPageState();
}

class _GestureRecognizerPageState extends State<GestureRecognizerPage> {
  final _gestureRecognizer = TapGestureRecognizer();
  var _toggle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('手势识别'),
      ),
      body: Center(
        child: Text.rich(TextSpan(children: [
          const TextSpan(text: '你好'),
          TextSpan(
              text: '点击变色',
              style: TextStyle(
                fontSize: 30,
                color: _toggle ? Colors.red : Colors.blue,
              ),
              recognizer: _gestureRecognizer
                ..onTap = () {
                  //通过..设置监听,类似于kotlin的apply
                  setState(() {
                    _toggle = !_toggle;
                  });
                }),
          const TextSpan(text: '世间')
        ])),
      ),
    );
  }

  @override
  void dispose() {
    _gestureRecognizer.dispose();
    super.dispose();
  }
}
