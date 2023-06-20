import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class StaggerWaterMaskPage extends StatelessWidget {
  const StaggerWaterMaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义水印2'),
      ),
      body: Stack(
        children: [
          wPage(),
          IgnorePointer(
            child: WaterMask(
              painter: StaggerTextWaterMaskPainter(
                text: 'Flutter ',
                text2: '李晓神',
                textStyle: const TextStyle(
                  color: Colors.black38,
                ),
                padding2: const EdgeInsets.only(left: 20),
                staggerAxis: Axis.vertical,
                rotate: -20,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget wPage() {
    return Center(
      child: ElevatedButton(
        child: const Text('按钮'),
        onPressed: () {
          debugPrint("===> tab");
        },
      ),
    );
  }
}

class WaterMaskPage extends StatelessWidget {
  const WaterMaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义水印'),
      ),
      body: Stack(
        children: [
          wPage(),
          IgnorePointer(
            child: WaterMask(
              painter: TextWaterMaskPainter(
                text: 'Flutter 李晓神',
                textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w200,
                    color: Colors.black38),
                rotate: -20,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget wPage() {
    return Center(
      child: ElevatedButton(
        child: const Text('按钮'),
        onPressed: () {
          debugPrint("===> tab");
        },
      ),
    );
  }
}

class WaterMask extends StatefulWidget {
  const WaterMask(
      {Key? key, required this.painter, this.imageRepeat = ImageRepeat.repeat})
      : super(key: key);

  final WaterMaskPainter painter;

  final ImageRepeat imageRepeat;

  @override
  State<WaterMask> createState() => _WaterMaskState();
}

class _WaterMaskState extends State<WaterMask> {
  late Future<MemoryImage> _memoryImageFuture;

  @override
  void initState() {
    _memoryImageFuture = _getWaterMaskImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      //水印足够大
      child: FutureBuilder(
          future: _memoryImageFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Container();
            } else {
              return DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: snapshot.data,
                      repeat: widget.imageRepeat,
                      alignment: Alignment.topLeft,
                      scale: MediaQuery.of(context).devicePixelRatio),
                ),
              );
            }
          }),
    );
  }

  @override
  void didUpdateWidget(covariant WaterMask oldWidget) {
    if (widget.painter.runtimeType != oldWidget.painter.runtimeType ||
        widget.painter.shouldRepaint(oldWidget.painter)) {
      ///释放缓存
      _memoryImageFuture.then((value) => value.evict());

      ///重新绘制并缓存
      _memoryImageFuture = _getWaterMaskImage();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<MemoryImage> _getWaterMaskImage() async {
    //创建canvas进行离屏绘制
    final PictureRecorder recorder = PictureRecorder();
    final canvas = Canvas(recorder);

    // 绘制单元水印并获取大小
    final Size size = widget.painter
        .paintUnit(canvas, MediaQueryData.fromWindow(window).devicePixelRatio);
    final picture = recorder.endRecording();

    final img = await picture.toImage(size.width.ceil(), size.height.ceil());
    final byteData = await img.toByteData(format: ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();
    return MemoryImage(pngBytes);
  }

  @override
  void dispose() {
    _memoryImageFuture.then((value) => value.evict());
    super.dispose();
  }
}

abstract class WaterMaskPainter {
  /// 完整的水印由单元水印平铺组成，返回‘单元水印’的大小
  /// [devicePixelRatio] 因为最终要将绘制内容保存为图片，绘制时要根据屏幕尺寸放大，以免失真
  Size paintUnit(Canvas canvas, double devicePixelRatio);

  bool shouldRepaint(covariant WaterMaskPainter painter) => true;
}

class TextWaterMaskPainter extends WaterMaskPainter {
  TextWaterMaskPainter({
    Key? key,
    double? rotate,
    EdgeInsets? padding,
    TextStyle? textStyle,
    required this.text,
    this.textDirection = TextDirection.ltr,
  })  : assert(rotate == null || rotate >= -90 && rotate <= 90),
        rotate = rotate ?? 0,
        padding = padding ?? const EdgeInsets.all(10.0),
        textStyle = textStyle ??
            const TextStyle(
              color: Color.fromARGB(20, 0, 0, 0),
              fontSize: 14,
            );

  final double rotate; // 文字旋转的角度，不是弧度
  final TextStyle textStyle;
  EdgeInsets padding;
  String text;
  TextDirection textDirection;

  @override
  Size paintUnit(Canvas canvas, double devicePixelRatio) {
    //根据屏幕 devicePixelRatio 对文本样本中长度相关的一些值乘以devicePixelRatio
    final _textStyle = _handleTextStyle(textStyle, devicePixelRatio);
    final _padding = padding * devicePixelRatio;

    //构建文本段落
    TextPainter painter = TextPainter(
        textDirection: TextDirection.ltr, textScaleFactor: devicePixelRatio);

    //需要添加的文本及样式
    painter.text = TextSpan(text: text, style: _textStyle);
    //对文本进行布局
    painter.layout();

    //文本占用的真实宽度
    final textWidth = painter.width;
    //文本占用的真实高度
    final textHeight = painter.height;

    //将度数转换为弧度
    final radians = math.pi * rotate / 180;

    //通过三角函数旋转后的位置和size
    final orgSin = math.sin(radians);
    final sin = orgSin.abs();
    final cos = math.cos(radians).abs();

    final width = textWidth * cos;
    final height = textWidth * sin;
    final adjustWidth = textHeight * sin;
    final adjustHeight = textHeight * cos;

    if (orgSin >= 0) {
      //旋转角度为正
      canvas.translate(adjustWidth + _padding.left, _padding.top);
    } else {
      canvas.translate(_padding.left, height + _padding.top);
    }
    canvas.rotate(radians);

    //绘制文本
    painter.paint(canvas, Offset.zero);

    return Size(width + adjustWidth + _padding.horizontal,
        height + adjustHeight + _padding.vertical);
  }

  TextStyle _handleTextStyle(TextStyle textStyle, double devicePixelRatio) {
    var style = textStyle;
    double _scale(attr) => attr == null ? 1.0 : devicePixelRatio;
    return style.apply(
        decorationThicknessFactor: _scale(style.decorationThickness),
        letterSpacingFactor: _scale(style.letterSpacing),
        wordSpacingFactor: _scale(style.wordSpacing),
        heightFactor: _scale(style.height));
  }

  @override
  bool shouldRepaint(TextWaterMaskPainter oldPainter) {
    return oldPainter.rotate != rotate ||
        oldPainter.text != text ||
        oldPainter.padding != padding ||
        oldPainter.textDirection != textDirection ||
        oldPainter.textStyle != textStyle;
  }
}

class StaggerTextWaterMaskPainter extends WaterMaskPainter {
  StaggerTextWaterMaskPainter(
      {required this.text,
      this.padding1,
      this.padding2 = const EdgeInsets.all(30),
      this.rotate,
      this.textStyle,
      this.staggerAxis = Axis.vertical,
      String? text2})
      : text2 = text2 ?? text;

  String text;
  String text2;

  double? rotate;
  TextStyle? textStyle;
  EdgeInsets? padding1;
  EdgeInsets padding2;
  Axis staggerAxis;

  @override
  Size paintUnit(Canvas canvas, double devicePixelRatio) {
    final TextWaterMaskPainter painter = TextWaterMaskPainter(
      text: text,
      padding: padding1,
      rotate: rotate ?? 0,
      textStyle: textStyle,
    );
    canvas.save();
    final size1 = painter.paintUnit(canvas, devicePixelRatio);
    canvas.restore();
    bool vertical = staggerAxis == Axis.vertical;
    canvas.translate(vertical ? 0 : size1.width, vertical ? size1.height : 0);
    painter
      ..padding = padding2
      ..text = text2;

    final size2 = painter.paintUnit(canvas, devicePixelRatio);
    return Size(
      vertical ? math.max(size1.width, size2.width) : size1.width + size2.width,
      vertical
          ? size1.height + size2.height
          : math.max(size1.height, size2.height),
    );
  }

  @override
  bool shouldRepaint(StaggerTextWaterMaskPainter oldPainter) {
    return oldPainter.rotate != rotate ||
        oldPainter.text != text ||
        oldPainter.text2 != text2 ||
        oldPainter.staggerAxis != staggerAxis ||
        oldPainter.padding1 != padding1 ||
        oldPainter.padding2 != padding2 ||
        oldPainter.textStyle != textStyle;
  }
}
