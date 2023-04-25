import 'package:flutter/material.dart';

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
    "Align使用": (context) => const AlignPage()
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter实战(第2版)'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: _entries[_entries.keys.toList()[index]]!
                    ),
                  );
              },
              child: Text(
                _entries.keys.toList()[index],
              )),
        ),
        itemCount: _entries.length,
      ),
    );
  }
}
