import 'package:flutter/material.dart';
import 'package:my_learn_dart/page/manage.dart';
import 'package:my_learn_dart/game/game.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "images/yue.jpg",
                        width: 80,
                      ),
                    ),
                  ),
                  Text(
                    "Wendux",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add account'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Manage accounts'),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.back_hand_sharp),
                    label: const Text("进入游戏"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Mygame()),
                      ); //从第二个界面返回
                    },
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.back_hand_sharp),
                    label: const Text("退出"),
                    onPressed: () {
                      Navigator.pop(context); //从第二个界面返回
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
