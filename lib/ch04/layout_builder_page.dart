import 'package:flutter/material.dart';
import 'package:flutter_in_action_v2/ch04/layout_log_print.dart';
import 'package:flutter_in_action_v2/ch04/responsive_column.dart';

import '../base/base_page.dart';

/// LayoutBuilder 在构建时传入布局的参数限制 BoxConstraints
/// 可以根据BoxConstraints来确定运行时的状况。
class LayoutBuilderPage extends BasePage {
  const LayoutBuilderPage({super.key, super.title = "LayoutBuilder使用"});

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.red,
          width: 240,
          child: ResponsiveColumn(children: testChildren()),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.red,
          width: 180,
          child: ResponsiveColumn(children: testChildren()),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.red,
          width: 200,
          child: const LayoutLogPrint<String>(child: Text('AA'),),
        )
      ],
    );
  }

  List<Widget> testChildren() {
    var children = <Widget>[];
    for (int i = 0; i < 5; i++) {
      children.add(Container(
        width: 110,
        height: 40,
        alignment: Alignment.center,
        color: i % 2 == 0 ? Colors.green : Colors.blue,
        child: Text('${i + 1}个'),
      ));
    }
    return children;
  }
}
