// FILE PATH: lib/screens/otp_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/auth_app_bar.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  const OTPScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late Timer _timer;
  int _countdown = 25;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _countdown = 25;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        _timer.cancel();
      }
    });
  }
  
  void _verifyOTP() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      Navigator.pushNamedAndRemoveUntil(context, '/profile', (route) => false);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppBar(title: 'OTP Verification'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "We've sent an OTP to verify ${widget.phoneNumber}",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const CustomTextField(
              hintText: 'Enter your 6 Digit OTP',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Text(
              _countdown > 0
                  ? 'Wait for $_countdown seconds to Resend the OTP'
                  : 'Didn\'t receive OTP? Resend',
              style: const TextStyle(color: Color(0xFF8E8E93)),
            ),
            const Spacer(),
            PrimaryButton(
              text: 'Verify',
              onPressed: _verifyOTP,
              isLoading: _isLoading,
              color: const Color(0xFF5E5CE6),
              textColor: Colors.white,
              icon: const Text('🤌', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
