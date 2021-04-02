import 'package:flutter_map/flutter_map.dart';

class Point extends Marker{
  final double x;
  final double y;
  final int id;
  final Marker marker;
  Point({this.x, this.y, this.id, this.marker})
      : super(
          point: marker.point,
          builder: marker.builder,
        );
  String toString() {
    return "[" + x.toString() + " , " + y.toString() + "]";
  }
}
