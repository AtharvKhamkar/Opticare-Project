/// convert error into model
/// used in logging error to firebasefirestore
class CachedErrorModel {
  /// custom error message
  final String errorMessage;

  /// error stack trace
  final String errorStack;

  /// Timestamp when error caught
  final DateTime timestamp;

  ///
  CachedErrorModel({
    required this.errorMessage,
    required this.errorStack,
    required this.timestamp,
  });

  /// Convert to Map (for saving in Firebase Firestore or Realtime Database)
  Map<String, dynamic> toMap() {
    return {
      'errorMessage': errorMessage,
      'errorStack': errorStack,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
