import 'package:flutter/material.dart';
import './manage.dart';
import 'dart:math' as math;

class MyTransform extends StatefulWidget {
  @override
  TransformTest createState() => TransformTest();
}

class TransformTest extends State<MyTransform> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("平移")),
        body: Center(
            child: Column(children: <Widget>[
          Container(
            color: Colors.black,
            child: Transform(
              alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
              transform: Matrix4.skewY(0.3), //沿Y轴倾斜0.3弧度
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.deepOrange,
                child: const Text('Apartment for rent!'),
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            //默认原点为左上角，左移20像素，向上平移5像素
            child: Transform.translate(
              offset: Offset(-20.0, -5.0),
              child: Text("Hello world"),
            ),
          ),
          DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              child: Transform.rotate(
                //旋转90度
                angle: math.pi / 2,
                child: Text("Hello world"),
              )),
          DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              child: Transform.scale(
                  scale: 1.5, //放大到1.5倍
                  child: Text("Hello world"))),
          ElevatedButton.icon(
            icon: const Icon(Icons.back_hand_sharp),
            label: const Text("返回"),
            onPressed: () {
              Navigator.pop(context); //从第二个界面返回
            },
          ),
        ])));
  }
}
