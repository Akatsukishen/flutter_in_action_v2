import 'package:flutter/material.dart';

import '../base/base_page.dart';

class CompilingVariablePage extends BasePage {
  const CompilingVariablePage({super.key, super.title = "编译期指定参数"});

  static const APP_CHANNEL = String.fromEnvironment('APP_CHANNEL');
  @override
  Widget buildBody(BuildContext context) {
    print("====>  APP_CHANNEL = $APP_CHANNEL");
    return Center(
      child: Text('渠道:$APP_CHANNEL'),
    );
  }
}
