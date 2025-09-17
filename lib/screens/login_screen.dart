import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../widgets/auth_app_bar.dart';
import '../widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _shakeController;
  bool _isLoading = false;
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocus = FocusNode();

  late Animation<double> _shakeAnimation;

  bool _showCountryPrefix = false;

  void _sendOTP() {
    final phone = _phoneController.text.trim();

    if (phone.isEmpty) {
      // haptic + shake
      HapticFeedback.vibrate();
      _shakeController.forward(from: 0);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter phone number')),
      );
      return;
    }

    if (!_isValidIndianPhone(phone)) {
      HapticFeedback.vibrate();
      _shakeController.forward(from: 0);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid Indian phone number')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      Navigator.pushNamed(context, '/otp');
    });
  }

  bool _isValidIndianPhone(String phone) {
    final digitsOnly = phone.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length != 10) return false;
    final first = digitsOnly[0];
    return ['6', '7', '8', '9'].contains(first);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AuthAppBar(title: 'Login/Signup'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verify your phone number.',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: 20),
            // Phone input with controller, prefix and shake animation
            AnimatedBuilder(
              animation: _shakeController,
              builder: (context, child) {
                final offset = _shakeAnimation.value;
                return Transform.translate(
                  offset: Offset(offset, 0),
                  child: child,
                );
              },
              child: TextField(
                controller: _phoneController,
                focusNode: _phoneFocus,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                style: TextStyle(color: AppColors.primaryText, fontSize: 16),
                decoration: InputDecoration(
                  hintText: '8768412832',
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
                  prefixIcon: _showCountryPrefix
                      ? Padding(
                          padding: const EdgeInsets.only(left: 12, right: 8),
                          child: Center(
                            widthFactor: 1,
                            child: Text(
                              '+91',
                              style: TextStyle(color: AppColors.primaryText, fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      : null,
                ),
                onChanged: (val) {
                  setState(() {
                    _showCountryPrefix = val.isNotEmpty && ['6', '7', '8', '9'].contains(val[0]);
                  });
                },
                onTap: () {
                  setState(() {}); // to refresh button state when focused
                },
              ),
            ),
            const Spacer(),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(color: AppColors.secondaryText, fontSize: 13),
                children: [
                  const TextSpan(text: 'By continuing, you agree to our '),
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy.',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              text: 'Send OTP',
              isLoading: _isLoading,
              color: const Color(0xFF34C759),
              onPressed: (_phoneFocus.hasFocus && _isValidIndianPhone(_phoneController.text))
                ? _sendOTP
                : () {
                    HapticFeedback.vibrate();
                    _shakeController.forward(from: 0);
                    if (_phoneController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter phone number')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a valid Indian phone number')),
                      );
                    }
                  },
              // only show the circular progress icon when actually loading
              icon: _isLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 2,
                    ),
                  )
                : null,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState(); // <-- REQUIRED: makes `mounted` true and safe for vsync/context usage

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: -6.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -6.0, end: 6.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 6.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _shakeController, curve: Curves.linear));

    // listen to controller to rebuild when shaking
    _shakeController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }
}
