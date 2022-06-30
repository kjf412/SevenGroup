import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'position.dart';
import './random_queue.dart';
import 'maze_game_model.dart';

class Mygame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  if (Platform.isAndroid) {
    //     // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    //     S ystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    //     SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    //   }
    return MaterialApp(
      title: '方块迷宫',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int gameWidth, gameHeight; //游戏地图宽度和高度
  double itemWidth, itemHeight; //每个小方块的宽度和高度
  int level = 1; //当前关卡数（共10关）
  int rowSum = 15; //游戏地图行数
  int columnSum = 15; //游戏地图列数
  int surplusTime; //游戏剩余时间
  bool isTip = false; //是否使用提示功能
  Timer timer; //计时器
  MazeGameModel _model; //迷宫游戏数据层

  //初始化状态
  @override
  void initState() {
    super.initState();
    _model = new MazeGameModel(rowSum, columnSum);

    //新建一个事件循环队列，确保不堵塞主线程
    new Future(() {
      //生成一个迷宫
      _doGenerator(_model.getStartX(), _model.getStartY() + 1);
    });

    //设置倒计时
    _setSurplusTime(level);
  }

  @override
  Widget build(BuildContext context) {
    //获取手机屏幕宽度，并让屏幕高度等于屏幕宽度（确保形成正方形迷宫区域）
    //结果向下取整，避免出现实际地图宽度大于手机屏幕宽度的情况
    gameHeight = gameWidth = MediaQuery.of(context).size.width.floor();
    //每一个小方块的宽度和长度（屏幕宽度/列数）
    itemHeight = itemWidth = (gameWidth / columnSum);
    return Scaffold(
      appBar: PreferredSize(
          //设置标题栏高度
          preferredSize: Size.fromHeight(40),
          //标题栏区域
          child: _appBarWidget()),
      body: ListView(
        children: <Widget>[
          //游戏地图区域
          _gameMapWidget(),
          //游戏提示与操作栏区域
          _gameTipWidget(),
          //游戏方向控制区域
          _gameControlWidget(),
        ],
      ),
    );
  }

  //标题栏区域
  Widget _appBarWidget() {
    return AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("方块迷宫"),
              Text("第" +
                  level.toString() +
                  "关" +
                  "  (" +
                  rowSum.toString() +
                  "x" +
                  columnSum.toString() +
                  ")")
            ]));
  }

  //游戏地图区域
  Widget _gameMapWidget() {
    return Container(
        width: gameWidth.toDouble(),
        height: gameHeight.toDouble(),
        color: Colors.white,
        child: Center(
          //可堆叠布局（配合Positioned绝对布局使用）
          child: Stack(
            //按行遍历
            children: List.generate(_model.mazeMap.length, (i) {
              return Stack(
                  //按列遍历
                  children: List.generate(_model.mazeMap[i].length, (j) {
                //绝对布局
                return Positioned(
                    //每个方块的位置
                    left: j * itemWidth.toDouble(),
                    top: i * itemHeight.toDouble(),
                    //每个方块的大小和颜色
                    child: Container(
                        width: itemWidth.toDouble(),
                        height: itemHeight.toDouble(),
                        color: _model.mazeMap[i][j] == 0
                            ? Color.fromARGB(255, 0, 168, 253)
                            : (_model.playerX == i && _model.playerY == j)
                                ? Colors.purple
                                : (_model.getEndX() == i &&
                                        _model.getEndY() == j)
                                    ? Colors.deepOrange
                                    : _model.path[i][j]
                                        ? Colors.orange
                                        : Colors.white));
              }));
            }),
          ),
        ));
  }

  //游戏提示与操作栏区域
  Widget _gameTipWidget() {
    return Container(
      child: ButtonBar(
        alignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              //如果本关没有使用提示功能
              if (!isTip) {
                isTip = true; //使用提示功能
                //清空访问的路径信息
                for (int i = 0; i < _model.getRowSum(); i++) {
                  for (int j = 0; j < _model.getColumnSum(); j++) {
                    _model.visited[i][j] = false;
                  }
                }
                //开始解迷宫
                _doSolver(_model.getStartX(), _model.getStartY());

                //2秒后清空提示信息(清空正确的解路径)
                Future.delayed(Duration(seconds: 2), () {
                  _setModelWithClearPath();
                });
              }
              //如果本关已使用提示功能
              else {
                Fluttertoast.showToast(
                    msg: "每一关只能使用一次提示功能哦～",
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 15.0);
              }
            },
            color: Colors.green,
            child: Text("提示"),
          ),
          Text(
            "剩余时间:" + surplusTime.toString() + "秒",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrangeAccent),
          )
        ],
      ),
    );
  }

  //游戏方向键控制区域
  Widget _gameControlWidget() {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.blue, width: 3)),
            child: IconButton(
                padding: EdgeInsets.all(0),
                iconSize: 50,
                icon: Icon(Icons.keyboard_arrow_up),
                onPressed: () {
                  _doPlayerMove("上");
                })),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.blue, width: 3)),
                  margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: IconButton(
                      padding: EdgeInsets.all(0),
                      iconSize: 70,
                      icon: Icon(Icons.keyboard_arrow_left),
                      onPressed: () {
                        _doPlayerMove("左");
                      })),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.blue, width: 3)),
                  margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: IconButton(
                      padding: EdgeInsets.all(0),
                      iconSize: 70,
                      icon: Icon(Icons.keyboard_arrow_right),
                      onPressed: () {
                        _doPlayerMove("右");
                      })),
            ],
          ),
        ),
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.blue, width: 3)),
            child: IconButton(
                padding: EdgeInsets.all(0),
                iconSize: 70,
                icon: Icon(Icons.keyboard_arrow_down),
                onPressed: () {
                  _doPlayerMove("下");
                })),
      ],
    ));
  }

  //开始生成迷宫地图
  void _doGenerator(int x, int y) {
    RandomQueue queue = new RandomQueue();
    //设置起点
    Position start = new Position(x, y);
    //入队
    queue.addRandom(start);
    _model.visited[start.getX()][start.getY()] = true;
    while (queue.getSize() != 0) {
      //出队
      Position curPosition = queue.removeRandom();
      //对上、下、左、右四个方向进行遍历，并获得一个新位置
      for (int i = 0; i < 4; i++) {
        int newX = curPosition.getX() + _model.direction[i][0] * 2;
        int newY = curPosition.getY() + _model.direction[i][1] * 2;
        //如果新位置在地图范围内且该位置没有被访问过
        if (_model.isInArea(newX, newY) && !_model.visited[newX][newY]) {
          //入队
          queue.addRandom(Position(newX, newY, prePosition: curPosition));
          //设置该位置为已访问
          _model.visited[newX][newY] = true;
          //设置该位置为路
          _setModelWithRoad(curPosition.getX() + _model.direction[i][0],
              curPosition.getY() + _model.direction[i][1]);
        }
      }
    }
  }

  //自动解迷宫（提示功能）
  //从起点位置开始（使用递归的方式）求解迷宫，如果求解成功则返回true,否则返回false
  bool _doSolver(int x, int y) {
    if (!_model.isInArea(x, y)) {
      throw "坐标越界";
    }
    //设置已访问
    _model.visited[x][y] = true;
    //设置该位置为正确路径
    _setModelWithPath(x, y, true);

    //如果该位置为终点位置，则返回true
    if (x == _model.getEndX() && y == _model.getEndY()) {
      return true;
    }
    //对四个方向进行遍历，并获得一个新位置
    for (int i = 0; i < 4; i++) {
      int newX = x + _model.direction[i][0];
      int newY = y + _model.direction[i][1];
      //如果该位置在地图范围内，且该位置为路，且该位置没有被访问过，则继续从该点开始递归求解
      if (_model.isInArea(newX, newY) &&
          _model.mazeMap[newX][newY] == MazeGameModel.MAP_ROAD &&
          !_model.visited[newX][newY]) {
        if (_doSolver(newX, newY)) {
          return true;
        }
      }
    }

    //如果该位置不是正确的路径，则将该位置设置为非正确路径所途径的位置
    _setModelWithPath(x, y, false);
    return false;
  }

  //控制玩家角色移动
  void _doPlayerMove(String direction) {
    switch (direction) {
      case "上":
        if (_model.isInArea(_model.playerX - 1, _model.playerY) &&
            _model.mazeMap[_model.playerX - 1][_model.playerY] == 1) {
          setState(() {
            _model.playerX--;
          });
        }
        break;
      case "左":
        if (_model.isInArea(_model.playerX, _model.playerY - 1) &&
            _model.mazeMap[_model.playerX][_model.playerY - 1] == 1) {
          setState(() {
            _model.playerY--;
          });
        }
        break;
      case "右":
        if (_model.isInArea(_model.playerX, _model.playerY + 1) &&
            _model.mazeMap[_model.playerX][_model.playerY + 1] == 1) {
          setState(() {
            _model.playerY++;
          });
        }
        break;
      case "下":
        if (_model.isInArea(_model.playerX + 1, _model.playerY) &&
            _model.mazeMap[_model.playerX + 1][_model.playerY] == 1) {
          setState(() {
            _model.playerX++;
          });
        }
        break;
    }

    if (_model.playerX == _model.getEndX() &&
        _model.playerY == _model.getEndY()) {
      isTip = false;
      timer.cancel();
      if (level == 10) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("骚年,你已成功挑战10关，我看你骨骼惊奇，适合玩迷宫（狗头"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text('继续挑战第10关(新地图)',
                        style: TextStyle(fontSize: 16)),
                    onPressed: () {
                      setState(() {
                        _model.playerX = _model.getStartX();
                        _model.playerY = _model.getStartY();
                      });
                      //重新初始化数据
                      _model = new MazeGameModel(rowSum, columnSum);
                      //生成迷宫和设置倒计时
                      _doGenerator(_model.getStartX(), _model.getStartY() + 1);
                      _setSurplusTime(level);
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      } else {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("恭喜闯关成功"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text('挑战下一关', style: TextStyle(fontSize: 16)),
                    onPressed: () {
                      setState(() {
                        //关卡数+1，玩家角色回到起点
                        level++;
                        _model.playerX = _model.getStartX();
                        _model.playerY = _model.getStartY();
                      });
                      //重新初始化数据
                      _model = new MazeGameModel(
                          rowSum = rowSum + 4, columnSum = columnSum + 4);
                      //生成迷宫和设置倒计时
                      _doGenerator(_model.getStartX(), _model.getStartY() + 1);
                      _setSurplusTime(level);
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    }
  }

  void _setModelWithRoad(int x, int y) {
    setState(() {
      if (_model.isInArea(x, y)) {
        _model.mazeMap[x][y] = MazeGameModel.MAP_ROAD;
      }
    });
  }

  void _setModelWithPath(int x, int y, bool isPath) {
    setState(() {
      if (_model.isInArea(x, y)) {
        _model.path[x][y] = isPath;
        if (isPath) {
          _model.successStepLength++;
        } else {
          _model.successStepLength--;
        }
      }
    });
  }

  void _setModelWithClearPath() {
    setState(() {
      for (int i = 0; i < rowSum; i++) {
        for (int j = 0; j < columnSum; j++) {
          _model.path[i][j] = false;
        }
      }
    });
  }

  void _setSurplusTime(int level) {
    surplusTime = 30 + (level - 1) * 15;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (surplusTime <= 0) {
        timer.cancel();
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("超过规定时间,闯关失败o(╥﹏╥)o"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text('重新挑战本关', style: TextStyle(fontSize: 16)),
                    onPressed: () {
                      isTip = false;
                      setState(() {
                        _model.playerX = _model.getStartX();
                        _model.playerY = _model.getStartY();
                      });
                      _setSurplusTime(level);
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      } else {
        setState(() {
          surplusTime--;
        });
      }
    });
  }
}
