import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// 手势冲突 只是手势级别的，也就是说只会在组件树存在【多个GestureDetector】的情况下才会有收拾冲突。
/// 如果压根就没有使用【GestureDetector】，则不存在手势冲突。
/// 1. 使用最原始的Listener来处理事件。
/// 2. 使用自定义【手势识别器】,在手势冲突的手势【竞争失败】的情况下，【强行】宣称自己竞争成功，而后面也能触发自己的事件处理。
/// 
class CustomGestureRecognizerPage extends StatelessWidget {
  const CustomGestureRecognizerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义手势识别器'),
      ),
      body: Center(
        child: customGestureDetector(
          onTap: () {
            debugPrint("===> onTap2.");
          },
          child: Container(
            width: 200,
            height: 200,
            color: Colors.red,
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                debugPrint("===> onTap1.");
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    // super.rejectGesture(pointer);
    super.acceptGesture(pointer);
  }
}

RawGestureDetector customGestureDetector({
  GestureTapCallback? onTap,
  GestureTapDownCallback? onTapDown,
  Widget? child,
}) {
  return RawGestureDetector(
    gestures: {
      CustomGestureRecognizer:
          GestureRecognizerFactoryWithHandlers<CustomGestureRecognizer>(
        () => CustomGestureRecognizer(),
        (detector) {
          detector.onTap = onTap;
        },
      )
    },
    child: child,
  );
}
