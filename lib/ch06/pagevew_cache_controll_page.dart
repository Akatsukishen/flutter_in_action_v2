import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_in_action_v2/ch06/keep_alive_wrapper.dart';

/// 通过onPageChanged事件来确定选中的页面
/// 可以通过 【选中的页面】来确定当前页面是否需要缓存。
class PageViewCacheControllPage extends StatefulWidget {
  const PageViewCacheControllPage({super.key});

  @override
  State<PageViewCacheControllPage> createState() =>
      _PageViewCacheControllPageState();
}

class _PageViewCacheControllPageState extends State<PageViewCacheControllPage> {
  final _pageController = PageController();
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('pageView缓存控制'),
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (page) { //onPageChanged回调触发
          setState(() {
            _page = page;
          });
        },
        itemBuilder: (context, index) {
          return KeepAliveWrapper(
              keepAlive: (_page - index).abs() <= 2,
              child: CacheEnablePage(
                title: 'page$index',
              ));
        },
        itemCount: 10,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class CacheEnablePage extends StatefulWidget {
  const CacheEnablePage({super.key, required this.title});

  final String title;

  @override
  State<CacheEnablePage> createState() => _CacheEnablePageState();
}

class _CacheEnablePageState extends State<CacheEnablePage> {
  var _data = 0;

  @override
  void initState() {
    _data = Random().nextInt(1000);
    debugPrint("===> initState. title = ${widget.title},_data = $_data");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('${widget.title}-$_data'),
    );
  }

  @override
  void dispose() {
    debugPrint("===> dispose. title = ${widget.title}");
    super.dispose();
  }
}
