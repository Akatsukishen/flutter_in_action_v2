import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class ListViewLoadPage extends StatefulWidget {
  const ListViewLoadPage({super.key});

  @override
  State<ListViewLoadPage> createState() => _ListViewLoadPageState();
}

class _ListViewLoadPageState extends State<ListViewLoadPage> {
  static const _loadingTag = "### loading ####";
  final _words = <String>[_loadingTag];

  void _retrieveData() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        _words.insertAll(
          _words.length - 1,
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList()
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('下滑加载数据'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          if (_words[index] == _loadingTag) {
            if (_words.length - 1 < 100) {
              _retrieveData();
              return Container(
                padding: const EdgeInsets.all(6),
                alignment: Alignment.center,
                child: const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
              );
            } else {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(6),
                child: const Text(
                  '没有更多了',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
          } else {
            return ListTile(
              title: Text('$index'),
            );
          }
        },
        separatorBuilder: (context, indext) => const Divider(
          height: .0,
        ),
        itemCount: _words.length,
      ),
    );
  }
}
