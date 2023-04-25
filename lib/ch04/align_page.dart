import 'package:flutter/material.dart';
import 'package:flutter_in_action_v2/base/base_page.dart';

/// 1.相对定位 是Align组件相对于父组件。
/// 2.Align组件 如果不指定widthFactor,heightFactor的话，大小就是子组件的大小
///   指定了widthFactor,heightFactor，Align组件大小
/// 3.子组件的坐标公式(https://segmentfault.com/a/1190000041631644)
/// var x = (alignWidth - childWidth) / 2 + x * ((alignWidth - childWidth) / 2);
/// var y = (alignHeight - childHeight) / 2 + x * ((parentHeight - childHeight) / 2);
class AlignPage extends BasePage {
  const AlignPage({super.key,super.title = "Align使用"});
  
  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue.shade50,
          width: 180,
          height: 180,
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 60,
              width: 60,
              color: Colors.red,
            ),
          ),
        ),
        const SizedBox(height: 10,),
        Container(
          width: 360,
          height: 360,
          color: Colors.blue.shade100,
          child: UnconstrainedBox(
            child: Container(
              color: Colors.green,
              child: Align( //widthFactor,heightFactor 用于确定Align组件本身宽高的属性
                alignment: Alignment.topRight,
                widthFactor: 5.0,
                heightFactor: 5.0,
                child: Container(
                  height: 50,
                  width: 50,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

}