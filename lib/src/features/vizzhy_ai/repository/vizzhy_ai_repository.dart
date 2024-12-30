import 'package:flutter/foundation.dart';
import 'package:vizzhy/src/core/injection/injection.dart';
import 'package:vizzhy/src/data/remote/api_client.dart';
import 'package:vizzhy/src/features/conversation/presentation/services/error_handler.dart';
import 'package:vizzhy/src/features/vizzhy_ai/models/chat_history_model.dart';
import 'package:vizzhy/src/features/vizzhy_ai/models/current_chat_model.dart';
import 'package:vizzhy/src/presentation/widgets/custom_toast_util.dart';

class VizzhyAiRepository {
  final apiClient = getIt<ApiClient>();

  Future<ChatHistoryModel?> getChatHistory() async {
    try {
      final response = await apiClient.getRequest(
          '/customer/conversation/prompt/history',
          serverType: ServerTypes.conversation);

      final result = response.fold(
        (l) {
          // ErrorHandle.error(l.message);
          debugPrint(l.message);
        },
        (r) {
          debugPrint(
              'Data recieved in the getChatHistory is ${r.data.toString()}');
          return ChatHistoryModel.fromJson(r.data);
        },
      );
      return result;
    } catch (e) {
      debugPrint('Error in getChatHistory :: VizzhyAiRepositoty :: $e');
    }
    return null;
  }

  Future<CurrentChatModel?> getCurrentChat(String conversationId) async {
    try {
      Map<String, dynamic> id = {'conversationId': conversationId};
      final response = await apiClient.getRequest(
          '/customer/conversation/prompt',
          additionalQueryParams: id,
          serverType: ServerTypes.conversation);
      final result = response.fold(
        (l) {
          ErrorHandle.error(l.message);
        },
        (r) {
          debugPrint(
              'Data recieved in the getCurrentChat is ${r.data.toString()}');
          return CurrentChatModel.fromJson(r.data);
        },
      );
      return result;
    } catch (e) {
      debugPrint('Error in getCurrentChat :: VizzhyAiRepository :: $e');
    }
    return null;
  }

  /// post new chat to the api
  Future<Map?> postCurrentChat({
    String? conversationId,
    required String title,
    required String chatResponse,
    required String prompt,
  }) async {
    try {
      // bool isPosted = false;
      Map<String, dynamic> body = {
        "data": {
          "title": title.trim(),
          "prompt": prompt.trim(),
          "response": chatResponse.trim(),
          "source": "CHAT-GPT"
        }
      };

      String endpoint = '/customer/conversation/prompt';

      if (conversationId != null) {
        endpoint += '?conversationId=$conversationId';
      }

      final response = await apiClient.postRequest(endpoint,
          serverType: ServerTypes.conversation, request: body);
      final result = response.fold((l) {
        ErrorHandle.error(l.message);
        // isPosted = false;
        // return isPosted;
        return null;
      }, (r) {
        debugPrint(
            'Data recieved in the getCurrentChat is ${r.data.toString()}');
        if (r.data['conversationId'] != null && r.data['promptId'] != null) {
          // isPosted = true;
          return r.data as Map;
        } else {
          //
          return null;
        }
      });

      return result;
    } catch (e) {
      debugPrint('Error in postCurrentChat :: VizzhyAiRepository :: $e');
    }
    return null;
  }

  /// pin and unpin toggle
  void patchPinToggle({required String? convId, required bool isPinned}) {
    if (convId == null || convId.isEmpty) {
      ErrorHandle.error('conversation id is null');
      return;
    }

    try {
      // bool isPosted = false;
      Map<String, dynamic> body = {
        "data": {"isPinned": isPinned}
      };

      String endpoint = '/customer/conversation/isPinned/$convId';
      apiClient
          .patchRequest(endpoint,
              serverType: ServerTypes.conversation, request: body)
          .then((response) {
        response.fold((l) {
          ErrorHandle.error(l.message);
          return null;
        }, (r) {
          debugPrint(
              'Data recieved in the patchPinToggle is ${r.data.toString()}');
          CustomToastUtil.showSucessToast(message: r.data['message']);
        });
      });
    } catch (e) {
      debugPrint('Error in postCurrentChat :: VizzhyAiRepository :: $e');
    }
    // return null;
  }
}
