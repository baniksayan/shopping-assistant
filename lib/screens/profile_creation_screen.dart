import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../services/user_data_service.dart';
import '../widgets/primary_button.dart';

class ProfileCreationScreen extends StatefulWidget {
  final String phoneNumber;
  
  const ProfileCreationScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<ProfileCreationScreen> createState() => _ProfileCreationScreenState();
}

class _ProfileCreationScreenState extends State<ProfileCreationScreen> {
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

  Future<void> _submitProfile() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    
    try {
      // Save user profile data
      await UserDataService.saveUserProfile(
        firstName: _firstNameCtrl.text.trim(),
        lastName: _lastNameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        phone: widget.phoneNumber,
        dateOfBirth: _dobCtrl.text.trim(),
        gender: _gender!,
      );
      
      if (!mounted) return;
      
      // Navigate to Main Navigation Screen (Home)
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving profile: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Create Profile',
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          autovalidateMode: _submitted ? AutovalidateMode.always : AutovalidateMode.disabled,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tell us about yourself!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText,
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
                style: TextStyle(color: AppColors.primaryText),
                decoration: InputDecoration(
                  hintText: 'First Name',
                  hintStyle: TextStyle(color: AppColors.secondaryText),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.secondaryText)),
                  errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                  focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
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
                style: TextStyle(color: AppColors.primaryText),
                decoration: InputDecoration(
                  hintText: 'Last Name (optional)',
                  hintStyle: TextStyle(color: AppColors.secondaryText),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.secondaryText)),
                  errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                  focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
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
                style: TextStyle(color: AppColors.primaryText),
                decoration: InputDecoration(
                  hintText: 'abc@example.xyz',
                  hintStyle: TextStyle(color: AppColors.secondaryText),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.secondaryText)),
                  errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                  focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
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
                style: TextStyle(color: AppColors.primaryText),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                  _DateTextInputFormatter(),
                ],
                decoration: InputDecoration(
                  hintText: 'DD/MM/YYYY',
                  hintStyle: TextStyle(color: AppColors.secondaryText),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.secondaryText)),
                  errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                  focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
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
                dropdownColor: AppColors.cardBackground,
                style: TextStyle(color: AppColors.primaryText),
                items: [
                  DropdownMenuItem(value: 'Male', child: Text('Male', style: TextStyle(color: AppColors.primaryText))),
                  DropdownMenuItem(value: 'Female', child: Text('Female', style: TextStyle(color: AppColors.primaryText))),
                  DropdownMenuItem(value: 'Other', child: Text('Other', style: TextStyle(color: AppColors.primaryText))),
                ],
                onChanged: (v) {
                  setState(() {
                    _gender = v;
                    _updateFormValid();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Select',
                  hintStyle: TextStyle(color: AppColors.secondaryText),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.secondaryText)),
                  errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                  focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Please fill this field';
                  return null;
                },
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                text: 'Create Profile',
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
        style: TextStyle(
          color: AppColors.primaryText,
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