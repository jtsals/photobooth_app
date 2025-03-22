import 'package:flutter/material.dart';
import 'package:photoapp/booking_form.dart';

class VideoThirdPage extends StatelessWidget {
  const VideoThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('360 Video Packages')),
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
                      '1 Hour Video Session',
                      'Professional 360° Setup',
                      'Basic Video Editing',
                      'Background Music',
                      'Digital Copy',
                      'Social Media Format',
                      '1 Revision'
                    ],
                    'P12,999',
                    context,
                  ),
                  const SizedBox(height: 16),
                  _buildPackageCard(
                    'Premium Package',
                    [
                      '2 Hours Video Session',
                      'Professional 360° Setup',
                      'Advanced Video Editing',
                      'Custom Background Music',
                      'Digital Copy',
                      'Multiple Video Formats',
                      '2 Revisions',
                      'Basic Props',
                      'Basic Lighting Effects'
                    ],
                    'P18,999',
                    context,
                  ),
                  const SizedBox(height: 16),
                  _buildPackageCard(
                    'Ultimate Package',
                    [
                      '3 Hours Video Session',
                      'Professional 360° Setup',
                      'Premium Video Editing',
                      'Custom Music Selection',
                      'Digital Copy',
                      'All Video Formats',
                      'Unlimited Revisions',
                      'Premium Props',
                      'Advanced Lighting Effects',
                      'Special Effects',
                      'Same-Day Preview'
                    ],
                    'P24,999',
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
                          serviceName: '360 Video',
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
