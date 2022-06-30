import 'dart:math';

class MazeGameModel {
  int _rowSum; //迷宫行数
  int _columnSum; //迷宫列数
  int _startX, _startY; //迷宫入口坐标（[startX,startY]）
  int _endX, _endY; //迷宫出口坐标（[endX,endY]）
  static final int MAP_ROAD = 1; //1代表路
  static final int MAP_WALL = 0; //0代表墙
  List<List<int>> mazeMap; //迷宫地图
  List<List<bool>> visited; //是否已经访问过
  List<List<bool>> path; //是否是正确解的路径
  List<List<int>> direction = [
    [-1, 0],
    [0, 1],
    [1, 0],
    [0, -1]
  ]; //迷宫遍历的方向顺序（迷宫趋势）//分别为向左，向下，向右，向上一步
  int spendStepSum = 0; //求解的总步数
  int successStepLength = 0; //正确路径长度
  int playerX, playerY; //当前玩家坐标

  MazeGameModel(int rowSum, int columnSum) {
    if (rowSum % 2 == 0 || columnSum % 2 == 0) {
      throw "model_this->迷宫行数和列数不能为偶数";
    }
    _rowSum = rowSum;
    _columnSum = columnSum;
    mazeMap = new List<List<int>>();
    visited = new List<List<bool>>();
    path = new List<List<bool>>();
    //初始化迷宫起点与终点坐标
    _startX = 1;
    _startY = 0;
    _endX = rowSum - 2;
    _endY = columnSum - 1;

    //初始化玩家坐标
    playerX = _startX;
    playerY = _startY;

    //初始化迷宫遍历的方向（上、左、右、下）顺序（迷宫趋势）
    //随机遍历顺序，提高迷宫生成的随机性（共12种可能性）
    for (int i = 0; i < direction.length; i++) {
      int random = Random().nextInt(direction.length);
      List<int> temp = direction[random];
      direction[random] = direction[i];
      direction[i] = temp;
    }

    //初始化迷宫地图
    for (int i = 0; i < rowSum; i++) {
      List<int> mazeMapList = [];
      List<bool> visitedList = [];
      List<bool> pathList = [];

      for (int j = 0; j < columnSum; j++) {
        //行和列都为基数则设置为路，否则设置为墙
        if (i % 2 == 1 && j % 2 == 1) {
          mazeMapList.add(1); //设置为路
        } else {
          mazeMapList.add(0); //设置为墙
        }
        visitedList.add(false);
        pathList.add(false);
      }
      mazeMap.add(mazeMapList);
      visited.add(visitedList);
      path.add(pathList);
    }
    //初始化迷宫起点与终点位置
    mazeMap[_startX][_startY] = 1;
    mazeMap[_endX][_endY] = 1;
  }

  //返回迷宫行数
  int getRowSum() {
    return _rowSum;
  }

  //返回迷宫列数
  int getColumnSum() {
    return _columnSum;
  }

  //返回迷宫入口X坐标
  int getStartX() {
    return _startX;
  }

  //返回迷宫入口Y坐标
  int getStartY() {
    return _startY;
  }

  //返回迷宫出口X坐标
  int getEndX() {
    return _endX;
  }

  //返回迷宫出口Y坐标
  int getEndY() {
    return _endY;
  }

  //判断[i][j]是否在迷宫地图内
  bool isInArea(int i, int j) {
    return i >= 0 && i < _rowSum && j >= 0 && j < _columnSum;
  }
}
