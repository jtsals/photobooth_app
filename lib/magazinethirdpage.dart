import 'package:flutter/material.dart';
import 'package:photoapp/booking_form.dart';

class MagazineThirdPage extends StatelessWidget {
  const MagazineThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Magazine Packages')),
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
                      '2 Hours Photo Session',
                      'Professional Magazine Setup',
                      'Basic Lighting Setup',
                      '5 Magazine Cover Prints',
                      'Digital Copies',
                      '2 Layout Designs',
                      'Basic Props'
                    ],
                    'P10,999',
                    context,
                  ),
                  const SizedBox(height: 16),
                  _buildPackageCard(
                    'Premium Package',
                    [
                      '3 Hours Photo Session',
                      'Professional Magazine Setup',
                      'Advanced Lighting Setup',
                      '10 Magazine Cover Prints',
                      'Digital Copies',
                      '4 Layout Designs',
                      'Premium Props',
                      'Hair and Makeup',
                      'Outfit Styling'
                    ],
                    'P15,999',
                    context,
                  ),
                  const SizedBox(height: 16),
                  _buildPackageCard(
                    'Ultimate Package',
                    [
                      '4 Hours Photo Session',
                      'Professional Magazine Setup',
                      'Studio-Grade Lighting',
                      '15 Magazine Cover Prints',
                      'Digital Copies',
                      'Unlimited Layout Designs',
                      'Premium Props',
                      'Professional Hair and Makeup',
                      'Professional Styling',
                      'Video Behind the Scenes',
                      'Photo Album'
                    ],
                    'P20,999',
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
                          serviceName: 'Magazine',
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
