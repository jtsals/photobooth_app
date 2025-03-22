import 'package:flutter/material.dart';
import 'package:photoapp/booking_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photobooth Packages')),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PhotoThirdPage(),
              ),
            );
          },
          child: const Text(
            'View Packages',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class PhotoThirdPage extends StatelessWidget {
  const PhotoThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photobooth Packages')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Available Packages',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildPackageCard(
                    'Basic Package',
                    [
                      '2 Hours Session',
                      'Unlimited Photos',
                      '100 Printed Photos',
                      'Basic Props',
                      'Digital Copies'
                    ],
                    'P8,999',
                    context,
                  ),
                  const SizedBox(height: 16),
                  _buildPackageCard(
                    'Premium Package',
                    [
                      '3 Hours Session',
                      'Unlimited Photos',
                      '200 Printed Photos',
                      'Premium Props',
                      'Digital Copies',
                      'Custom Backdrop',
                      'Photo Album'
                    ],
                    'P12,999',
                    context,
                  ),
                  const SizedBox(height: 16),
                  _buildPackageCard(
                    'Ultimate Package',
                    [
                      '4 Hours Session',
                      'Unlimited Photos',
                      '300 Printed Photos',
                      'Premium Props',
                      'Digital Copies',
                      'Custom Backdrop',
                      'Photo Album',
                      'Video Compilation',
                      'Online Gallery'
                    ],
                    'P15,999',
                    context,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageCard(
      String title, List<String> features, String price, BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...features.map((feature) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle,
                          color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      Text(feature),
                    ],
                  ),
                )),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingForm(
                          serviceName: 'Photobooth',
                          packageName: title,
                          price: price,
                        ),
                      ),
                    );
                  },
                  child: const Text('Book Now'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
