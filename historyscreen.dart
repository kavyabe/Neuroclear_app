import 'package:braintumor/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Import to use json.encode and json.decode
import 'package:intl/intl.dart'; // Import for date formatting

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final TextEditingController _searchController = TextEditingController();

  // Lists to store original and filtered results
  List<Map<String, dynamic>> originalRecords = [];
  List<Map<String, dynamic>> filteredRecords = [];

  @override
  void initState() {
    super.initState();
    _loadPatientRecords(); // Load records on init
  }

  Future<void> _loadPatientRecords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? records = prefs.getStringList('patientRecords');

    if (records != null) {
      originalRecords = records.map((record) {
        return Map<String, dynamic>.from(json.decode(record));
      }).toList();
    }

    // Fetch records from the server
    await _fetchPatientsFromServer();
    filteredRecords = List.from(originalRecords); // Initialize filteredRecords with all records
    setState(() {}); // Refresh UI
  }

  Future<void> _fetchPatientsFromServer() async {
    final response = await http.get(Uri.parse('${Urls.url}/fetch_patients.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Map<String, dynamic>> fetchedRecords = (data['patients'] as List)
          .map((patient) => {
        'name': patient['name'],
        'age': patient['age'],
        'gender': patient['gender'],
        'clinicalHistory': patient['clinical_history'] ?? '',
        'dateTime': patient['dateTime'] ?? DateTime.now().toIso8601String(), // Ensure dateTime is set
      })
          .toList();

      // Update the originalRecords and filteredRecords
      originalRecords = fetchedRecords;
      filteredRecords = List.from(originalRecords); // Reset filteredRecords
    } else {
      // Handle the error accordingly
      throw Exception('Failed to load patients from server');
    }
  }

  void _filterRecords(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredRecords = List.from(originalRecords); // Reset to original records if search query is empty
      } else {
        filteredRecords = originalRecords.where((record) {
          return record['name']!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _deleteRecord(int index) {
    setState(() {
      // Remove the record from originalRecords
      String recordName = filteredRecords[index]['name']!; // Get the name for the Snackbar
      originalRecords.removeWhere((record) => record['name'] == recordName);
      filteredRecords.removeAt(index); // Also remove from filtered list

      // Update shared preferences
      _updatePatientRecords();

      // Show Snackbar after deletion
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$recordName deleted")),
      );
    });
  }

  Future<void> _updatePatientRecords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> records = originalRecords.map((record) => json.encode(record)).toList();
    await prefs.setStringList('patientRecords', records);
  }

  Future<void> _editRecord(int index) async {
    Map<String, dynamic> record = filteredRecords[index];
    TextEditingController nameController = TextEditingController(text: record['name']);
    TextEditingController ageController = TextEditingController(text: record['age'].toString());
    TextEditingController genderController = TextEditingController(text: record['gender']);
    TextEditingController clinicalHistoryController = TextEditingController(text: record['clinicalHistory']);
    TextEditingController dateController = TextEditingController(text: DateFormat('yyyy-MM-dd – HH:mm').format(DateTime.parse(record['dateTime'])));

    // Show dialog to edit patient details
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Patient Details'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Age'),
                ),
                TextField(
                  controller: genderController,
                  decoration: const InputDecoration(labelText: 'Gender'),
                ),
                TextField(
                  controller: clinicalHistoryController,
                  decoration: const InputDecoration(labelText: 'Clinical History'),
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: 'Date & Time'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Update record with edited details
                  record['name'] = nameController.text;
                  record['age'] = int.parse(ageController.text);
                  record['gender'] = genderController.text;
                  record['clinicalHistory'] = clinicalHistoryController.text;
                  record['dateTime'] = DateFormat('yyyy-MM-dd – HH:mm').parse(dateController.text).toIso8601String();

                  // Update the original records and shared preferences
                  _updatePatientRecords();
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _addNewRecord() {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController genderController = TextEditingController();
    TextEditingController clinicalHistoryController = TextEditingController();
    TextEditingController dateController = TextEditingController(text: DateFormat('yyyy-MM-dd – HH:mm').format(DateTime.now()));

    // Show dialog to add new patient details
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Patient'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Age'),
                ),
                TextField(
                  controller: genderController,
                  decoration: const InputDecoration(labelText: 'Gender'),
                ),
                TextField(
                  controller: clinicalHistoryController,
                  decoration: const InputDecoration(labelText: 'Clinical History'),
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: 'Date & Time'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Add new record to the list
                  Map<String, dynamic> newRecord = {
                    'name': nameController.text,
                    'age': int.parse(ageController.text),
                    'gender': genderController.text,
                    'clinicalHistory': clinicalHistoryController.text,
                    'dateTime': DateFormat('yyyy-MM-dd – HH:mm').parse(dateController.text).toIso8601String(),
                  };
                  originalRecords.add(newRecord);
                  filteredRecords.add(newRecord);

                  // Update shared preferences
                  _updatePatientRecords();
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: const Text(
          'Patient History',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by Patient Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterRecords,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredRecords.length,
                itemBuilder: (context, index) {
                  final record = filteredRecords[index];
                  final formattedDate = DateFormat('yyyy-MM-dd – HH:mm').format(DateTime.parse(record['dateTime']));
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text(record['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Age: ${record['age']}'),
                          Text('Gender: ${record['gender']}'),
                          Text('Clinical History: ${record['clinicalHistory']}'),
                          Text('Date & Time: $formattedDate'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _editRecord(index), // Trigger edit dialog
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteRecord(index), // Trigger delete function
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewRecord,
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
