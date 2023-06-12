import 'package:flutter/material.dart';

/// 该实例中只会打印2
/// Stack有2个子控件
/// 第二个的子控件Listener,在命中测试中由于Container通过命中测试，所以Listener通过命中测试
/// 那么此时会提前中断Stack的命中测试，所以第一个不会执行命中测试、
/// 
///           root
///           /    \
///          a1    a2
///         / \    / \
///        b1  b2 b3 b4
///  命中测试顺序 【深度优先】
///  子组件按照索引顺序逆序遍历，即上面的组件先遍历 b4 b3 a2 b2 b1 a1 root
///  
class StackEventPage extends StatelessWidget {

  const StackEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('事件分发'),
      ),
      body: Stack(
        children: [
          wChild(1),
          wChild(2),
        ],
      ),
    );
  }

  Widget wChild(int index) {
    return Listener(
      onPointerDown: (event) {
        debugPrint("===> event. index = $index");
      },
      child: Container(
        width: 200,
        height: 200,
        color: Colors.grey,
      ),
    );
  }
}


