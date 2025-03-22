import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:photoapp/models/booking.dart';
import 'package:photoapp/services/booking_service.dart';
import 'package:photoapp/services/database_service.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final BookingService _bookingService = BookingService();
  List<Booking> _bookings = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    setState(() {
      _bookings = _bookingService.bookings;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Booking> getBookings() {
    return _bookings;
  }

  @override
  Widget build(BuildContext context) {
    final bookings = getBookings();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Reports'),
        actions: [
          IconButton(
            icon: const Icon(Icons.storage),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Database Contents'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Bookings: ${_bookings.length}'),
                        const SizedBox(height: 16),
                        ..._bookings.map((booking) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Customer: ${booking.customerName}'),
                                Text('Service: ${booking.serviceName}'),
                                Text('Package: ${booking.packageName}'),
                                Text('Price: ${booking.price}'),
                                Text('Schedule: ${booking.schedule}'),
                                Text('Location: ${booking.location}'),
                                Text('Phone: ${booking.phoneNumber}'),
                                const Divider(),
                              ],
                            )),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.bug_report),
            onPressed: () {
              DatabaseService.printDatabaseContents();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Database contents printed to console'),
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Daily'),
            Tab(text: 'Weekly'),
            Tab(text: 'Monthly'),
          ],
        ),
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
                  'Total Bookings: ${bookings.length}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Total Revenue: P${_calculateTotalRevenue(bookings)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 300,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDailyChart(bookings),
                _buildWeeklyChart(bookings),
                _buildMonthlyChart(bookings),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
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
                            _buildDetailRow('Phone', booking.phoneNumber),
                            _buildDetailRow('Location', booking.location),
                            _buildDetailRow(
                              'Event Date & Time',
                              DateFormat('MMM dd, yyyy - hh:mm a')
                                  .format(booking.eventDateTime),
                            ),
                            _buildDetailRow(
                              'Booking Date',
                              DateFormat('MMM dd, yyyy')
                                  .format(booking.schedule),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyChart(List<Booking> bookings) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final days = [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun'
                  ];
                  return Text(days[value.toInt()]);
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          barGroups: List.generate(7, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: bookings
                      .where((booking) => booking.schedule.weekday == index + 1)
                      .length
                      .toDouble(),
                  color: Colors.blue,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildWeeklyChart(List<Booking> bookings) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const weeks = ['W1', 'W2', 'W3', 'W4'];
                  return Text(weeks[value.toInt()]);
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          barGroups: List.generate(4, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: bookings
                      .where((booking) =>
                          booking.schedule.day >= (index * 7 + 1) &&
                          booking.schedule.day <= ((index + 1) * 7))
                      .length
                      .toDouble(),
                  color: Colors.blue,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildMonthlyChart(List<Booking> bookings) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                  return Text(months[value.toInt()]);
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          barGroups: List.generate(6, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: bookings
                      .where((booking) => booking.schedule.month == index + 1)
                      .length
                      .toDouble(),
                  color: Colors.blue,
                ),
              ],
            );
          }),
        ),
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

class WeekData {
  final DateTime startDate;
  final DateTime endDate;
  int count;
  int revenue;

  WeekData({
    required this.startDate,
    required this.endDate,
    this.count = 0,
    this.revenue = 0,
  });
}
