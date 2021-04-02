// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_point_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PointModelAdapter extends TypeAdapter<PointModel> {
  @override
  final int typeId = 2;

  @override
  PointModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PointModel()
      ..id = fields[0] as int
      ..longitude = fields[1] as double
      ..latitude = fields[2] as double;
  }

  @override
  void write(BinaryWriter writer, PointModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.latitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PointModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
