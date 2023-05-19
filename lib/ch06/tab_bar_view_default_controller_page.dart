import 'package:flutter/material.dart';

class TabBarViewWithDefaultControllerPage extends StatefulWidget {
  const TabBarViewWithDefaultControllerPage({super.key});

  @override
  State<TabBarViewWithDefaultControllerPage> createState() =>
      _TabBarViewWithDefaultControllerPageState();
}

class _TabBarViewWithDefaultControllerPageState
    extends State<TabBarViewWithDefaultControllerPage> {
  late final _tabs = ['新闻', '体育', '历史'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('TabBarView使用DefaultTabController'),
            bottom: TabBar(tabs: _tabs.map((e) => Text(e)).toList()),
          ),
          body: TabBarView(
              children: _tabs.map((e) {
            return Container(
                alignment: Alignment.center,
                child: Text(
                  e,
                  textScaleFactor: 3,
                ));
          }).toList()),
        ));
  }
}
