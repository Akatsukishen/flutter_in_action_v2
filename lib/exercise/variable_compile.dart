import 'package:flutter/material.dart';

import '../base/base_page.dart';

class CompilingVariablePage extends BasePage {
  const CompilingVariablePage({super.key, super.title = "编译期指定参数"});

  static const appChannel = String.fromEnvironment('APP_CHANNEL');
  @override
  Widget buildBody(BuildContext context) {
    debugPrint("====>  APP_CHANNEL = $appChannel");
    return const Center(
      child: Text('渠道:$appChannel'),
    );
  }
}
