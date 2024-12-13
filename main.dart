import 'package:flutter/material.dart';
import 'splashscreen.dart';  // Ensure these import paths are correct
import 'loginscreen.dart';
import 'signupscreen.dart';
import 'patientdetailsscreen.dart';
import 'uploadimagescreen.dart';
import 'historyscreen.dart';
import 'homepage.dart';
// Import the updated HistoryPage with search functionality

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const Splashscreen(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/patient-details': (context) => const PatientDetailsPage(),
        '/homepage': (context) => const HomeScreen(),
        '/upload-image': (context) => ImagePickerPage(
          // If you need to pass parameters, you can uncomment these lines
          // name: '',
          // age: '',
          // gender: '',
          // clinicalHistory: '',
        ),
        '/history': (context) => HistoryPage(),  // Remove parameters for HistoryPage
      },
      initialRoute: '/',
    );
  }
}
