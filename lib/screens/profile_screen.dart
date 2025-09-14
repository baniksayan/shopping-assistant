import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/auth_app_bar.dart';
import '../widgets/primary_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameCtrl = TextEditingController();
  final TextEditingController _lastNameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _dobCtrl = TextEditingController();

  bool _isLoading = false;
  bool _isFormValid = false;
  bool _submitted = false;
  String? _gender;

  @override
  void initState() {
    super.initState();
    _firstNameCtrl.addListener(_updateFormValid);
    _lastNameCtrl.addListener(_updateFormValid);
    _emailCtrl.addListener(_updateFormValid);
    _dobCtrl.addListener(_updateFormValid);
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _dobCtrl.dispose();
    super.dispose();
  }

  void _updateFormValid() {
    final emailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_emailCtrl.text.trim());
    final firstNameValid = RegExp(r'^[A-Za-z]+$').hasMatch(_firstNameCtrl.text.trim());
    final lastNameValid = _lastNameCtrl.text.trim().isEmpty || RegExp(r'^[A-Za-z]+$').hasMatch(_lastNameCtrl.text.trim());
    final dobValid = _dobCtrl.text.trim().length == 10; // DD/MM/YYYY
    final genderValid = (_gender != null && _gender!.isNotEmpty);

    final valid = emailValid && firstNameValid && lastNameValid && dobValid && genderValid;
    if (valid != _isFormValid) {
      setState(() => _isFormValid = valid);
    }
  }

  void _trySubmit() {
    setState(() => _submitted = true);
    if (_formKey.currentState?.validate() ?? false) {
      _submitProfile();
    }
  }

  void _submitProfile() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      // After submission navigate back to onboarding (root) as requested
      debugPrint("Profile submitted! Navigating to Onboarding...");
      if (!mounted) return; // avoid using context across async gap
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppBar(title: 'Profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          autovalidateMode: _submitted ? AutovalidateMode.always : AutovalidateMode.disabled,
          key: _formKey,
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
              TextFormField(
                controller: _firstNameCtrl,
                textCapitalization: TextCapitalization.words,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]')), // only letters, no spaces
                ],
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'First Name',
                  hintStyle: TextStyle(color: Color(0xFF8E8E93)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                  errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                  focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Please fill this field';
                  if (!RegExp(r'^[A-Za-z]+$').hasMatch(v.trim())) return 'Only letters allowed';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lastNameCtrl,
                textCapitalization: TextCapitalization.words,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]')), // only letters, no spaces
                ],
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Last Name (optional)',
                  hintStyle: TextStyle(color: Color(0xFF8E8E93)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                  errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                  focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return null; // optional
                  if (!RegExp(r'^[A-Za-z]+$').hasMatch(v.trim())) return 'Only letters allowed';
                  return null;
                },
              ),
              const SizedBox(height: 30),
              _buildSectionHeader("What's your email?"),
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'abc@example.xyz',
                  hintStyle: TextStyle(color: Color(0xFF8E8E93)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                  errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                  focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Please fill this field';
                  final pattern = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!pattern.hasMatch(v.trim())) return 'Enter a valid email';
                  return null;
                },
              ),
              const SizedBox(height: 30),
              _buildSectionHeader("When's your birthday?"),
              TextFormField(
                controller: _dobCtrl,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                  _DateTextInputFormatter(),
                ],
                decoration: const InputDecoration(
                  hintText: 'DD/MM/YYYY',
                  hintStyle: TextStyle(color: Color(0xFF8E8E93)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                  errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                  focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Please fill this field';
                  final text = v.trim();
                  if (text.length != 10) return 'Enter date as DD/MM/YYYY';
                  final parts = text.split('/');
                  if (parts.length != 3) return 'Enter date as DD/MM/YYYY';
                  final day = int.tryParse(parts[0]);
                  final month = int.tryParse(parts[1]);
                  final year = int.tryParse(parts[2]);
                  if (day == null || month == null || year == null) return 'Enter a valid date';
                  if (day < 1 || day > 31) return 'Day must be between 01 and 31';
                  if (month < 1 || month > 12) return 'Month must be between 01 and 12';
                  return null;
                },
              ),
              const SizedBox(height: 30),
              _buildSectionHeader('How do you identify?'),
              DropdownButtonFormField<String>(
                value: _gender,
                items: const [
                  DropdownMenuItem(value: 'Male', child: Text('Male')),
                  DropdownMenuItem(value: 'Female', child: Text('Female')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: (v) {
                  setState(() {
                    _gender = v;
                    _updateFormValid();
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Select',
                  hintStyle: TextStyle(color: Color(0xFF8E8E93)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                  errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                  focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Please fill this field';
                  return null;
                },
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                text: 'Done',
                onPressed: () => _trySubmit(),
                isLoading: _isLoading,
                color: const Color(0xFF34C759),
              ),
            ],
          ),
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

// Custom formatter to insert slashes while typing DDMMYYYY -> DD/MM/YYYY
class _DateTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length > 8) digits = digits.substring(0, 8);

    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);
      if (i == 1 || i == 3) {
        if (i != digits.length - 1) buffer.write('/');
      }
    }
    final formatted = buffer.toString();
    // Calculate new cursor position
    var selectionIndex = formatted.length;
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
