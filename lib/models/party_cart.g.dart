part of 'party_cart.dart';

class PartyCartAdapter extends TypeAdapter<PartyCart> {
  @override
  final int typeId = 2;

  @override
  PartyCart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PartyCart(
      partyCartId: fields[0] as String?,
      bookingId: fields[1] as String,
      dateTime: fields[2] as DateTime,
      phoneNumber: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PartyCart obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.partyCartId)
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
      other is PartyCartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
