import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// A class for securely managing user data using FlutterSecureStorage.
class SecureDB {
  // Singleton instance of the SecureDB class
  static final _sembastDB = SecureDB._();

  /// Instance of FlutterSecureStorage for secure data storage
  static const storage = FlutterSecureStorage();

  // Private constructor for Singleton pattern
  SecureDB._();

  /// Factory constructor to provide access to the Singleton instance
  factory SecureDB() {
    return _sembastDB;
  }

  /// Clears all data stored in the secure storage.
  static Future<void> clearSecureDB() async {
    await storage.deleteAll(); // Deletes all key-value pairs in secure storage
  }

  /// Retrieves user details from secure storage.
  ///
  /// Returns a `Map<String, dynamic>` containing user details if available,
  /// otherwise returns `null`.
  static Future<Map<String, dynamic>?> getUserDetails() async {
    // Read the 'user-details' key from secure storage
    final string = await storage.read(key: 'user-details');

    // If no data is found, return null
    if (string == null) return null;

    // Decode the JSON string into a Map
    Map<String, dynamic> data = jsonDecode(string);
    return data;
  }

  /// Stores user details in secure storage.
  ///
  /// Accepts a `Map<String, dynamic>` and saves it as a JSON string
  /// under the 'user-details' key.
  static Future<void> setUserDetails(Map<String, dynamic> data) async {
    // Encode the data as a JSON string and write it to secure storage
    await storage.write(key: 'user-details', value: jsonEncode(data));
  }
}
