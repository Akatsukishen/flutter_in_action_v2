import 'package:flutter/material.dart';

/// ValueListenableBuilder 传入可监听的数据，
/// 数据变化会导致所有依赖此数据的ValueListenableBuilder 全部调用build方法。
/// child如果创建成本比较高的话，可以复用。
class ValueListenableBuilderPage extends StatefulWidget {
  const ValueListenableBuilderPage({Key? key}) : super(key: key);

  @override
  State<ValueListenableBuilderPage> createState() =>
      _ValueListenableBuilderPaggeState();
}

class _ValueListenableBuilderPaggeState
    extends State<ValueListenableBuilderPage> {
  var countListenable = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    debugPrint("===> build");
    return Scaffold(
      appBar: AppBar(
        title: const Text('ValueListenableBuilder页面'),
      ),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: countListenable,
          builder: (BuildContext context, int value, Widget? child) { // child如果创建成本比较高的话，可以复用
            debugPrint("===> valueListenable build");
            return Text(
              '点击了$value次',
              textScaleFactor: 1.5,
            );
          },
          child: const Text(
            '点击',
            textScaleFactor: 1.5,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          countListenable.value++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
