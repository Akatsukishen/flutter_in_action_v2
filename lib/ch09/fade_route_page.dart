import 'package:flutter/material.dart';
import 'package:flutter_in_action_v2/base/base_page.dart';

/// 自定义的页面切换动画，需要继承实现PageRoute
class FadeRoutePage extends BasePage {
  const FadeRoutePage({super.key, super.title = '自定义PageRoute'});

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, FadeRoute(builder: (context) {
            return Scaffold(
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
            );
          }));
        },
        child: const Text('跳转'),
      ),
    );
  }
}

class FadeRoute extends PageRoute {
  FadeRoute({
    required this.builder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color? barrierColor;

  @override
  final String? barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (isActive) {
      //页面打开时执行动画
      return FadeTransition(
        opacity: animation,
        child: builder(context),
      );
    } else {
      //页面返回时不执行动画
      return const Padding(
        padding: EdgeInsets.zero,
      );
    }
  }

  @override
  final bool maintainState;
}
