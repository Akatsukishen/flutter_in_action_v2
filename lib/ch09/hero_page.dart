import 'package:flutter/material.dart';

import '../base/base_page.dart';

/// hero动画
/// 前后两个页面具有共享的元素
/// 使用hero包裹需要共享的元素，并指定tag
/// 相同tag的元素认为是前后共享的统一元素。
class HeroPage extends BasePage {
  const HeroPage({super.key, super.title = 'Hero动画使用'});

  @override
  Widget buildBody(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          InkWell(
            child: Hero(
              tag: 'avatar',
              child: ClipOval(
                child: Image.asset(
                  'assets/images/qiaoba.jpeg',
                  width: 50,
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                  return FadeTransition(
                    opacity: animation,
                    child: Scaffold(
                      appBar: AppBar(
                        title: const Text('新页面'),
                      ),
                      body: Center(
                        child: Hero(
                          tag: 'avatar',
                          child: Image.asset('assets/images/qiaoba.jpeg'),
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          )
        ],
      ),
    );
  }
}
