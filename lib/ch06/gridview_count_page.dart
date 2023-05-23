import 'package:flutter/material.dart';

class GridViewCountPage extends StatefulWidget {
  const GridViewCountPage({Key? key}) : super(key: key);

  @override
  State<GridViewCountPage> createState() => _GridViewCountPageState();
}

class _GridViewCountPageState extends State<GridViewCountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GridView指定横向个数'),
      ),
      body: GridView.count(
        crossAxisCount: 3,

        ///指定横向多少列,可以计算出每列的宽度
        childAspectRatio: 1.0,

        ///指定宽高比，可以计算出子元素的高度
        children: const [
          Icon(Icons.ac_unit),
          Icon(Icons.airport_shuttle),
          Icon(Icons.all_inclusive),
          Icon(Icons.beach_access),
          Icon(Icons.cake),
          Icon(Icons.free_breakfast)
        ],
      ),
    );
  }
}
