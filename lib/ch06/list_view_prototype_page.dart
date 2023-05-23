import 'package:flutter/material.dart';

import '../base/base_page.dart';

/// 在知道布局列表项的高度的情况下，可以提高性能
/// 可以通过itemExtent来指定具体的高度值
/// 但是有时候我们只知道列表项是公用一个布局，并不知道具体的高度值
/// 此时，可以通过prototypeItem来指定通用的布局，通过通用布局也能计算出列表项的高度
class ListViewPrototypePage extends BasePage {
  const ListViewPrototypePage({super.key, super.title = '列表原型创建'});

  @override
  Widget buildBody(BuildContext context) {
    return ListView.builder(
      prototypeItem: const ListTile(
        title: Text('1'),
      ),
      itemBuilder: (context, index) => ListTile(
        title: Text('$index'),
      ),
      itemCount: 100,
    );
  }
}
