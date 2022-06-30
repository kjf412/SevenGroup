import 'dart:collection';

class Position extends LinkedListEntry<Position> {
  int _x, _y;
  Position _prePosition;

  Position(int x, int y, {Position prePosition}) {
    this._x = x;
    this._y = y;
    this._prePosition = prePosition;
  }

  //返回X坐标（）
  int getX() {
    return _x;
  }

  //返回Y坐标（）
  int getY() {
    return _y;
  }

  //返回上一个位置
  Position getPrePosition() {
    return _prePosition;
  }
}
