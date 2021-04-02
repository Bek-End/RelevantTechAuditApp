import 'package:hive/hive.dart';

part 'hive_point_info_model.g.dart';

const String pointInfoModelBoxName = "pointInfoModelBox";

@HiveType(typeId: 1)
class PointInfoModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  String uid;
  @HiveField(2)
  int typ;
  @HiveField(3)
  String c;
  @HiveField(4)
  int tou;
  @HiveField(5)
  bool deleted;
}
