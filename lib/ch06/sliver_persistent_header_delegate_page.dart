import 'package:flutter/material.dart';

class SliverPersistentHeaderPage extends StatefulWidget {
  const SliverPersistentHeaderPage({Key? key}) : super(key: key);

  @override
  State<SliverPersistentHeaderPage> createState() =>
      _SliverPersistentHeaderPageState();
}

class _SliverPersistentHeaderPageState
    extends State<SliverPersistentHeaderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义SliverPersistentHeaderDelegate'),
      ),
      body: CustomScrollView(
        slivers: [
          buildSliverList(),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverHeaderDelegate(
              maxHeight: 100,
              minHeight: 50,
              child: buildHeader(1),
            ),
          ),
          // buildSliverList(),
          // SliverPersistentHeader(
          //   pinned: true,
          //   delegate: SliverHeaderDelegate.fixedHeight(
          //     height: 50,
          //     child: buildHeader(2),
          //   ),
          // ),
          buildSliverList(20),
        ],
      ),
    );
  }

  Widget buildSliverList([int count = 5]) {
    return SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
                  title: Text('$index'),
                ),
            childCount: count),
        itemExtent: 50);
  }

  Widget buildHeader(int i) {
    return Container(
      color: Colors.lightBlue.shade200,
      alignment: Alignment.centerLeft,
      child: Text('PersistentHeader $i'),
    );
  }
}

typedef SliverHeaderBuilder = Widget Function(
    BuildContext context, double shrinkOffset, bool overlapsContent);

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  SliverHeaderDelegate(
      {required this.maxHeight, this.minHeight = 0, required Widget child})
      : builder = ((a, b, c) => child),
        assert(minHeight <= maxHeight && minHeight >= 0);

  SliverHeaderDelegate.fixedHeight({
    required double height,
    required Widget child,
  })  : builder = ((a, b, c) => child),
        maxHeight = height,
        minHeight = height;

  SliverHeaderDelegate.builder({
    required this.maxHeight,
    this.minHeight = 0,
    required this.builder,
  });

  final double maxHeight;
  final double minHeight;
  final SliverHeaderBuilder builder;

  ///shrinkOffset 向上滚动时，刚接触到顶部时为0，继续向上滚动到达 maxExtent后不再回调
  /// 向下滚动，滚动到合适时开始触发回调，从maxExtent开始直至到0 header从顶部脱离。
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    debugPrint("===> build. shrinkOffset = $shrinkOffset");
    Widget child = builder(context, shrinkOffset, overlapsContent);
    assert(() {
      if (child.key != null) {
        debugPrint(
            '${child.key}: shrink : $shrinkOffset, overlapsContent = $overlapsContent');
      }
      return true;
    }());
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxExtent ||
        oldDelegate.minExtent != minExtent;
  }
}
