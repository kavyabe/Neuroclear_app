import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();



}

class _HomeScreenState extends State<HomeScreen> {
  File? _profileImage;
  String base64Image = "";
  final ImagePicker _imagePicker = ImagePicker();
  bool _showSelectButton = true;
  String? imagedecode;
  bool _isLoading = false;
  bool _isCheckButtonClicked = false;
  bool _isResultLoaded = false;

  Future<void> _pickImage() async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
                  _processPickedImage(pickedFile);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
                  _processPickedImage(pickedFile);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _processPickedImage(XFile? pickedFile) {
    if (pickedFile != null) {
      List<int> imageBytes = File(pickedFile.path).readAsBytesSync();
      base64Image = base64Encode(imageBytes);
      print(base64Image);

      setState(() {
        _profileImage = File(pickedFile.path);
        _showSelectButton = false;
        _isResultLoaded = false; // Reset the result-loaded state
      });
    }
  }

  Future<void> onUploadImage() async {
    try {
      if (base64Image.isEmpty) {
        return;
      }

      setState(() {
        _isLoading = true;
      });

      var response = await http.post(
        Uri.parse("http://192.168.192.7:5000/upload"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"image": base64Image, "Email_ID": "sai"}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> imageData = json.decode(response.body);

        setState(() {
          imagedecode = imageData["predicted_image_base64"].toString();
          print(imagedecode);
          _isLoading = false;
          _isCheckButtonClicked = true;
          _isResultLoaded = true; // Set the result-loaded state
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        _isLoading = false;
        _isResultLoaded = false; // Reset the result-loaded state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Check Cavity'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_isResultLoaded) // Show the normal image before result is loaded
              Container(
                width: 270,
                height: 270,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: _profileImage != null
                        ? FileImage(_profileImage!)
                        : AssetImage('assets/upload.jpg') as ImageProvider<Object>,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (_isResultLoaded)
              GestureDetector(
                child: SingleChildScrollView(
                  child: Container(
                    width: 270,
                    height: 270,
                    child: PhotoView(
                      imageProvider: MemoryImage(base64Decode(imagedecode!)),
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 2,
                      backgroundDecoration: BoxDecoration(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 20),
            if (!_isCheckButtonClicked)
              _showSelectButton
                  ? ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
                child: Text('Select Image'),
              )
                  : Container(
                width: 200,
                child: ElevatedButton(
                  onPressed: onUploadImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : Text('Check'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}