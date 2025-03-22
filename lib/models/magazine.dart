import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'magazine.g.dart';

@HiveType(typeId: 4)
class Magazine extends HiveObject {
  @HiveField(0)
  final String magazineId;

  @HiveField(1)
  final String bookingId;

  @HiveField(2)
  final DateTime dateTime;

  @HiveField(3)
  final String phoneNumber;

  Magazine({
    String? magazineId,
    required this.bookingId,
    required this.dateTime,
    required this.phoneNumber,
  }) : magazineId = magazineId ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'magazineId': magazineId,
      'bookingId': bookingId,
      'dateTime': dateTime.toIso8601String(),
      'phoneNumber': phoneNumber,
    };
  }

  factory Magazine.fromMap(Map<String, dynamic> map) {
    return Magazine(
      magazineId: map['magazineId'],
      bookingId: map['bookingId'],
      dateTime: DateTime.parse(map['dateTime']),
      phoneNumber: map['phoneNumber'],
    );
  }
}
