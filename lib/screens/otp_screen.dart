// FILE PATH: lib/screens/otp_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../widgets/auth_app_bar.dart';
import '../widgets/primary_button.dart';
import '../services/user_data_service.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  const OTPScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  Timer? _timer;
  int _countdown = 25;
  bool _isLoading = false;
  final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void startTimer() {
    _timer?.cancel();
    _countdown = 25;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        if (!mounted) return;
        setState(() {
          _countdown--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  Future<void> _resendOTP() async {
    // simulate resend
    if (!mounted) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
    startTimer();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTP resent')),
    );
  }

  Future<void> _showResendDialog() {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1C1C1E),
          title: const Text(
            'Resend OTP',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Do you want to resend the OTP to ${widget.phoneNumber}?',
            style: const TextStyle(color: Color(0xFF8E8E93)),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF8E8E93),
                textStyle: const TextStyle(decoration: TextDecoration.none),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF34C759),
                textStyle: const TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await _resendOTP();
              },
              child: _isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFF34C759),
                      ),
                    )
                  : const Text('Resend'),
            ),
          ],
        );
      },
    );
  }

  // actual verify operation (called only when OTP is valid)
  void _verifyOTP() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      
      // Check if user is already registered
      if (UserDataService.isUserRegistered) {
        // User exists, go directly to home
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        // New user, go to profile creation
        Navigator.pushNamedAndRemoveUntil(
          context, 
          '/profile-creation', 
          (route) => false,
          arguments: {'phoneNumber': widget.phoneNumber},
        );
      }
    });
  }

  // validate on Verify button press; vibrate + show message if invalid
  void _onVerifyPressed() {
    final code = _otpController.text.trim();
    final digitsOnly = code.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length != 6) {
      HapticFeedback.vibrate();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a 6 digit OTP')),
      );
      return;
    }
    _verifyOTP();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AuthAppBar(title: 'OTP Verification'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "We've sent an OTP to verify ${widget.phoneNumber}",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: 20),
            // OTP input: digits only, max 6
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              style: TextStyle(color: AppColors.primaryText, fontSize: 16),
              decoration: InputDecoration(
                hintText: 'Enter your 6 Digit OTP',
                hintStyle: TextStyle(color: AppColors.hintText),
                filled: true,
                fillColor: AppColors.inputFillColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.inputBorderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.inputBorderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.inputFocusedBorderColor, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              ),
            ),
            const SizedBox(height: 20),
            // Inline resend UI: countdown when active, else clickable "Resend" styled to match theme
            _countdown > 0
                ? Text(
                    'Wait for $_countdown seconds to Resend the OTP',
                    style: const TextStyle(color: Color(0xFF8E8E93)),
                  )
                : Row(
                    children: [
                      const Text("Didn't receive OTP? ",
                          style: TextStyle(color: Color(0xFF8E8E93))),
                      GestureDetector(
                        onTap: _showResendDialog,
                        child: const Text(
                          'Resend',
                          style: TextStyle(
                            color: Color(0xFF34C759),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
            const Spacer(),
            PrimaryButton(
              text: 'Verify',
              onPressed: _onVerifyPressed,
              isLoading: _isLoading,
              color: const Color(0xFF5E5CE6),
              textColor: Colors.white,
              // icon: const Text('🤌', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
