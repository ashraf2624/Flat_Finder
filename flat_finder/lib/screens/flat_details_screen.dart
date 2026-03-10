import 'package:flutter/material.dart';

class FlatDetailsScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final int price;
  final String description;

  const FlatDetailsScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 20),
            Text(
              '$title • \$${price.toString()}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(location, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Text(description),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.call),
                  label: const Text('Call'),
                  onPressed: () {
                    // You can add call functionality here
                  },
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  icon: const Icon(Icons.message),
                  label: const Text('Message'),
                  onPressed: () {
                    // You can add SMS functionality here
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
