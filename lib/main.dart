// FILE PATH: lib/main.dart
import 'package:flutter/material.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/main_navigation_screen.dart';

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
        brightness: Brightness.dark,
        fontFamily: 'System',
        scaffoldBackgroundColor: Colors.black,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/otp': (context) => const OTPScreen(phoneNumber: '87XXXXXX832'),
        '/profile': (context) => const ProfileScreen(),
        '/home': (context) => const MainNavigationScreen(),
      },
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
