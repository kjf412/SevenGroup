import 'package:flutter/material.dart';
import './manage.dart';
import './test.dart';
import './apphome_page.dart';
import 'dart:math' as math;
import './transformTest.dart';
import './contain.dart';
import './clip.dart';

class manage extends StatefulWidget {
  @override
  manage_page createState() => manage_page();
}

class manage_page extends State<manage> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    //动画执行时间3秒
    _animationController = AnimationController(
      vsync: this, //注意State类需要混入SingleTickerProviderStateMixin（提供动画帧计时/触发器）
      duration: Duration(seconds: 3),
    );
    _animationController.forward();
    _animationController.addListener(() => setState(() => {}));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('正在登录'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: ColorTween(begin: Colors.red, end: Colors.blue)
                    .animate(_animationController), // 从灰色变成蓝色
                value: _animationController.value,
              ),
            ),
            //！！！！想要能够让图片在进度条结束后显示  目前不会，后续回了来解决
            //   Image.asset(
            //   "images/hua.jpg",
            //   height: 200,
            //   alignment: Alignment.center,
            // ),
            TextButton.icon(
              label: const Text("padding(填充)效果"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => test()),
                );
              },
              icon: const Icon(Icons.login),
            ),
            ElevatedButton.icon(
              label: const Text("进入APP"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => apphome()),
                );
              },
              icon: const Icon(Icons.login),
            ),
            TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyTransform()),
                  );
                },
                icon: Icon(Icons.add),
                label: Text("Transform")),
            TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => contain()),
                  );
                },
                icon: Icon(Icons.expand),
                label: Text("容器组件测试")),
            TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => clip()),
                  );
                },
                icon: Icon(Icons.circle_outlined),
                label: Text("剪裁")),
            ElevatedButton.icon(
              icon: const Icon(Icons.back_hand_sharp),
              label: const Text("返回"),
              onPressed: () {
                Navigator.pop(context); //从第二个界面返回
              },
            ),
          ],
        ),
      ),
    );
  }
}
