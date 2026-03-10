import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddFlatScreen extends StatefulWidget {
  const AddFlatScreen({super.key});

  @override
  State<AddFlatScreen> createState() => _AddFlatScreenState();
}

class _AddFlatScreenState extends State<AddFlatScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  File? _selectedImage;

  // Open gallery to pick image
  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // TODO: Save to Firebase later
      print('Title: ${titleController.text}');
      print('Price: ${priceController.text}');
      print('Size: ${sizeController.text}');
      print('Location: ${locationController.text}');
      print('Description: ${descriptionController.text}');
      if (_selectedImage != null) {
        print('Image selected: ${_selectedImage!.path}');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Flat added successfully (demo)!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Flat')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Image preview & picker
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 180,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: _selectedImage != null
                      ? Image.file(_selectedImage!, fit: BoxFit.cover)
                      : const Center(child: Text('Tap to upload image')),
                ),
              ),
              const SizedBox(height: 16),

              // Form Fields
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Flat Title'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter title' : null,
              ),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Price (BDT)'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter price' : null,
              ),
              TextFormField(
                controller: sizeController,
                decoration: const InputDecoration(labelText: 'Size (sq ft)'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter size' : null,
              ),
              TextFormField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter location' : null,
              ),
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter description' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
