part of 'three_sixty.dart';

class ThreeSixtyAdapter extends TypeAdapter<ThreeSixty> {
  @override
  final int typeId = 3;

  @override
  ThreeSixty read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ThreeSixty(
      threesixtyId: fields[0] as String?,
      bookingId: fields[1] as String,
      dateTime: fields[2] as DateTime,
      phoneNumber: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ThreeSixty obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.threesixtyId)
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
      other is ThreeSixtyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
