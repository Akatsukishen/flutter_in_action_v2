import 'package:flutter/material.dart';

/// HitTestBehavior
/// deferToChild : 普通设置，完全由子控件来确定是否通过命中测试
/// opaque: 不透明的，通过命中测试，同时hitTest返回true
/// translucent: 透明的，通过命中测试，但hitTest可能返回true,也可能返回false.
class HitTestBehaviorPage extends StatelessWidget {
  const HitTestBehaviorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HitTestBehavior'),
      ),
      body: Stack(children: [
        cWidget(1),
        cWidget(2), // 第二个组件通过命中测试，但是hitTest返回false,所以才没有终止遍历，第一个组件才有机会命中并响应
      ]),
    );
  }

  Widget cWidget(int index) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) {
        debugPrint("===> down.index = $index");
      },
      child: const SizedBox.expand(),
    );
  }
}
