import 'package:flutter/material.dart';
import 'package:flutter_in_action_v2/ch04/fractional_offset_page.dart';
import 'package:flutter_in_action_v2/ch04/layout_builder_page.dart';
import 'package:flutter_in_action_v2/ch05/decorated_box_page.dart';
import 'package:flutter_in_action_v2/ch05/transform_page.dart';
import 'package:flutter_in_action_v2/ch09/scale_animation_page.dart';

import 'ch04/align_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter实战(第2版)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeEntryPage(),
    );
  }
}

class HomeEntryPage extends StatelessWidget {
  HomeEntryPage({super.key});

  final _entries = <String, WidgetBuilder>{
    '放大动画' : (context) => const ScaleAnimationPage(),
    'Transform使用': (context) => const TransformPage(),
    'DecoratedBox使用': (context) => const DecoratedBoxPage(),
    'LayoutBuilder使用': (context) => const LayoutBuilderPage(),
    "Fractional使用": (context) => const FractionalOffsetPage(),
    "Align使用": (context) => const AlignPage()
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter实战(第2版)'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: _entries[_entries.keys.toList()[index]]!),
            );
          },
          title: Text(
            _entries.keys.toList()[index],
          ),
        ),
        itemCount: _entries.length,
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
