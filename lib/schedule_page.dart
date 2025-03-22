import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photoapp/models/booking.dart';
import 'package:photoapp/services/booking_service.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final BookingService _bookingService = BookingService();
  List<Booking> _bookings = [];

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    setState(() {
      _bookings = _bookingService.bookings;
      // Sort bookings by date
      _bookings.sort((a, b) => a.schedule.compareTo(b.schedule));
    });
  }

  Map<DateTime, List<Booking>> _groupBookingsByDate() {
    Map<DateTime, List<Booking>> groupedBookings = {};
    for (var booking in _bookings) {
      // Create a DateTime with just the date part (time set to midnight)
      final date = DateTime(
        booking.schedule.year,
        booking.schedule.month,
        booking.schedule.day,
      );
      if (!groupedBookings.containsKey(date)) {
        groupedBookings[date] = [];
      }
      groupedBookings[date]!.add(booking);
    }
    return groupedBookings;
  }

  @override
  Widget build(BuildContext context) {
    final groupedBookings = _groupBookingsByDate();
    final dates = groupedBookings.keys.toList()..sort();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadBookings,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Bookings: ${_bookings.length}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Total Revenue: P${_calculateTotalRevenue(_bookings)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dates.length,
              itemBuilder: (context, index) {
                final date = dates[index];
                final bookingsForDate = groupedBookings[date]!;
                final isToday = date.isAtSameMomentAs(DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                ));
                final isPast = date.isBefore(DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                ));

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: isToday
                          ? Colors.blue.withOpacity(0.2)
                          : isPast
                              ? Colors.grey.withOpacity(0.2)
                              : Colors.green.withOpacity(0.2),
                      child: Row(
                        children: [
                          Icon(
                            isToday
                                ? Icons.today
                                : isPast
                                    ? Icons.history
                                    : Icons.event,
                            color: isToday
                                ? Colors.blue
                                : isPast
                                    ? Colors.grey
                                    : Colors.green,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat('MMMM dd, yyyy').format(date),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isToday
                                  ? Colors.blue
                                  : isPast
                                      ? Colors.grey
                                      : Colors.green,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '(${bookingsForDate.length} bookings)',
                            style: TextStyle(
                              fontSize: 16,
                              color: isToday
                                  ? Colors.blue
                                  : isPast
                                      ? Colors.grey
                                      : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...bookingsForDate.map((booking) => Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: ExpansionTile(
                            title: Text(
                              booking.customerName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              '${booking.serviceName} - ${booking.packageName}',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            trailing: Text(
                              booking.price,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildDetailRow(
                                        'Phone', booking.phoneNumber),
                                    _buildDetailRow(
                                        'Location', booking.location),
                                    _buildDetailRow(
                                      'Time',
                                      DateFormat('hh:mm a')
                                          .format(booking.schedule),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _calculateTotalRevenue(List<Booking> bookings) {
    int total = 0;
    for (var booking in bookings) {
      total += int.parse(booking.price.substring(1).replaceAll(',', ''));
    }
    return NumberFormat('#,##0').format(total);
  }
}
