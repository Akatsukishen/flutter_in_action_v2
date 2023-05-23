import 'package:flutter/material.dart';

import '../base/base_page.dart';

class LiveViewBuilderPage extends BasePage {
  const LiveViewBuilderPage(
      {super.key, super.title = '使用builder方式来创建ListView'});

  @override
  Widget buildBody(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('$index'),
        );
      },
      itemExtent: 50,

      ///强制高度为50
      itemCount: 100,

      ///列表项个数
    );
  }
}
