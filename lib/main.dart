import 'package:flutter/material.dart';
import 'package:flutter_in_action_v2/ch09/animated_switcher_page.dart';

import 'ch04/align_page.dart';
import 'ch04/fractional_offset_page.dart';
import 'ch04/layout_builder_page.dart';
import 'ch05/decorated_box_page.dart';
import 'ch05/transform_page.dart';
import 'ch09/animated_widget_page.dart';
import 'ch09/bouncein_anamition_page.dart';
import 'ch09/fade_route_page.dart';
import 'ch09/hero_page.dart';
import 'ch09/pageroute_builder_page.dart';
import 'ch09/scale_animation_page.dart';
import 'ch09/stagger_animation_page.dart';

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
    '动画切换组件': (context) => const AnimatedSwitcherPage(),
    'Hero动画': (context) => const HeroPage(),
    '自定义路由切换动画': (context) => const FadeRoutePage(),
    'PageRouteBuilder使用': (context) => const PageRouteBuilderPage(),
    '交织动画':  (context) => const StaggerAnimationPage(),
    'AmimatedWidget使用': (context) => const AnimatedWidgetPage(),
    '弹簧放大动画': (context) => const BounceInAnimationPage(),
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
          dense: false,
        ),
        itemCount: _entries.length,
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
