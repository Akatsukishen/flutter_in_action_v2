import 'package:flutter/material.dart';

/// 通过gestureDetector的缩放事件监听实现缩放效果
class GestureScalePage extends StatefulWidget {
  const GestureScalePage({Key? key}) : super(key: key);

  @override
  State<GestureScalePage> createState() => _GestureScalePageState();
}

class _GestureScalePageState extends State<GestureScalePage> {
  double _width = 200.0;
  double _height = 200.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('缩放'),
      ),
      body: Center(
        child: GestureDetector(
          //指定宽度，高度自适应
          // child: Container(
          //   width: _width,
          //   height: _height,
          //   color: Colors.red,
          //   alignment: Alignment.center,
          //   child: const Text('Li Shensong',style: TextStyle(color: Colors.white),),
          // ),
          child: Image.asset(
            'assets/images/sea.jpg',
            width: _width,
            height: _height,
            fit: BoxFit.cover,
          ),
          onScaleUpdate: (ScaleUpdateDetails details) {
            setState(() {
              //缩放倍数在0.8到2.0倍之间
              _width = 200 * details.scale.clamp(0.8, 2.0);
              _height = 200 * details.scale.clamp(0.8, 2.0);
              debugPrint("===> details.scale = ${details.scale},_imageWidth = $_width");
            });
          },
        ),
      ),
    );
  }
}
