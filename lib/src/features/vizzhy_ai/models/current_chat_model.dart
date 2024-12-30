// ignore_for_file: public_member_api_docs

class CurrentChatModel {
  final String title;
  final bool isPinned;
  final List<Prompt> prompt;

  CurrentChatModel({
    this.title = '',
    this.isPinned = false,
    List<Prompt>? prompt,
  }) : prompt = prompt ?? [];

  @override
  String toString() {
    return 'CurrentChatModel(title: $title, isPinned: $isPinned, prompt: $prompt)';
  }

  factory CurrentChatModel.fromJson(Map<String, dynamic> json) {
    return CurrentChatModel(
      title: json['title'] as String? ?? '',
      isPinned: json['isPinned'] as bool? ?? false,
      prompt: (json['prompt'] as List<dynamic>?)
              ?.map((e) => Prompt.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'isPinned': isPinned,
        'prompt': prompt.map((e) => e.toJson()).toList(),
      };
}

class ResponseModel {
  final Feedback feedback;
  final bool isRegenerated;
  final String response;
  final String source;
  final String responseId;
  final bool isLoading;
  final String uuid;

  ResponseModel(
      {Feedback? feedback,
      this.isRegenerated = false,
      this.response = '',
      this.source = 'CHAT-GPT',
      this.responseId = '',
      this.isLoading = false,
      this.uuid = ''})
      : feedback = feedback ?? Feedback();

  @override
  String toString() {
    return 'ResponseModel(feedback: $feedback, isRegenerated: $isRegenerated, response: $response, source: $source, responseId: $responseId)';
  }

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        feedback: json['feedback'] == null
            ? Feedback()
            : Feedback.fromJson(json['feedback'] as Map<String, dynamic>),
        isRegenerated: json['isRegenerated'] as bool? ?? false,
        response: json['response'] as String? ?? '',
        source: json['source'] as String? ?? '',
        responseId: json['responseId'] as String? ?? '',
      );

  factory ResponseModel.answer(String response, bool isLoading, String uuid) =>
      ResponseModel(response: response, isLoading: isLoading, uuid: uuid);

  Map<String, dynamic> toJson() => {
        'feedback': feedback.toJson(),
        'isRegenerated': isRegenerated,
        'response': response,
        'source': source,
        'responseId': responseId,
      };
}

class Feedback {
  final bool like;
  final bool dislike;

  Feedback({
    this.like = false,
    this.dislike = false,
  });

  @override
  String toString() => 'Feedback(like: $like, dislike: $dislike)';

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
        like: json['like'] as bool? ?? false,
        dislike: json['dislike'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'like': like,
        'dislike': dislike,
      };
}

class Prompt {
  final String conversationId;
  final String prompt;
  final List<ResponseModel> responses;
  final String promptId;
  final bool isLoading;
  final String uuid;

  Prompt(
      {this.conversationId = '',
      this.prompt = '',
      List<ResponseModel>? responses,
      this.promptId = '',
      this.isLoading = false,
      this.uuid = ''})
      : responses = responses ?? [];

  @override
  String toString() {
    return 'Prompt(conversationId: $conversationId, prompt: $prompt, responses: $responses, promptId: $promptId)';
  }

  factory Prompt.fromJson(Map<String, dynamic> json) => Prompt(
        conversationId: json['conversationId'] as String? ?? '',
        prompt: json['prompt'] as String? ?? '',
        responses: (json['responses'] as List<dynamic>?)
                ?.map((e) => ResponseModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        promptId: json['promptId'] as String? ?? '',
      );

  factory Prompt.ask(String question, String? conversationId, bool isLoading,
          String uuid) =>
      Prompt(
          conversationId: conversationId ?? '',
          prompt: question,
          responses: [],
          promptId: '',
          isLoading: isLoading,
          uuid: uuid);

  Map<String, dynamic> toJson() => {
        'conversationId': conversationId,
        'prompt': prompt,
        'responses': responses.map((e) => e.toJson()).toList(),
        'promptId': promptId,
      };
}
