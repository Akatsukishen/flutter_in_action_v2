import 'package:flutter/material.dart';

class CustomScrollViewPage extends StatefulWidget {
  const CustomScrollViewPage({Key? key}) : super(key: key);

  @override
  State<CustomScrollViewPage> createState() => _CustomScrollViewPageState();
}

class _CustomScrollViewPageState extends State<CustomScrollViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomScrollView使用'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const TwoListViewPage()),
                );
              },
              child: const Text('两个ListView联合滚动'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const CombinedTwoListView()),
                  );
                },
                child: const Text('调合两个ListView'))
          ],
        ),
      ),
    );
  }
}

/// 两个ListView拼接起来
/// 只是布局上一个上面一个下面
/// 两个ListView都是完整的Sliver按需加载控件，拥有独立的 Scrollable ViewPort Sliver
/// 我们希望达到的效果是ListView1按需加载完之后 再按需加载ListView2
class TwoListViewPage extends StatelessWidget {
  const TwoListViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('两个ListView拼接'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                for (int index = 0; index < 10; index++)
                  ListTile(
                    title: Text('Item$index'),
                  )
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView(
              children: [
                for (int index = 0; index < 10; index++)
                  ListTile(
                    title: Text('Item$index'),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CombinedTwoListView extends StatelessWidget {
  const CombinedTwoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('调合两个ListView'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                      title: Text('Item$index'),
                    ),
                childCount: 20),
            itemExtent: 50,
          ),
          const SliverToBoxAdapter(
            child: Divider(),
          ),
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                      title: Text('Item$index'),
                    ),
                childCount: 20),
            itemExtent: 50,
          ),
        ],
      ),
    );
  }
}

class SliversPage extends StatelessWidget {
  const SliversPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(),
        ],
      ),
    );
  }
}
