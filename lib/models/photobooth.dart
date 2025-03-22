import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'photobooth.g.dart';

@HiveType(typeId: 1)
class Photobooth extends HiveObject {
  @HiveField(0)
  final String photoboothId;

  @HiveField(1)
  final String bookingId;

  @HiveField(2)
  final DateTime dateTime;

  @HiveField(3)
  final String phoneNumber;

  Photobooth({
    String? photoboothId,
    required this.bookingId,
    required this.dateTime,
    required this.phoneNumber,
  }) : photoboothId = photoboothId ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'photoboothId': photoboothId,
      'bookingId': bookingId,
      'dateTime': dateTime.toIso8601String(),
      'phoneNumber': phoneNumber,
    };
  }

  factory Photobooth.fromMap(Map<String, dynamic> map) {
    return Photobooth(
      photoboothId: map['photoboothId'],
      bookingId: map['bookingId'],
      dateTime: DateTime.parse(map['dateTime']),
      phoneNumber: map['phoneNumber'],
    );
  }
}
