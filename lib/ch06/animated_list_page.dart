import 'package:flutter/material.dart';

class AnimatedListPage extends StatefulWidget {
  const AnimatedListPage({super.key});

  @override
  State<AnimatedListPage> createState() => _AnimatedListPageState();
}

class _AnimatedListPageState extends State<AnimatedListPage> {
  var data = <String>[];
  int count = 5;

  final globalKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    for (var i = 0; i < count; i++) {
      data.add('${i + 1}');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedList使用'),
      ),
      body: Stack(
        children: [
          AnimatedList(
            key: globalKey,
            initialItemCount: data.length,
            itemBuilder: (context, index, animation) {
              //渐显动画
              return FadeTransition(
                opacity: animation,
                child: buildItem(index),
              );
            },
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: FloatingActionButton(
              onPressed: () {
                data.add('${++count}');
                globalKey.currentState?.insertItem(data.length - 1);
              },
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }

  Widget buildItem(int index) {
    String char = data[index];
    return ListTile(
      title: Text(char),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          onDelete(context, index);
        },
      ),
    );
  }

  void onDelete(BuildContext context, int index) {
    setState(() {
      globalKey.currentState?.removeItem(index, (context, animation) {
        //构建需要删除的列表项
        var item = buildItem(index);
        data.removeAt(index);
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: const Interval(0.5, 1.0),
          ),
          child: SizeTransition(
            sizeFactor: animation,
            child: item,
          ),
        );
      }, duration: const Duration(milliseconds: 200));
    });
  }
}
