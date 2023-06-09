import 'package:flutter/material.dart';

class GestureDetectorPage extends StatefulWidget {
  const GestureDetectorPage({Key? key}) : super(key: key);

  @override
  State<GestureDetectorPage> createState() => _GestureDetectorPageState();
}

class _GestureDetectorPageState extends State<GestureDetectorPage> {
  String _operation = "No Gesture detected!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('手势检测'),
      ),
      body: Center(
        child: GestureDetector(
          child: Container(
            width: 300,
            height: 150,
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text(
              _operation,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          onTap: () {
            setState(() {
              _operation = "tap";
            });
          },
          onDoubleTap: () {
            setState(() {
              _operation = 'doubleTap';
            });
          },
          onLongPress: () {
            setState(() {
              _operation = 'longPress';
            });
          },
        ),
      ),
    );
  }
}
