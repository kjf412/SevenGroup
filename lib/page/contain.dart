import 'package:flutter/material.dart';
import './manage.dart';
import 'dart:math' as math;
import './transformTest.dart';
import './contain.dart';

class contain extends StatelessWidget {
  const contain({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("平移")),
        body: Center(
            child: Column(children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 50.0, left: 120.0),
            constraints:
                BoxConstraints.tightFor(width: 200.0, height: 150.0), //卡片大小
            decoration: const BoxDecoration(
              //背景装饰
              gradient: RadialGradient(
                //背景径向渐变
                colors: [Colors.red, Colors.orange],
                center: Alignment.topLeft,
                radius: .98,
              ),
              boxShadow: [
                //卡片阴影
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0,
                )
              ],
            ),
            transform: Matrix4.rotationZ(.2), //卡片倾斜变换
            alignment: Alignment.center, //卡片内文字居中
            child: const Text(
              //卡片文字
              "5.20", style: TextStyle(color: Colors.white, fontSize: 40.0),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0), //容器外补白
            color: Colors.orange,
            child: Text("margin"),
          ),
          Container(
            padding: EdgeInsets.all(20.0), //容器内补白
            color: Colors.orange,
            child: Text("padding"),
          ),
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
