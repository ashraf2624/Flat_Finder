import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/flat_card.dart';
import '../services/simple_firebase_auth.dart';
import 'add_flat_screen.dart';

import 'welcome_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final SimpleFirebaseAuth _authService = SimpleFirebaseAuth();

  String selectedType = 'all'; // all, family, bachelor

  // All dummy flats with type0
  final List<Map<String, dynamic>> allFlats = [
    {
      "imageUrl":
          "https://images.pexels.com/photos/18340726/pexels-photo-18340726.jpeg",
      "title": "Modern Flat",
      "location": "2no Gate, Chattogram",
      "price": 20000,
      "type": "family",
      "description": "Spacious 3BHK fklatywith balcony and sunlight.",
    },
    {
      "imageUrl":
          "https://images.unsplash.com/photo-1580587771525-78b9dba3b914",
      "title": "Finlay Flat",
      "location": "GEC, Chattogram",
      "price": 12000,
      "type": "bachelor",
      "description": "Compact and fully furnished, ideal for one person.",
    },
    {
      "imageUrl":
          "https://images.pexels.com/photos/18340726/pexels-photo-18340726.jpeg",
      "title": "Student Flat",
      "location": "Agrabad, Chattogram",
      "price": 10000,
      "type": "bachelor",
      "description": "Perfect for students. Close to university.",
    },
    {
      "imageUrl":
          "https://images.pexels.com/photos/18340726/pexels-photo-18340726.jpeg",
      "title": "Family Home",
      "location": "Khulshi, Chattogram",
      "price": 30000,
      "type": "family",
      "description": "Quiet area with park view.",
    },
  ];

  List<Map<String, dynamic>> displayedFlats = [];

  @override
  void initState() {
    super.initState();
    displayedFlats = allFlats;
  }

  void _filterFlats(String query) {
    final lowerQuery = query.toLowerCase();

    final filtered = allFlats.where((flat) {
      final matchesSearch =
          flat['title'].toLowerCase().contains(lowerQuery) ||
          flat['location'].toLowerCase().contains(lowerQuery) ||
          flat['price'].toString().contains(lowerQuery);

      final matchesType = selectedType == 'all' || flat['type'] == selectedType;

      return matchesSearch && matchesType;
    }).toList();

    setState(() {
      displayedFlats = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flat Finder"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                if (mounted) {
                  // Navigate immediately to welcome screen
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ),
                    (route) => false,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Logged out successfully'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error logging out: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search by location, price or title...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterFlats,
            ),
          ),

          const SizedBox(height: 10),

          // 🔘 Dropdown Filter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonFormField<String>(
              value: selectedType,
              decoration: const InputDecoration(
                labelText: "Filter by Type",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'all', child: Text('All')),
                DropdownMenuItem(value: 'family', child: Text('Family')),
                DropdownMenuItem(value: 'bachelor', child: Text('Bachelor')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedType = value!;
                });
                _filterFlats(_searchController.text);
              },
            ),
          ),

          const SizedBox(height: 10),

          // 📋 Flat List
          Expanded(
            child: ListView.builder(
              itemCount: displayedFlats.length,
              itemBuilder: (context, index) {
                final flat = displayedFlats[index];
                return FlatCard(
                  imageUrl: flat['imageUrl'] ?? '',
                  title: flat['title'] ?? '',
                  location: flat['location'] ?? '',
                  price: flat['price'] ?? 0,
                  description: flat['description'] ?? '',
                );
              },
            ),
          ),
        ],
      ),

      // ➕ Floating Button
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddFlatScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add New Flat"),
      ),
    );
  }
}
