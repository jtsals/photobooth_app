import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'party_cart.g.dart';

@HiveType(typeId: 2)
class PartyCart extends HiveObject {
  @HiveField(0)
  final String partyCartId;

  @HiveField(1)
  final String bookingId;

  @HiveField(2)
  final DateTime dateTime;

  @HiveField(3)
  final String phoneNumber;

  PartyCart({
    String? partyCartId,
    required this.bookingId,
    required this.dateTime,
    required this.phoneNumber,
  }) : partyCartId = partyCartId ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'partyCartId': partyCartId,
      'bookingId': bookingId,
      'dateTime': dateTime.toIso8601String(),
      'phoneNumber': phoneNumber,
    };
  }

  factory PartyCart.fromMap(Map<String, dynamic> map) {
    return PartyCart(
      partyCartId: map['partyCartId'],
      bookingId: map['bookingId'],
      dateTime: DateTime.parse(map['dateTime']),
      phoneNumber: map['phoneNumber'],
    );
  }
}
