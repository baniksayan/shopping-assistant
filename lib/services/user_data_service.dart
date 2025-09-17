import 'package:hive_flutter/hive_flutter.dart';

class UserDataService {
  static const String _boxName = 'user_box';
  static const String _firstNameKey = 'first_name';
  static const String _lastNameKey = 'last_name';
  static const String _emailKey = 'email';
  static const String _phoneKey = 'phone';
  static const String _dobKey = 'dob';
  static const String _genderKey = 'gender';
  static const String _isRegisteredKey = 'is_registered';
  static const String _profileImageKey = 'profile_image';
  
  static Box? _box;

  // Initialize Hive and open the user box
  static Future<void> init() async {
    if (_box == null) {
      _box = await Hive.openBox(_boxName);
    }
  }

  // Check if user is registered (has completed profile creation)
  static bool get isUserRegistered {
    return _box?.get(_isRegisteredKey, defaultValue: false) ?? false;
  }

  // Get user's full name
  static String get fullName {
    final firstName = _box?.get(_firstNameKey, defaultValue: '') ?? '';
    final lastName = _box?.get(_lastNameKey, defaultValue: '') ?? '';
    return lastName.isEmpty ? firstName : '$firstName $lastName';
  }

  // Get user's first name only
  static String get firstName {
    return _box?.get(_firstNameKey, defaultValue: '') ?? '';
  }

  // Get user's email
  static String get email {
    return _box?.get(_emailKey, defaultValue: '') ?? '';
  }

  // Get user's phone
  static String get phone {
    return _box?.get(_phoneKey, defaultValue: '') ?? '';
  }

  // Get user's date of birth
  static String get dateOfBirth {
    return _box?.get(_dobKey, defaultValue: '') ?? '';
  }

  // Get user's gender
  static String get gender {
    return _box?.get(_genderKey, defaultValue: '') ?? '';
  }

  // Get profile image path
  static String get profileImage {
    return _box?.get(_profileImageKey, defaultValue: '') ?? '';
  }

  // Save user profile data
  static Future<void> saveUserProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String dateOfBirth,
    required String gender,
  }) async {
    await _box?.put(_firstNameKey, firstName);
    await _box?.put(_lastNameKey, lastName);
    await _box?.put(_emailKey, email);
    await _box?.put(_phoneKey, phone);
    await _box?.put(_dobKey, dateOfBirth);
    await _box?.put(_genderKey, gender);
    await _box?.put(_isRegisteredKey, true);
  }

  // Update specific user data
  static Future<void> updateFirstName(String firstName) async {
    await _box?.put(_firstNameKey, firstName);
  }

  static Future<void> updateLastName(String lastName) async {
    await _box?.put(_lastNameKey, lastName);
  }

  static Future<void> updateEmail(String email) async {
    await _box?.put(_emailKey, email);
  }

  static Future<void> updatePhone(String phone) async {
    await _box?.put(_phoneKey, phone);
  }

  static Future<void> updateDateOfBirth(String dob) async {
    await _box?.put(_dobKey, dob);
  }

  static Future<void> updateGender(String gender) async {
    await _box?.put(_genderKey, gender);
  }

  static Future<void> updateProfileImage(String imagePath) async {
    await _box?.put(_profileImageKey, imagePath);
  }

  // Clear all user data (for logout)
  static Future<void> clearUserData() async {
    await _box?.clear();
  }

  // Close the Hive box
  static Future<void> close() async {
    await _box?.close();
  }
}