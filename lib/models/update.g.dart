// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UpdateAdapter extends TypeAdapter<Update> {
  @override
  final int typeId = 3;

  @override
  Update read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Update(
      gpa: fields[0] as double,
      cgpa: fields[1] as double,
      gradingSystem: fields[2] as String,
      scores: (fields[3] as List).cast<dynamic>(),
      courseData: (fields[4] as List).cast<dynamic>(),
      level: fields[5] as String,
      semester: fields[6] as String,
      past_semester: fields[9] as String,
      uploaded: fields[7] as bool,
      timestamp: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Update obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.gpa)
      ..writeByte(1)
      ..write(obj.cgpa)
      ..writeByte(2)
      ..write(obj.gradingSystem)
      ..writeByte(3)
      ..write(obj.scores)
      ..writeByte(4)
      ..write(obj.courseData)
      ..writeByte(5)
      ..write(obj.level)
      ..writeByte(6)
      ..write(obj.semester)
      ..writeByte(7)
      ..write(obj.uploaded)
      ..writeByte(8)
      ..write(obj.timestamp)
      ..writeByte(9)
      ..write(obj.past_semester);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
