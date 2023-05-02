import 'dart:math';

import 'package:flutter/material.dart';

import '../base/base_page.dart';

class TransformPage extends BasePage {
  const TransformPage({super.key, super.title = "Transform使用"});

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 100,),
          Container(
            color: Colors.black,
            child: Transform(
              alignment: Alignment.topRight, //轴点
              transform: Matrix4.skewY(0.3),  //沿着Y轴倾斜0.3弧度
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.deepOrange,
                child: const Text('Apartment for rent!'),
              ),
            ),
          ),
          const SizedBox(height: 50,),
          DecoratedBox(
            decoration: const BoxDecoration(color: Colors.red),
            child: Transform.translate( //内容向指定方向平移
              offset: const Offset(-20.0, -5.0),
              child: const Text('Hello world.'),
            ),
          ),
          const SizedBox(height: 50,),
          DecoratedBox(
            decoration: const BoxDecoration(color: Colors.red),
            child: Transform.rotate(
              angle: pi / 2, //内容旋转90度
              child: const Text('Hello world'),
            ),
          ),
          const SizedBox(height: 50,),
          DecoratedBox(
            decoration: const BoxDecoration(color: Colors.red),
            child: Transform.scale(
              scale: 1.5,
              child: const Text('Hello world'),
            ),
          ),
          const SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DecoratedBox(
                decoration: const BoxDecoration(color: Colors.red),
                child: Transform.scale( //transform操作应用于绘制阶段
                  scale: 1.5,
                  child: const Text('Hello world'),
                ),  
              ),
              const Text('你好',style: TextStyle(color: Colors.green,fontSize: 18.0),)
            ],
          ),
          const SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: RotatedBox( //transform操作应用于绘制阶段
                  quarterTurns: 1,
                  child: Text('Hello world'),
                ),  
              ),
              Text('你好',style: TextStyle(color: Colors.green,fontSize: 18.0),)
            ],
          ),
        ],
      ),
    );
  }
}
