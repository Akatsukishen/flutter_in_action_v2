import 'package:flutter/material.dart';

import '../base/base_page.dart';

/// Column默认可以跟子控件无限的空间
/// ListView默认占用父组件的所有空间
/// 相互依赖，逻辑错误，因此并不能直接将ListView放到Column中
/// 可以使用Expanded
/// Expanded 继承自 Flex, 默认占据父组件所有剩余空间
class ListViewHeaderPage extends BasePage {
  const ListViewHeaderPage({super.key, super.title = '添加列表头部'});

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          title: Text('我是列表头部'),
        ),
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('$index'),
                );
              },
              separatorBuilder: (context, index) =>
                  Divider(color: index % 2 == 0 ? Colors.blue : Colors.green),
              itemCount: 50),
        )
      ],
    );
  }
}
