import 'package:photoapp/models/booking.dart';
import 'package:photoapp/services/database_service.dart';

class BookingService {
  static final BookingService _instance = BookingService._internal();
  factory BookingService() => _instance;
  BookingService._internal();

  List<Booking> get bookings => DatabaseService.getAllBookings();

  void addBooking(Booking booking) {
    DatabaseService.addBooking(booking);
  }

  void removeBooking(Booking booking) {
    DatabaseService.deleteBooking(booking.bookingId);
  }

  List<Booking> getBookingsByService(String serviceName) {
    return bookings
        .where((booking) => booking.serviceName == serviceName)
        .toList();
  }

  List<Booking> getBookingsByDateRange(DateTime start, DateTime end) {
    return bookings
        .where((booking) =>
            booking.schedule.isAfter(start) && booking.schedule.isBefore(end))
        .toList();
  }

  static Future<Booking> createBooking({
    required String customerName,
    required DateTime schedule,
    required String location,
    required String phoneNumber,
    required String serviceName,
    required String packageName,
    required String price,
  }) async {
    final booking = Booking(
      customerName: customerName,
      schedule: schedule,
      location: location,
      phoneNumber: phoneNumber,
      serviceName: serviceName,
      packageName: packageName,
      price: price,
    );

    await DatabaseService.addBooking(booking);
    return booking;
  }

  static List<Booking> getAllBookings() {
    return DatabaseService.getAllBookings();
  }

  static Booking? getBooking(String bookingId) {
    return DatabaseService.getBooking(bookingId);
  }

  static Future<void> updateBooking(Booking booking) async {
    await DatabaseService.updateBooking(booking);
  }

  static Future<void> deleteBooking(String bookingId) async {
    await DatabaseService.deleteBooking(bookingId);
  }

  static String? validateBooking({
    required String customerName,
    required DateTime schedule,
    required String location,
    required String phoneNumber,
    required String serviceName,
    required String packageName,
    required String price,
  }) {
    if (customerName.isEmpty) {
      return 'Customer name is required';
    }
    if (schedule.isBefore(DateTime.now())) {
      return 'Schedule cannot be in the past';
    }
    if (location.isEmpty) {
      return 'Location is required';
    }
    if (phoneNumber.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(phoneNumber)) {
      return 'Please enter a valid 10-digit phone number';
    }
    if (serviceName.isEmpty) {
      return 'Service name is required';
    }
    if (packageName.isEmpty) {
      return 'Package name is required';
    }
    if (price.isEmpty) {
      return 'Price is required';
    }
    return null;
  }
}
