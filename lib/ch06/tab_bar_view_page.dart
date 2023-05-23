import 'package:flutter/material.dart';

/// TabBarView 封装了PageView，可以滚动切换显示。
/// 使用TabBarView必须指定 TabController
///     使用TabController时 需要提供TickerProvider, State可以混入 SingleTickerProviderStateMixin
///     避免内存泄漏，在State dispose中调用 controller.dispose()
/// TabBarView和TabBar配合使用，共用一个TabController
/// 如果没有指定，控件树逐层向上找到第一个DefaultTabController
///
class TabBarViewPage extends StatefulWidget {
  const TabBarViewPage({super.key});

  @override
  State createState() => _TabBarViewPageState();
}

class _TabBarViewPageState extends State<TabBarViewPage>
    with SingleTickerProviderStateMixin {
  late final _tabs = ['新闻', '体育', '历史'];
  late final _tabController = TabController(length: _tabs.length, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabBarView简单使用'),
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs.map((e) => Text(e)).toList(),
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.cyanAccent,
          indicatorWeight: 3.0,

          /// 指示器的高度
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: _tabs.map((e) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                e,
                textScaleFactor: 3,
              ),
            );
          }).toList()),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
