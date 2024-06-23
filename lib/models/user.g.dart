// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      password: fields[3] as String,
      matricNo: fields[4] as String,
      image: fields[5] as String,
      university: fields[6] as String?,
      faculty: fields[7] as String?,
      course: fields[8] as String?,
      level: fields[9] as int?,
      semester: fields[10] as String?,
      currentCgpa: fields[11] as double?,
      premium: fields[12] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.matricNo)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.university)
      ..writeByte(7)
      ..write(obj.faculty)
      ..writeByte(8)
      ..write(obj.course)
      ..writeByte(9)
      ..write(obj.level)
      ..writeByte(10)
      ..write(obj.semester)
      ..writeByte(11)
      ..write(obj.currentCgpa)
      ..writeByte(12)
      ..write(obj.premium);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
