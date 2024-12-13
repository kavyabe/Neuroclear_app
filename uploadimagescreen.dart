import 'dart:convert';
import 'dart:io';
import 'package:braintumor/urls.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String _className = "";
  double _confidenceScore = 0.0;
  bool _isLoading = false; // To show loading spinner when prediction is in progress

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _className = ''; // Reset the class name when a new image is picked
        _confidenceScore = 0.0; // Reset confidence score
      });
    }
  }

  Future<void> _predictImage() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image first.')),
      );
      return;
    }

    setState(() {
      _isLoading = true; // Start loading spinner
    });

    final uri = Uri.parse('${Urls.flaskurl}/predict'); // Replace with your Flask server IP
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', _image!.path));
    final response = await request.send();
    final responseData = await response.stream.toBytes();
    final result = json.decode(String.fromCharCodes(responseData));

    setState(() {
      _className = result['class_name'];
      _confidenceScore = result['confidence_score'];
      _isLoading = false; // Stop loading spinner
    });

    // Call the function to upload the image to XAMPP
    await _uploadImageToXAMPP();
  }

  Future<void> _uploadImageToXAMPP() async {
    final xamppUri = Uri.parse('${Urls.url}/upload.php'); // Update this URL to your XAMPP upload endpoint
    final request = http.MultipartRequest('POST', xamppUri)
      ..files.add(await http.MultipartFile.fromPath('image', _image!.path))
      ..fields['class_name'] = _className
      ..fields['confidence_score'] = _confidenceScore.toString();

    print("Uploading image with class: $_className and confidence: $_confidenceScore");

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final result = json.decode(String.fromCharCodes(responseData));
      print(result['message']); // Debugging output
    } else {
      print('Failed to upload image to XAMPP');
    }
  }

  // Function to handle menu actions
  void _onMenuSelected(String value) {
    switch (value) {
      case 'history':
      // Navigate to the history page
        Navigator.pushNamed(context, '/history'); // Assuming you have a route named '/history'
        break;
      case 'logout':
      // Implement your logout logic
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logged out')),
        );
        // Navigate to the splash screen
        Navigator.pushReplacementNamed(context, '/'); // Update this to your splash screen route
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Upload Image'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: _onMenuSelected,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'history',
                  child: Text('History'),
                ),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.camera),
                icon: Icon(Icons.camera_alt, size: 28, color: Colors.white),
                label: Text(
                  'Take a Picture',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: Icon(Icons.photo, size: 28, color: Colors.white),
                label: Text(
                  'Select from Gallery',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (_image != null)
                Column(
                  children: [
                    Image.file(_image!, height: 150),
                    SizedBox(height: 16),
                  ],
                ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _predictImage, // Call the prediction function
                icon: Icon(Icons.search, size: 28, color: Colors.white),
                label: Text(
                  'Predict',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              SizedBox(height: 40),
              if (_isLoading)
                CircularProgressIndicator(), // Show loading spinner when prediction is in progress
              if (_className.isNotEmpty && !_isLoading)
                Column(
                  children: [
                    Text(
                      'Class Name: $_className',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Confidence: ${(_confidenceScore * 100).toStringAsFixed(2)}%',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ],
                ),
              SizedBox(height: 40),
              Text(
                'Pick an image to make a prediction!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
