import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:koka/screens/auth.dart';
import 'package:koka/screens/welcome.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  final String message;

  const SplashScreen({Key? key, required this.message}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      final user = FirebaseAuth.instance.currentUser;
      setState(() {
        _isLoading = false;
      });

      // Navigate based on user authentication state
      if (user == null) {
        // User is not logged in
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const AuthScreen()),
          (route) => false,
        );
      } else {
        // User is logged in
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const WelcomeScreen()),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).colorScheme.primary, // Background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(), // Loading indicator
            const SizedBox(height: 20),
            Text(
              widget.message,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white, // Text color
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
