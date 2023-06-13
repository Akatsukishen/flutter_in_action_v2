import 'package:flutter/material.dart';

/// 使用 Notificattion().dispatch(context)
/// 将会发送事件，并且从context对应的节点开始向上冒泡
class CustomNotificationPage extends StatefulWidget {
  const CustomNotificationPage({Key? key}) : super(key: key);

  @override
  State<CustomNotificationPage> createState() => _CustomNotificationPageState();
}

class _CustomNotificationPageState extends State<CustomNotificationPage> {
  var _msg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义通知'),
      ),
      body: NotificationListener<MyNotification>(
        onNotification: (myNotification) {
          setState(() {
            _msg += myNotification.msg;
          });
          return true;
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  MyNotification("Hi ").dispatch(context);
                },
                child: const Text('点击发送通知(父组件收不到)'),
              ),
              Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MyNotification("Hello ").dispatch(context);
                  },
                  child: const Text('点击发送通知'),
                );
              }),
              Text(_msg),
            ],
          ),
        ),
      ),
    );
  }
}

class MyNotification extends Notification {
  MyNotification(this.msg);
  final String msg;
}
