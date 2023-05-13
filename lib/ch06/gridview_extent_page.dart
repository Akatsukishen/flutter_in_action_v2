import 'package:flutter/material.dart';
import 'package:flutter_in_action_v2/ch04/layout_log_print.dart';

/// 按照最大长度来确定横向个数
/// 例如横向宽度 392.7
/// 指定最大宽度为 120 
/// 那么最终横向个数为 392.7 / 120 向上取整 4
/// 最终每个的宽度为 392.7 /4 = 98.2
class GridViewExtentPage extends StatefulWidget {
  const GridViewExtentPage({Key? key}) : super(key: key);

  @override
  State<GridViewExtentPage> createState() => _GridViewExtentPageState();
}

class _GridViewExtentPageState extends State<GridViewExtentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('使用横向最大宽度创建GridView'),
      ),
      body: LayoutLogPrint(
        child: GridView.extent(
          maxCrossAxisExtent: 120,
          childAspectRatio: 2.0,
          mainAxisSpacing: 20,
          padding: const EdgeInsets.only(top: 20),
          children: [
            LayoutLogPrint(
              child: Container(
                width: 80,
                color: Colors.red,
                child: Image.asset(
                  'assets/images/qiaoba_square.jpeg',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            Container(
              width: 80,
              color: Colors.yellow,
            ),
            Container(
              width: 80,
              color: Colors.blue,
            ),
            Container(
              width: 100,
              color: Colors.red,
            ),
            Container(
              width: 120,
              color: Colors.yellow,
            ),
            Container(
              width: 140,
              color: Colors.blue,
            ),
            Container(
              width: 140,
              color: Colors.red,
            ),
            Container(
              width: 140,
              color: Colors.yellow,
            ),
            Container(
              width: 140,
              color: Colors.blue,
            ),
      
          ],
        ),
      ),
    );
  }
}