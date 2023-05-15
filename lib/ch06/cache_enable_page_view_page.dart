import 'package:flutter/material.dart';

///子列表项 混入 AutomaticKeepAliveClientMixin
///AutomaticKeepAliveClientMixin 充当服务器的角色来存储缓存的操作
///子列表项 返回wantKeepAlive，来表示是否需要缓存
///如果返回true表示需要缓存，那么AutomaticKeepAliveClientMixin会自动缓存
class CacheEnablePageViewPage extends StatefulWidget {
  const CacheEnablePageViewPage({Key? key}) : super(key: key);

  @override
  State<CacheEnablePageViewPage> createState() =>
      _CacheEnablePageViewPageState();
}

class _CacheEnablePageViewPageState extends State<CacheEnablePageViewPage> {
  final _pages = <CacheEnablePage>[];

  @override
  void initState() {
    super.initState();
    for (int i = 1; i < 6; i++) {
      _pages.add(CacheEnablePage(title: 'Page $i'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('可缓存的PageView'),
      ),
      body: PageView(
        children: _pages,
      ),
    );
  }
}

class CacheEnablePage extends StatefulWidget {
  const CacheEnablePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CacheEnablePage> createState() => _CacheEnablePageState();
}

class _CacheEnablePageState extends State<CacheEnablePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(
        context); //使用AutomaticKeepAliveClientMixin时build必须调用super,进行缓存操作。
    debugPrint("===> build. ${widget.title}");
    return Center(
      child: Text(widget.title),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
