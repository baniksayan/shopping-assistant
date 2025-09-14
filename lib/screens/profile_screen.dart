// FILE PATH: lib/screens/profile_screen.dart

import 'package:flutter/material.dart';
import '../widgets/auth_app_bar.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;
  
  void _submitProfile() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      // In a real app, you would navigate to the home screen
      print("Profile submitted! Navigating to Home...");
      // For now, we pop back to the login screen for demo purposes
       Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppBar(title: 'Profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tell us about yourself!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            _buildSectionHeader('What do we call you?'),
            const CustomTextField(hintText: 'First Name'),
            const SizedBox(height: 16),
            const CustomTextField(hintText: 'Last Name (optional)'),
            const SizedBox(height: 30),
            _buildSectionHeader("What's your email?"),
            const CustomTextField(
              hintText: 'abc@example.xyz',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 30),
            _buildSectionHeader("When's your birthday?"),
            const CustomTextField(hintText: 'DD/MM/YYYY'),
            const SizedBox(height: 30),
            _buildSectionHeader('How do you identify?'),
            const CustomTextField(
              hintText: 'Select',
              suffixIcon: Icon(
                Icons.arrow_drop_down,
                color: Color(0xFF8E8E93),
              ),
            ),
            const SizedBox(height: 40),
             PrimaryButton(
                text: 'Done',
                onPressed: _submitProfile,
                isLoading: _isLoading,
                color: const Color(0xFF34C759),
                icon: const Icon(Icons.check, color: Colors.black, size: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
