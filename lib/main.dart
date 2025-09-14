import 'package:flutter/material.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const FutureFoundersApp());
}

class FutureFoundersApp extends StatelessWidget {
  const FutureFoundersApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FutureFounders',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark, // Set a base dark theme
        fontFamily: 'System',
        scaffoldBackgroundColor: Colors.black, // Set global background
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Define named routes for easy navigation
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/otp': (context) => const OTPScreen(phoneNumber: '87XXXXXX832'), // Example phone number
        '/profile': (context) => const ProfileScreen(),
      },
      // Handle route generation for dynamic parameters
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/otp':
            final args = settings.arguments as Map<String, dynamic>?;
            final phoneNumber = args?['phoneNumber'] ?? '87XXXXXX832';
            return MaterialPageRoute(
              builder: (context) => OTPScreen(phoneNumber: phoneNumber),
            );
          default:
            return null;
        }
      },
    );
  }
}
