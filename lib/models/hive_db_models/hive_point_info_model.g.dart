// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_point_info_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PointInfoModelAdapter extends TypeAdapter<PointInfoModel> {
  @override
  final int typeId = 1;

  @override
  PointInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PointInfoModel()
      ..id = fields[0] as int
      ..uid = fields[1] as String
      ..typ = fields[2] as int
      ..c = fields[3] as String
      ..tou = fields[4] as int
      ..deleted = fields[5] as bool;
  }

  @override
  void write(BinaryWriter writer, PointInfoModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.uid)
      ..writeByte(2)
      ..write(obj.typ)
      ..writeByte(3)
      ..write(obj.c)
      ..writeByte(4)
      ..write(obj.tou)
      ..writeByte(5)
      ..write(obj.deleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PointInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
