import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

/// getTemporaryDirectory() 临时目录 
///   ios对应 NSTemporaryDirectory() android对应getCacheDir(), 随时可能被系统清除
/// getApplicationDocumentDirectory() app文档目录
///   ios对应 NSDocumentDirectory() android对应AppData目录
/// getExternalStorageDirectory() 来获取外部存储目录 如SD卡
///   ios不支持外部目录,会抛出UnsupportedError
///   android返回getExternalStorageDirectory()
class FileOperationPage extends StatefulWidget {
  const FileOperationPage({super.key});

  @override
  State<FileOperationPage> createState() => _FileOperationPageState();
}

class _FileOperationPageState extends State<FileOperationPage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _readCounter().then((value) {
      setState(() {
        _counter = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文件简单操作'),
      ),
      body: Center(
        child: Text('点击了 $_counter 次'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await (await _getLocalFile()).writeAsString('$_counter');
  }

  Future<File> _getLocalFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return File('$dir/counter.txt');
  }

  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      String content = await file.readAsString();
      return int.parse(content);
    } on FileSystemException {
      return 0;
    }
  }
}
