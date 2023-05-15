import 'package:flutter/material.dart';

class GridViewRequestPage extends StatefulWidget {
  const GridViewRequestPage({super.key});

  @override
  State<GridViewRequestPage> createState() => _GridViewRequestPageState();
}

class _GridViewRequestPageState extends State<GridViewRequestPage> {
  final _icons = <IconData>[];

  void _retrieveData() {
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      _icons.add(Icons.ac_unit);
      _icons.add(Icons.airport_shuttle);
      _icons.add(Icons.all_inclusive);
      _icons.add(Icons.beach_access);
      _icons.add(Icons.cake);
      _icons.add(Icons.free_breakfast);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 2.0),
        itemBuilder: (context, index) {
          if (index == _icons.length - 1 && _icons.length < 50) {
            _retrieveData();
          }
          return Icon(_icons[index]);
        });
  }
}
