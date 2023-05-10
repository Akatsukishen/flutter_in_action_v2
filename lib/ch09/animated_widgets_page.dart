import 'package:flutter/material.dart';

class AnimatedWidgetsPage extends StatefulWidget {
  const AnimatedWidgetsPage({Key? key}) : super(key: key);

  @override
  State<AnimatedWidgetsPage> createState() => _AnimatedWidgetsPageState();
}

/// 内置过渡动动画组件
/// AnimatedPadding           padding变化时触发
/// AnimatedPositioned        配合Stack使用
/// AnimatedOpacity           透明度变化时触发
/// AnimatedAlign             当aligmnet变化时触发
/// AnimatedContainer         当Container属性变化时触发
/// AnimatedDefaultTextStyle  当字体样式变化时触发
class _AnimatedWidgetsPageState extends State<AnimatedWidgetsPage> {
  double _padding = 10;
  double _left = 0;
  AlignmentGeometry _align = Alignment.topRight;
  double _height = 100;
  Color _color = Colors.red;
  TextStyle _style = const TextStyle(color: Colors.red, fontSize: 16);
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    var duration = const Duration(milliseconds: 400);
    return Scaffold(
      appBar: AppBar(
        title: const Text('内置动画过渡组件'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _padding = _padding == 10 ? 20 : 10;
                });
              },
              child: AnimatedPadding(
                //更改padding
                padding: EdgeInsets.all(_padding),
                duration: duration,
                child: const Text('AnimatedPadding'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    //更改位置，配合Stack使用
                    left: _left,
                    duration: duration,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _left = _left == 0 ? 100 : 0;
                        });
                      },
                      child: const Text('AnimatedPositioned'),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 100,
              color: Colors.grey,
              child: AnimatedAlign(
                duration: duration,
                alignment: _align, //更改对齐方式
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _align = _align == Alignment.center
                          ? Alignment.topRight
                          : Alignment.center;
                    });
                  },
                  child: const Text('AnimatedAlign'),
                ),
              ),
            ),
            AnimatedContainer(
              //动画容器
              duration: duration,
              height: _height,
              color: _color,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _height = _height == 100 ? 150 : 100;
                    _color = _color == Colors.red ? Colors.blue : Colors.red;
                  });
                },
                child: const Text(
                  'AniamatedContainer',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            AnimatedDefaultTextStyle(
              //文本样式改变
              style: _style,
              duration: duration,
              child: GestureDetector(
                child: const Text('hello world'),
                onTap: () {
                  setState(() {
                    _style = _style.color != Colors.blue
                        ? const TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            decorationStyle: TextDecorationStyle.solid,
                            decorationColor: Colors.blue)
                        : const TextStyle(color: Colors.red, fontSize: 16);
                  });
                },
              ),
            ),
            AnimatedOpacity(
              opacity: _opacity,
              duration: duration,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)
                ),
                onPressed: () {
                  setState(() {
                    _opacity = _opacity == 1.0 ? 0.2 : 1.0;
                  });
                },
                child: const Text(
                  'AnimatedOpacity',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ].map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: e,
            );
          }).toList(),
        ),
      ),
    );
  }
}
