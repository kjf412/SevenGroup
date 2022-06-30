import 'package:flutter/material.dart';

class MyAnimation extends StatefulWidget {
  const MyAnimation({Key key}) : super(key: key);

  @override
  _ScaleAnimationRouteState createState() => _ScaleAnimationRouteState();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationRouteState extends State<MyAnimation>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  initState() {
    //以下是匀速
    // super.initState();
    // controller = AnimationController(
    //   duration: const Duration(seconds: 2),
    //   vsync: this,
    // );

    // //匀速
    // //图片宽高从0变到300
    // animation = Tween(begin: 0.0, end: 500.0).animate(controller)
    //   ..addListener(() {
    //     setState(() => {});
    //   });

    // //启动动画(正向执行)
    // controller.forward();
    //以下是弹簧式
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    //使用弹性曲线
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    //图片宽高从0变到300
    animation = Tween(begin: 0.0, end: 600.0).animate(animation)
      ..addListener(() {
        setState(() => {});
      });
    //启动动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Image.asset(
            "images/yue.jpg",
            width: animation.value,
            height: animation.value,
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.back_hand_sharp),
            label: const Text("返回"),
            onPressed: () {
              Navigator.pop(context); //从第二个界面返回
            },
          ),
        ],
      )),
    );
  }

  @override
  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}
