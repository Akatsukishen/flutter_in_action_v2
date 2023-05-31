import 'package:flutter/material.dart';

class AssetImagePage extends StatefulWidget {
  const AssetImagePage({Key? key}) : super(key: key);

  @override
  State<AssetImagePage> createState() => _AssetImagePageState();
}

class _AssetImagePageState extends State<AssetImagePage> {
  var _color = Colors.green;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10)).then((value) {
      debugPrint("===> delay to change color");
      setState(() {
        debugPrint("===> change color");
        _color = Colors.yellow;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF060735),
      appBar: AppBar(
        title: const Text('AssetImage Test'),
      ),
      body: Container(
        width: 300,
        height: 300,
        child: Stack(alignment: Alignment.center, children: [
          Container(
            width: 200,
            height: 200,
            color: _color,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/test.jpg',
              width: 100,
              height: 100,
            ),
          ),
        ]),
      ),
    );
  }
}
