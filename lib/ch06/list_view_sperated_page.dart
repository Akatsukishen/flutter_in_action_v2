import 'package:flutter/material.dart';
import 'package:flutter_in_action_v2/base/base_page.dart';

/// sperated的方式创建 中间会添加分割组件
class ListViewSperatedPage extends BasePage {
  const ListViewSperatedPage({super.key, super.title = 'sperated方式创建ListView'});

  @override
  Widget buildBody(BuildContext context) {
    var divider1 = const Divider(
      color: Colors.blue,
    );
    var divider2 = const Divider(
      color: Colors.green,
    );
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('$index'),
          );
        },
        separatorBuilder: (context, index) =>
            (index % 2 == 0) ? divider1 : divider2,
        itemCount: 100);
  }
}
