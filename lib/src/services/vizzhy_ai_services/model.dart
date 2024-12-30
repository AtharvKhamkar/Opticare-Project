/// Chatgpt Api
/// https://api.openai.com/v1/threads/$threadId/runs
/// when streaming completed
/// convert response into this model and use it
class ChatgptResponsecompletedMessageModel {
  ///
  final String id;

  /// contains event type
  final String object;

  /// create At
  final int createdAt;

  /// assistant id
  final String assistantId;

  /// thread id
  final String threadId;

  /// run ID
  final String runId;

  /// status of the run
  /// Queued or completed or inprogress
  /// will return completed in this model
  final String status;

  ///
  final int? incompleteAt;

  ///
  final int? completedAt;

  /// role type
  /// expected to return role which was sent during thread creation
  final String role;

  /// contains content of the chatgpt response
  final List<Content> content;

  ///
  final List<dynamic> attachments;

  ///
  final Map<String, dynamic> metadata;

  /// constructor
  ChatgptResponsecompletedMessageModel({
    required this.id,
    required this.object,
    required this.createdAt,
    required this.assistantId,
    required this.threadId,
    required this.runId,
    required this.status,
    this.incompleteAt,
    this.completedAt,
    required this.role,
    required this.content,
    required this.attachments,
    required this.metadata,
  });

  /// Factory constructor to create a ChatgptResponsecompletedMessageModel from a JSON object
  factory ChatgptResponsecompletedMessageModel.fromJson(
      Map<String, dynamic> json) {
    return ChatgptResponsecompletedMessageModel(
      id: json['id'],
      object: json['object'],
      createdAt: json['created_at'],
      assistantId: json['assistant_id'],
      threadId: json['thread_id'],
      runId: json['run_id'],
      status: json['status'],
      incompleteAt: json['incomplete_at'],
      completedAt: json['completed_at'],
      role: json['role'],
      content: (json['content'] as List)
          .map((item) => Content.fromJson(item))
          .toList(),
      attachments: json['attachments'] ?? [],
      metadata: json['metadata'] ?? {},
    );
  }

  /// Method to convert a Message object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'object': object,
      'created_at': createdAt,
      'assistant_id': assistantId,
      'thread_id': threadId,
      'run_id': runId,
      'status': status,
      'incomplete_at': incompleteAt,
      'completed_at': completedAt,
      'role': role,
      'content': content.map((item) => item.toJson()).toList(),
      'attachments': attachments,
      'metadata': metadata,
    };
  }
}

/// store chatgpt response
/// use .text to retrive  text response
class Content {
  ///
  final String type;

  ///
  final TextContent text;

  ///
  Content({
    required this.type,
    required this.text,
  });

  /// factory mdoel return json to model
  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      type: json['type'],
      text: TextContent.fromJson(json['text']),
    );
  }

  /// convert model to json
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'text': text.toJson(),
    };
  }
}

///
class TextContent {
  /// text value
  final String value;

  ///
  final List<dynamic> annotations;

  ///
  TextContent({
    required this.value,
    required this.annotations,
  });

  /// convert json object to model
  factory TextContent.fromJson(Map<String, dynamic> json) {
    return TextContent(
      value: json['value'],
      annotations: json['annotations'] ?? [],
    );
  }

  /// model to json
  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'annotations': annotations,
    };
  }
}
