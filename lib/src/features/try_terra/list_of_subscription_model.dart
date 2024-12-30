import 'package:flutter/cupertino.dart';

// Model for the user
class TryTerraUser {
  final String provider;
  final bool active;
  final String? lastWebhookUpdate;
  final String userId;
  final String scopes; // Assuming scopes is a list, modify if it's different
  final DateTime createdAt;
  final String referenceId;

  TryTerraUser({
    required this.provider,
    required this.active,
    this.lastWebhookUpdate,
    required this.userId,
    required this.scopes,
    required this.createdAt,
    required this.referenceId,
  });

  // Factory method to create a TryTerraUser object from JSON
  factory TryTerraUser.fromJson(Map<String, dynamic> json) {
    debugPrint("terauser fromson :--${json['scopes'].runtimeType}--");
    return TryTerraUser(
      provider: json['provider'],
      active: json['active'],
      lastWebhookUpdate: json['last_webhook_update'],
      userId: json['user_id'],
      scopes: json['scopes'] ?? '',
      // Assuming scopes is an array
      createdAt: DateTime.parse(json['created_at']),
      referenceId: json['reference_id'],
    );
  }

  // Method to convert a TryTerraUser object to JSON
  Map<String, dynamic> toJson() {
    return {
      'provider': provider,
      'active': active,
      'last_webhook_update': lastWebhookUpdate,
      'user_id': userId,
      'scopes': scopes,
      'created_at': createdAt.toIso8601String(),
      'reference_id': referenceId,
    };
  }
}

// Model for the response
class TryTerraUserResponse {
  final String status;
  final List<TryTerraUser> users;

  TryTerraUserResponse({
    required this.status,
    required this.users,
  });

  // Factory method to create a UserResponse object from JSON
  factory TryTerraUserResponse.fromJson(Map<String, dynamic> json) {
    return TryTerraUserResponse(
      status: json['status'],
      users: (json['users'] as List)
          .map((user) => TryTerraUser.fromJson(user))
          .toList(),
    );
  }
}
