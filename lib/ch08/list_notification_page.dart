import 'package:flutter/material.dart';

/// NotificationListener<T>
/// 不指定类型 所有类型的通知都能收到
/// 指定类型   只有指定类型的通知才能收到
/// 如果返回true则表示处理了该通知，不会再往上抛了
class ListNotificationPage extends StatelessWidget {
  const ListNotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('滚动事件监听'),
      ),
      body: NotificationListener(
        onNotification: (notification) {
          switch (notification.runtimeType) {
            case ScrollStartNotification:
              debugPrint('===> 开始滚动');
              break;
            case ScrollUpdateNotification:
              debugPrint("===> 正在滚动");
              break;
            case ScrollEndNotification:
              debugPrint("===> 滚动停止");
              break;
            case OverscrollNotification:
              debugPrint("===> 滚动到边界");
              break;
          }
          return true;
        },
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('$index'),
            );
          },
          itemCount: 50,
        ),
      ),
    );
  }
}
