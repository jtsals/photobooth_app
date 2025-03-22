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
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ThirdPage(),
              ),
            );
          },
          child: const Text('Solo Package'),
        ),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Partycart Packages')),
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
                      '3 Hours Cart Service',
                      '1 Food Cart of Choice',
                      '100 Servings',
                      'Basic Setup',
                      'Professional Staff',
                      'Basic Decorations',
                      'Disposable Utensils'
                    ],
                    'P9,999',
                    context,
                  ),
                  const SizedBox(height: 16),
                  _buildPackageCard(
                    'Premium Package',
                    [
                      '4 Hours Cart Service',
                      '2 Food Carts of Choice',
                      '200 Servings',
                      'Premium Setup',
                      'Professional Staff',
                      'Custom Decorations',
                      'Premium Utensils',
                      'Dessert Station'
                    ],
                    'P15,999',
                    context,
                  ),
                  const SizedBox(height: 16),
                  _buildPackageCard(
                    'Ultimate Package',
                    [
                      '5 Hours Cart Service',
                      '3 Food Carts of Choice',
                      '300 Servings',
                      'Deluxe Setup',
                      'Professional Staff',
                      'Themed Decorations',
                      'Premium Utensils',
                      'Dessert Station',
                      'Beverage Station',
                      'Event Coordinator'
                    ],
                    'P21,999',
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
                          serviceName: 'Partycart',
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
