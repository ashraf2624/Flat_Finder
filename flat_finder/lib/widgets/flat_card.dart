import 'package:flutter/material.dart';
import '../screens/flat_details_screen.dart';

class FlatCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final int price;
  final String description;

  const FlatCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 👇 Navigate to FlatDetailsScreen when tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FlatDetailsScreen(
              imageUrl: imageUrl,
              title: title,
              location: location,
              price: price,
              description: description,
            ),
          ),
        );
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Image.network(imageUrl, width: 80, height: 80, fit: BoxFit.cover),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(location),
                    Text("৳ $price"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
