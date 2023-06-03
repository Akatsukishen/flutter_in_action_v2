import 'package:flutter/material.dart';

class InheritedWidgetPage extends StatefulWidget {
  const InheritedWidgetPage({Key? key}) : super(key: key);

  @override
  State<InheritedWidgetPage> createState() => _InheritedWidgetPageState();
}

class _InheritedWidgetPageState extends State<InheritedWidgetPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InheritedWidgetPage使用'),
      ),
      body: Center(
        child: ShareDataWidget(
          data: count,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ignore: prefer_const_constructors
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                // ignore: prefer_const_constructors
                child:  _TestWidget(key : ValueKey("aaa")),
              ),
              ElevatedButton(
                onPressed: () {
                  //setState会导致所有子控件都重新build，哪怕子控件不依赖count
                  setState(() {
                    count++;
                  });
                },
                child: const Text('increment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShareDataWidget extends InheritedWidget {
  const ShareDataWidget({super.key, required this.data, required super.child});

  final int data;

  static ShareDataWidget? of(BuildContext context) {
    //获取顶层指定类型的控件
    //获取的同时注册监听器，然后在变化的时候通知子组件
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();

    //这种方式只会获取指定类型的父组件，并不会生成监听关系。
    // return context
    //     .getElementForInheritedWidgetOfExactType<ShareDataWidget>()
    //     ?.widget as ShareDataWidget?;
  }

  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}

class _TestWidget extends StatefulWidget {
  const _TestWidget({super.key});

  @override
  State<_TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    debugPrint("===> TestWidget build. $this");
    return Text(ShareDataWidget.of(context)!.data.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("===> TestWidget didChangeDependencies");
  }
}
