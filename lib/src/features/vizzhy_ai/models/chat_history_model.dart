// ignore_for_file: public_member_api_docs

/// ChatHistoryModel
class ChatHistoryModel {
  final String assistantId;
  final List<ConversationHistory> conversationHistory;

  ChatHistoryModel({
    this.assistantId = '',
    List<ConversationHistory>? conversationHistory,
  }) : conversationHistory = conversationHistory ?? [];

  @override
  String toString() {
    return 'ChatHistoryModel(assistantId: $assistantId, conversationHistory: $conversationHistory)';
  }

  factory ChatHistoryModel.fromJson(Map<String, dynamic> json) {
    return ChatHistoryModel(
      assistantId: json['assistantId'] as String? ?? '',
      conversationHistory: (json['conversationHistory'] as List<dynamic>?)
              ?.map((e) =>
                  ConversationHistory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'assistantId': assistantId,
        'conversationHistory':
            conversationHistory.map((e) => e.toJson()).toList(),
      };
}

/// ConversationHistory
class ConversationHistory {
  final String duration;
  final int priority;
  final List<Conversation> conversations;

  ConversationHistory({
    this.duration = '',
    this.priority = 0,
    List<Conversation>? conversations,
  }) : conversations = conversations ?? [];

  @override
  String toString() {
    return 'ConversationHistory(duration: $duration, priority: $priority, conversations: $conversations)';
  }

  factory ConversationHistory.fromJson(Map<String, dynamic> json) {
    return ConversationHistory(
      duration: json['duration'] as String? ?? '',
      priority: json['priority'] as int? ?? 0,
      conversations: (json['conversations'] as List<dynamic>?)
              ?.map((e) => Conversation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'duration': duration,
        'priority': priority,
        'conversations': conversations.map((e) => e.toJson()).toList(),
      };
}

/// Conversation
class Conversation {
  final String conversationId;
  final String conversation;
  final DateTime createdAt;
  final String style;
  final bool isPinned;

  Conversation({
    this.conversationId = '',
    this.conversation = '',
    DateTime? createdAt,
    this.isPinned = false,
    this.style = '',
  }) : createdAt = createdAt ?? DateTime.now();

  @override
  String toString() {
    return 'Conversation(conversationId: $conversationId, conversation: $conversation, createdAt: $createdAt, style: $style,isPinned :$isPinned)';
  }

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        conversationId: json['conversationId'] as String? ?? '',
        conversation: json['conversation'] as String? ?? '',
        createdAt: json['createdAt'] == null
            ? DateTime.now()
            : DateTime.parse(json['createdAt'] as String),
        style: json['style'] as String? ?? '',
        isPinned: json['isPinned'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'conversationId': conversationId,
        'conversation': conversation,
        'createdAt': createdAt.toIso8601String(),
        'style': style,
        'isPinned': isPinned,
      };
}
