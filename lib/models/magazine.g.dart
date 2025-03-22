// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magazine.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MagazineAdapter extends TypeAdapter<Magazine> {
  @override
  final int typeId = 4;

  @override
  Magazine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Magazine(
      magazineId: fields[0] as String?,
      bookingId: fields[1] as String,
      dateTime: fields[2] as DateTime,
      phoneNumber: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Magazine obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.magazineId)
      ..writeByte(1)
      ..write(obj.bookingId)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.phoneNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MagazineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
