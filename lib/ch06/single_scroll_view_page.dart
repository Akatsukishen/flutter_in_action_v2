import 'package:flutter/material.dart';

import '../base/base_page.dart';

class SingleChildScrollViewPage extends BasePage {
  const SingleChildScrollViewPage({super.key, super.title = '单子组件的滚动'});

  @override
  Widget buildBody(BuildContext context) {
    String str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return Scrollbar( //显示滚动条
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: str
                .split("")
                .map((e) => Text(
                      e,
                      textScaleFactor: 2.0,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
