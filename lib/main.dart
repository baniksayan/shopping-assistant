import 'package:flutter/material.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/profile_creation_screen.dart';
import 'screens/main_navigation_screen.dart';
import 'services/theme_service.dart';
import 'services/user_data_service.dart';
import 'constants/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive for theme and user data persistence
  await ThemeService.init();
  await UserDataService.init();
  
  runApp(const FutureFoundersApp());
}

class FutureFoundersApp extends StatefulWidget {
  const FutureFoundersApp({Key? key}) : super(key: key);

  @override
  State<FutureFoundersApp> createState() => _FutureFoundersAppState();
}

class _FutureFoundersAppState extends State<FutureFoundersApp> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void _loadTheme() {
    setState(() {
      _isDarkMode = ThemeService.isDarkMode;
      AppColors.setDarkMode(_isDarkMode);
    });
  }

  void _onThemeChanged() {
    _loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
        fontFamily: 'System',
        scaffoldBackgroundColor: _isDarkMode ? Colors.black : Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF007AFF),
          brightness: _isDarkMode ? Brightness.dark : Brightness.light,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/otp': (context) => const OTPScreen(phoneNumber: '87XXXXXX832'),
        '/profile': (context) => ProfileViewScreen(onThemeChanged: _onThemeChanged),
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
          case '/profile':
            return MaterialPageRoute(
              builder: (context) => ProfileViewScreen(onThemeChanged: _onThemeChanged),
            );
          case '/profile-creation':
            final args = settings.arguments as Map<String, dynamic>?;
            final phoneNumber = args?['phoneNumber'] ?? '';
            return MaterialPageRoute(
              builder: (context) => ProfileCreationScreen(phoneNumber: phoneNumber),
            );
          default:
            return null;
        }
      },
    );
  }
}
