import 'package:flutter/material.dart';

class SnapAppBarPage extends StatelessWidget {
  const SnapAppBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: true, //头部是浮动的，不是固定到顶部，可以滑出顶部
              snap: true, //一有向下滑动的动作，就显示头部
              expandedHeight: 200,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/images/sea.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Builder(
          builder: (context) {
            return CustomScrollView(
              slivers: [buildSliverList(100)],
            );
          },
        ),
      ),
    );
  }

  Widget buildSliverList([int count = 5]) {
    return SliverFixedExtentList.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('$index'),
          );
        },
        itemCount: count,
        itemExtent: 50);
  }
}
