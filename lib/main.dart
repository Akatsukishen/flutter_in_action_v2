import 'package:flutter/material.dart';
import 'package:flutter_in_action_v2/ch06/animated_list_page.dart';
import 'package:flutter_in_action_v2/ch06/cache_enable_page_view_page.dart';
import 'package:flutter_in_action_v2/ch06/customscroll_view_page.dart';
import 'package:flutter_in_action_v2/ch06/gridview_count_page.dart';
import 'package:flutter_in_action_v2/ch06/gridview_extent_page.dart';
import 'package:flutter_in_action_v2/ch06/gridview_request_page.dart';
import 'package:flutter_in_action_v2/ch06/list_vew_header_page.dart';
import 'package:flutter_in_action_v2/ch06/list_view_builder_page.dart';
import 'package:flutter_in_action_v2/ch06/list_view_prototype_page.dart';
import 'package:flutter_in_action_v2/ch06/listview_load_page.dart';
import 'package:flutter_in_action_v2/ch06/nested_tab_bar_view.dart';
import 'package:flutter_in_action_v2/ch06/pagevew_cache_controll_page.dart';
import 'package:flutter_in_action_v2/ch06/pageview_simple_page.dart';
import 'package:flutter_in_action_v2/ch06/scroll_controll_page.dart';
import 'package:flutter_in_action_v2/ch06/single_scroll_view_page.dart';
import 'package:flutter_in_action_v2/ch06/snap_app_bar_page.dart';
import 'package:flutter_in_action_v2/ch06/tab_bar_view_default_controller_page.dart';
import 'package:flutter_in_action_v2/ch06/tab_bar_view_page.dart';
import 'package:flutter_in_action_v2/ch07/color_page.dart';
import 'package:flutter_in_action_v2/ch07/dialog_page.dart';
import 'package:flutter_in_action_v2/ch07/inherited_widget_page.dart';
import 'package:flutter_in_action_v2/ch07/theme_page.dart';
import 'package:flutter_in_action_v2/ch07/value_listenable_builder_page.dart';
import 'package:flutter_in_action_v2/ch08/pointer_event_page.dart';
import 'package:flutter_in_action_v2/ch09/animated_switcher_page.dart';
import 'package:flutter_in_action_v2/exercise/asset_image_page.dart';
import 'package:flutter_in_action_v2/exercise/order_page.dart';
import 'package:flutter_in_action_v2/exercise/overflow_page.dart';
import 'package:flutter_in_action_v2/exercise/variable_compile.dart';

import 'ch04/align_page.dart';
import 'ch04/fractional_offset_page.dart';
import 'ch04/layout_builder_page.dart';
import 'ch05/decorated_box_page.dart';
import 'ch05/transform_page.dart';
import 'ch06/list_view_sperated_page.dart';
import 'ch06/sliver_persistent_header_delegate_page.dart';
import 'ch06/snap_app_bar_page2.dart';
import 'ch07/date_picker_page.dart';
import 'ch07/stream_builder_page.dart';
import 'ch09/animated_decorated_box_page.dart';
import 'ch09/animated_switcher_page2.dart';
import 'ch09/animated_widget_page.dart';
import 'ch09/animated_widgets_page.dart';
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
    '触摸事件': (context) => const PointerEventPage(),
    '日期选择': (context) => const DatePickerPage(),
    'dialog使用':(context) => const DialogPage(),
    'streamBuilder页面': (context) => const StreamBuilderPage(),
    'valueListenableBuilder页面': (context) => const ValueListenableBuilderPage(),
    '主题': (context) => const ThemePage(),
    '颜色显示': (context) => const ColorPage(),
    'InheritedWidget': (context) => const InheritedWidgetPage(),
    'ios测试':(context) => const AssetImagePage(),
    'NestedScrollView内嵌TabBarView' : (context) => const NestedTabBarViewPage(),
    '内嵌滚动View头部下拉不遮住已有内容': (context) => const SnapAppBarPage2(),
    '内嵌滚动View头部示例': (context) => const SnapAppBarPage(),
    'SliverPersistentHeader使用':(context) => const SliverPersistentHeaderPage(),
    'CustomScrollView使用': (context) => const CustomScrollViewPage(),
    'TabBarView使用DefaultTabController': (context) =>
        const TabBarViewWithDefaultControllerPage(),
    'TabBarView简单使用': (context) => const TabBarViewPage(),
    'PageView缓存控制': (context) => const PageViewCacheControllPage(),
    'PageView缓存': (context) => const CacheEnablePageViewPage(),
    'PageView简单使用': (context) => const PageViewSimplePage(),
    'GridView动态请求数据': (context) => const GridViewRequestPage(),
    'GridView指定横向最大宽度': (context) => const GridViewExtentPage(),
    'GridView指定横向个数': (context) => const GridViewCountPage(),
    '动画列表': (context) => const AnimatedListPage(),
    '滚动控制': (context) => const ScrollControllPage(),
    'ListView头部': (context) => const ListViewHeaderPage(),
    'ListView动态加载数据': (context) => const ListViewLoadPage(),
    '指定原型创建ListView': (context) => const ListViewPrototypePage(),
    'sperated方式来创建ListView': (context) => const ListViewSperatedPage(),
    'builder方式来创建ListView': (context) => const LiveViewBuilderPage(),
    '单滚动组件': (context) => const SingleChildScrollViewPage(),
    '内置过渡动画组件': (context) => const AnimatedWidgetsPage(),
    '自定义过渡动画组件': (context) => const AnimatedDecoratedBoxPage(),
    '编译期赋值变量': (context) => const CompilingVariablePage(),
    'overflow': (contextt) => const OverFlowPage(),
    '动画切换组件2': (context) => const AnimatedSwitcherPage2(),
    '订单状态管理': (context) => OrderPage(),
    '动画切换组件': (context) => const AnimatedSwitcherPage(),
    'Hero动画': (context) => const HeroPage(),
    '自定义路由切换动画': (context) => const FadeRoutePage(),
    'PageRouteBuilder使用': (context) => const PageRouteBuilderPage(),
    '交织动画': (context) => const StaggerAnimationPage(),
    'AmimatedWidget使用': (context) => const AnimatedWidgetPage(),
    '弹簧放大动画': (context) => const BounceInAnimationPage(),
    '放大动画': (context) => const ScaleAnimationPage(),
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
