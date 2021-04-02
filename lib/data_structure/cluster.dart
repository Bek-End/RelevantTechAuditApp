import 'package:flutter_map/flutter_map.dart';
import 'package:tech_audit_app/data_structure/point.dart';

class Cluster extends Point {
  final int count;
  final int redCount;
  final int greenCount;
  final int blueCount;
  Cluster(
      {this.count,
      this.redCount,
      this.greenCount,
      this.blueCount,
      final double x,
      final double y,
      final Marker marker})
      : super(x: x, y: y, marker: marker);
}
