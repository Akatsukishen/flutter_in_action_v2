import 'package:flutter/material.dart';

class OverFlowPage extends StatefulWidget {
  const OverFlowPage({super.key});

  @override
  State<OverFlowPage> createState() => _OverFlowPageState();
}

class _OverFlowPageState extends State<OverFlowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Overflow'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Row(children: [Text('xx' * 30)]), //文本长度超出 Row 的最大宽度会溢出
        ));
  }
}
