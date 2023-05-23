import 'package:flutter/material.dart';

import '../base/base_page.dart';

/// PageRouteBuilder pageBuilder函数中返回了一个animation参数，
/// 由Flutter路由器管理提供，在切换时会回调
class PageRouteBuilderPage extends BasePage {
  const PageRouteBuilderPage(
      {super.key, super.title = '使用PageRouteBuilder定义路由动画'});

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500), //动画时间
              pageBuilder: (ctx, animation, secondAnimation) {
                return FadeTransition(
                  //页面切换动画
                  opacity: animation,
                  child: Scaffold(
                    appBar: AppBar(
                      title: const Text('新页面'),
                    ),
                    body: Center(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('返回')),
                    ),
                  ),
                );
              }));
        },
        child: const Text('切换'),
      ),
    );
  }
}
