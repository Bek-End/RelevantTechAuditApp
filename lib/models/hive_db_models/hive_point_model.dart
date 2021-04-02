import 'package:hive/hive.dart';

part 'hive_point_model.g.dart';

const String pointBoxName = "pointModelBox";

@HiveType(typeId: 2)
class PointModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  double longitude; //x
  @HiveField(2)
  double latitude; //y
}
