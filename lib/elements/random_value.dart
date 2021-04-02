import 'dart:math';

import 'package:flutter/material.dart';

class RandValue {
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Color getRandColor() {
    List colors = [Colors.red, Colors.blue, Colors.green];
    int index = _rnd.nextInt(3);
    return colors[index];
  }

  List<double> getRandLatLon() {
    double nextDouble(num min, num max) =>
        min + _rnd.nextDouble() * (max - min);
    double randomLat = nextDouble(-90, 90);
    double randomLng = nextDouble(-180, 180);
    return [randomLat, randomLng];
  }

  int getRandomInt() {
    return _rnd.nextInt(3);
  }
}

final randValue = RandValue();
