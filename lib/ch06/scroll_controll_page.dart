import 'package:flutter/material.dart';

/// 给需要监听的控件赋值controller
/// 通过controller addListener 来监听滚动
/// controller.offset 当前滚动的距离
/// controller.jumpTo() animateTo() 跳转到指定偏移的位置
/// 控件dispose时注意调用来避免内存泄漏 controller.dispose() 
class ScrollControllPage extends StatefulWidget {
  const ScrollControllPage({Key? key}) : super(key: key);

  @override
  State<ScrollControllPage> createState() => _ScrollControllPageState();
}

class _ScrollControllPageState extends State<ScrollControllPage> {
  final _scrollController = ScrollController();
  var _showToTopBtn = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 1000 && !_showToTopBtn) {
        //offset滚动距离
        setState(() {
          _showToTopBtn = true;
        });
      } else if (_scrollController.offset < 1000 && _showToTopBtn) {
        setState(() {
          _showToTopBtn = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('滚动控制'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('$index'),
          );
        },
        controller: _scrollController, //指定控制器
        itemExtent: 50,
        itemCount: 60,
      ),
      floatingActionButton: _showToTopBtn
          ? FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease);
              },
              child: const Icon(Icons.arrow_upward),
            )
          : null,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();//避免内存泄漏
    super.dispose();
  }
}
