import 'package:flutter/material.dart';
import 'package:flutter_in_action_v2/base/base_page.dart';

/// 比例偏移
/// Align组件对align属性进行赋值FractionalOffset
/// 1. FractionOffset 的偏移是child 相对于Align的。
/// 2. FractionOffset 坐标是以左上角作为起点。
/// 3. 偏移公式 x = (align.width - child.width) * offsetX
///    这样，offsetX = 1.0 的时候，child右边恰好顶住了align的右边
///    同理  y = (align.height - chilid.height) * offsetY
///
class FractionalOffsetPage extends BasePage {
  const FractionalOffsetPage({super.key, super.title = 'FractionnalOffset'});

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 300,
          height: 300,
          color: Colors.blue.shade50,
          child: UnconstrainedBox(
            child: Container(
              color: Colors.green,
              child: Align(
                alignment: const FractionalOffset(0.2, 0.3),
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 300,
          height: 300,
          color: Colors.blue.shade50,
          child: UnconstrainedBox(
            child: Container(
              color: Colors.green,
              child: Align(
                widthFactor: 2.0,
                heightFactor: 2.0,
                alignment: const FractionalOffset(0.3, 0.5),
                child: Container(
                  width: 100,
                  height: 100,
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
