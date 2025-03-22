import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'three_sixty.g.dart';

@HiveType(typeId: 3)
class ThreeSixty extends HiveObject {
  @HiveField(0)
  final String threesixtyId;

  @HiveField(1)
  final String bookingId;

  @HiveField(2)
  final DateTime dateTime;

  @HiveField(3)
  final String phoneNumber;

  ThreeSixty({
    String? threesixtyId,
    required this.bookingId,
    required this.dateTime,
    required this.phoneNumber,
  }) : threesixtyId = threesixtyId ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'threesixtyId': threesixtyId,
      'bookingId': bookingId,
      'dateTime': dateTime.toIso8601String(),
      'phoneNumber': phoneNumber,
    };
  }

  factory ThreeSixty.fromMap(Map<String, dynamic> map) {
    return ThreeSixty(
      threesixtyId: map['threesixtyId'],
      bookingId: map['bookingId'],
      dateTime: DateTime.parse(map['dateTime']),
      phoneNumber: map['phoneNumber'],
    );
  }
}
