import 'package:flutter/material.dart';

/// pageView 左滑右滑组件，常与tabbarview配合使用
/// 给children属性赋值需要展示的控件集合即可
/// pageSnapping 每次滑动是否强制刷新整个页面，如果为false,则会滑动多少滚动多少
/// allowImplicitScrolling 配合辅助功能用
///
/// 默认页面是不进行缓存的。只能每次都走build.
/// 属性allowImplicitScrolling为true,可以缓存前后一个页面
class PageViewSimplePage extends StatefulWidget {
  const PageViewSimplePage({super.key});

  @override
  State<PageViewSimplePage> createState() => _PageViewSimplePageState();
}

class _PageViewSimplePageState extends State<PageViewSimplePage> {
  final _pageChildren = <Page>[];
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    for (int i = 1; i < 6; i++) {
      _pageChildren.add(Page(title: '页面$i'));
    }
    _pageController.addListener(() {
      debugPrint("===> offset  = ${_pageController.offset}, page = ${_pageController.page}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('pageView使用'),
      ),
      body: PageView(
        // pageSnapping: false, //赋值false滑动多少滚动多少
        allowImplicitScrolling: true, //allowImplicitScrolling为true可以缓存前后一屏
        controller: _pageController,
        children: _pageChildren,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class Page extends StatefulWidget {
  const Page({super.key, required this.title});

  final String title;

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    debugPrint("===> build. ${widget.title}");
    return Center(child: Text(widget.title));
  }
}
