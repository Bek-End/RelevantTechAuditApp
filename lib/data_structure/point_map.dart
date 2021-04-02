import 'dart:collection';
import 'package:tech_audit_app/data_structure/point.dart';
import 'package:tech_audit_app/data_structure/point_info.dart';

class PointMap {
  List<Point> points;
  LinkedHashMap<int, PointInfo> pointData;

  PointMap() {
    this.points = [];
    this.pointData = LinkedHashMap();
  }

  void addItem({Point point, PointInfo pointInfo}) {
    this.points.add(point);
    pointData[point.id] = pointInfo;
  }

  PointInfo searchByPoint(int id) {
    return pointData[id];
  }
}

final pointMap = PointMap();
