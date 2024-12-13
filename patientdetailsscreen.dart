import 'package:braintumor/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'uploadimagescreen.dart';
import 'historyscreen.dart';
import 'loginscreen.dart'; // Import your login page here
import 'package:shared_preferences/shared_preferences.dart';

class PatientDetailsPage extends StatefulWidget {
  const PatientDetailsPage({super.key});

  @override
  State<PatientDetailsPage> createState() => _PatientDetailsPageState();

  static List<Map<String, String>> patientRecords = [];
}

class _PatientDetailsPageState extends State<PatientDetailsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _clinicalHistoryController = TextEditingController();
  String? _selectedGender;
  final List<String> _genders = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();
    _loadPatientRecords(); // Load patient records on initialization
  }

  Future<void> _loadPatientRecords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? records = prefs.getStringList('patientRecords');
    if (records != null) {
      PatientDetailsPage.patientRecords = records
          .map((record) => jsonDecode(record) as Map<String, String>)
          .toList();
    }
  }

  Future<void> _savePatientRecords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> records = PatientDetailsPage.patientRecords
        .map((record) => jsonEncode(record))
        .toList();
    await prefs.setStringList('patientRecords', records);
  }

  bool isFormComplete() {
    return _nameController.text.isNotEmpty &&
        _ageController.text.isNotEmpty &&
        _selectedGender != null &&
        _clinicalHistoryController.text.isNotEmpty;
  }

  void _handleSave() async {
    final String name = _nameController.text;
    final String age = _ageController.text;
    final String clinicalHistory = _clinicalHistoryController.text;

    if (!RegExp(r'^[0-9]+$').hasMatch(age)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid age.')),
      );
      return;
    }

    if (isFormComplete()) {
      try {
        var url = Uri.parse('${Urls.url}/patient.php'); // Modify with correct API
        var response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: {
            'name': name,
            'age': age,
            'gender': _selectedGender!,
            'clinicalHistory': clinicalHistory,
          },
        );

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if (data['status'] == 'success') {
            PatientDetailsPage.patientRecords.add({
              'name': name,
              'age': age,
              'gender': _selectedGender!,
              'clinicalHistory': clinicalHistory,
              'result': data['result'] ?? 'No result',
            });

            await _savePatientRecords(); // Save records to shared preferences

            _nameController.clear();
            _ageController.clear();
            _clinicalHistoryController.clear();
            setState(() {
              _selectedGender = null;
            });

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ImagePickerPage()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(data['message'] ?? 'Something went wrong')),
            );
          }
        } else {
          throw Exception('Failed to save details. Status code: ${response.statusCode}');
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
    }
  }

  // Function to handle menu actions
  void _onMenuSelected(String value) {
    switch (value) {
      case 'history':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HistoryPage()), // Navigate to History Page
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Patient Details'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to Login Page
            );
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: _onMenuSelected,
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'history',
                  child: Text('History'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/patient.png', // Path to the logo file
                height: 120,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    TextField(
                      controller: _ageController,
                      decoration: const InputDecoration(labelText: 'Age'),
                      keyboardType: TextInputType.number,
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      decoration: const InputDecoration(labelText: 'Gender'),
                      items: _genders.map((String gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                    ),
                    TextField(
                      controller: _clinicalHistoryController,
                      decoration: const InputDecoration(labelText: 'Clinical History'),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _handleSave,
                      child: const Text('Save & Next'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
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
