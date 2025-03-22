import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'booking.g.dart';

@HiveType(typeId: 0)
class Booking extends HiveObject {
  @HiveField(0)
  final String bookingId;

  @HiveField(1)
  final String customerName;

  @HiveField(2)
  final DateTime schedule;

  @HiveField(3)
  final String location;

  @HiveField(4)
  final String phoneNumber;

  @HiveField(5)
  final String serviceName;

  @HiveField(6)
  final String packageName;

  @HiveField(7)
  final String price;

  Booking({
    String? bookingId,
    required this.customerName,
    required this.schedule,
    required this.location,
    required this.phoneNumber,
    required this.serviceName,
    required this.packageName,
    required this.price,
  }) : bookingId = bookingId ?? const Uuid().v4();

  DateTime get eventDateTime => schedule;

  Map<String, dynamic> toMap() {
    return {
      'bookingId': bookingId,
      'customerName': customerName,
      'schedule': schedule.toIso8601String(),
      'location': location,
      'phoneNumber': phoneNumber,
      'serviceName': serviceName,
      'packageName': packageName,
      'price': price,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      bookingId: map['bookingId'],
      customerName: map['customerName'],
      schedule: DateTime.parse(map['schedule']),
      location: map['location'],
      phoneNumber: map['phoneNumber'],
      serviceName: map['serviceName'],
      packageName: map['packageName'],
      price: map['price'],
    );
  }
}
