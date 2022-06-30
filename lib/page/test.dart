import 'package:flutter/material.dart';
import './manage.dart';
import 'dart:math' as math;
import './transformTest.dart';
import './contain.dart';
import './clip.dart';

class test extends StatelessWidget {
  const test({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      //上下左右各添加16像素补白
      padding: const EdgeInsets.all(16),
      child: Column(
        //显式指定对齐方式为左对齐，排除对齐干扰
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Padding(
            //左边添加8像素补白
            padding: EdgeInsets.only(left: 20),
            child: Text("Hello world"),
          ),
          const Padding(
            //上下各添加8像素补白
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text("I am Kong"),
          ),
          const Padding(
            // 分别指定四个方向的补白
            padding: EdgeInsets.fromLTRB(80, 0, 20, 20),
            child: Text("Your friend"),
          ),
          DecoratedBox(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.red, Colors.blue.shade800]), //背景渐变
                  borderRadius: BorderRadius.circular(60), //3像素圆角
                  boxShadow: const [
                    //阴影
                    BoxShadow(
                        color: Colors.black54,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 4.0)
                  ]),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
                child: Text(
                  "渐变按钮",
                  style: TextStyle(color: Colors.white),
                ),
              )),
          DecoratedBox(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://seopic.699pic.com/photo/40026/3638.jpg_wh1200.jpg")),
                  borderRadius: BorderRadius.circular(60), //3像素圆角
                  boxShadow: const [
                    //阴影
                    BoxShadow(
                        color: Colors.black54,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 4.0)
                  ]),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
                child: Text(
                  "图片加载",
                  style: TextStyle(color: Colors.white),
                ),
              )),
          ElevatedButton.icon(
            icon: const Icon(Icons.back_hand_sharp),
            label: const Text("返回"),
            onPressed: () {
              Navigator.pop(context); //从第二个界面返回
            },
          ),
        ],
      ),
    );
  }
}
