// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuickAdapter extends TypeAdapter<Quick> {
  @override
  final int typeId = 2;

  @override
  Quick read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Quick(
      result: fields[0] as String,
      gradingSystem: fields[1] as String,
      scores: (fields[2] as List).cast<dynamic>(),
      courseData: (fields[3] as List).cast<dynamic>(),
      level: fields[4] as String,
      semester: fields[5] as String,
      uploaded: fields[6] as bool,
      timestamp: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Quick obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.result)
      ..writeByte(1)
      ..write(obj.gradingSystem)
      ..writeByte(2)
      ..write(obj.scores)
      ..writeByte(3)
      ..write(obj.courseData)
      ..writeByte(4)
      ..write(obj.level)
      ..writeByte(5)
      ..write(obj.semester)
      ..writeByte(6)
      ..write(obj.uploaded)
      ..writeByte(7)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuickAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
