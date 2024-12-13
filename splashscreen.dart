import 'dart:async'; // Import this for Timer
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    // Timer to navigate to login screen after 50 seconds
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: const Text(
          'Neuro-Clear',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Move the text further down by placing it inside a Container with more padding
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 10), // Increased the height to move the text down
                Center(
                  child: const Text(
                    '"Precision Brain Tumor Detection"',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 70),
              ],
            ),
          ),
          // Wrapping the image with a Container for border and decoration
          Container(
            width: 200,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.indigo, // Border color
                width: 4, // Border width
              ),
              borderRadius: BorderRadius.circular(20), // Rounded corners for the border
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // Ensuring the image follows the rounded border
              child: Image.asset(
                'assets/welcome.jpg', // Correct path to the asset
                width: 300,
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
