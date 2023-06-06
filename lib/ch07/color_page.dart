import 'package:flutter/material.dart';

///颜色转换 Color(int.parse('00FFFF',radix: 16)).withAlpha(255)
///shadeXX XX颜色深度 50 100 200 300 400 500 600 700 800 900
///默认值是shade500 -> Colors.blue.shade500
class ColorPage extends StatefulWidget {
  const ColorPage({Key? key}) : super(key: key);

  @override
  State<ColorPage> createState() => _ColorPageState();
}

class _ColorPageState extends State<ColorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('颜色显示'),
      ),
      body: Column(
        children: [
          NavBar(title: '标题', color: Color(int.parse('00FFFF',radix: 16)).withAlpha(255)),
          const NavBar(title: '标题', color: Colors.blue),
          const NavBar(title: '标题', color: Colors.white),
          //shadeXX XX颜色深度 50 100 200 300 400 500 600 700 800 900
          //默认值是shade500 -> Colors.blue.shade500
          NavBar(title: '浅蓝背景', color: Colors.blue.shade50),
          const NavBar(title: '默认蓝色背景', color: Colors.blue),
          NavBar(title: '深蓝背景', color: Colors.blue.shade900),
        ],
      ),
    );
  }
}

/// computeLuminance 计算亮度
class NavBar extends StatelessWidget {
  final String title;
  final Color color;

  const NavBar({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 52,
        minWidth: double.infinity,
      ),
      decoration: BoxDecoration(color: color, boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(0, 3),
          blurRadius: 3,
        )
      ]),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          //亮度 数值越大越亮
          color: color.computeLuminance() < 0.5 ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
