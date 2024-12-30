import 'dart:convert';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:vizzhy/src/data/local_storage/app_storage.dart';
import 'package:vizzhy/src/services/vizzhy_ai_services/model.dart';

/// Use this service to call chatgpt sdk
/// for query and responses
class VizzhyChatgptService {
  ///constructor
  VizzhyChatgptService();
  OpenAI? _openAI;

  /// Example of a method to get OpenAI instance
  OpenAI? get openAI => _openAI;

  /// retrive assistant id from envs
  String get assistantId => AppStorage.getAssistanceId();

  /// get openapikey from env
  String get openaiApiKey => dotenv.env['CHATGPTTOKEN']!;

  /// store chat response
  String chatResponse = '';

  /// initialize openai instance via token
  void createInstanceOfOpenAi() {
    debugPrint(
        'AssistanceId received in the createInstanceOfOpenAi function is $assistantId');
    _openAI ??= OpenAI.instance.build(
        token: dotenv.env['CHATGPTTOKEN']!,
        baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
        enableLog: true);

    // _openAI!.assistant.modifies(
    //     assistantId: dotenv.env['CHATGPTASSISTANTID'] ?? '',
    //     assistant: Assistant(model:));
  }

  /// Function to send a question and get a response from openai
  Stream<ChatgptResponseChat?> getChatResponse(String question) async* {
    chatResponse = '';
    if (_openAI == null) {
      throw Exception("OpenAI instance is not initialized.");
    }

    // final request = CreateThreadAndRun(assistantId: assistantId, thread: {
    //   "messages": [
    //     {"role": "user", "content": question}
    //   ],
    // });

    try {
      // debugPrint(
      //     "request of create thread and run" + request.toJson().toString());

      // create thread
      // pass this thread id to runthread so the response
      final threadResponse =
          await createThread({"role": "user", "content": question});
      // debugPrint("thread resp : ${threadResponse.toJson()}");

      // Run the thread and gather the response
      /// new code via http
      await for (ChatgptResponseChat? chunk in runThread(
          threadId: threadResponse.id,
          openaiApiKey: openaiApiKey,
          inputText: question)) {
        if (chunk != null) {
          yield chunk;
        }
      }

      /// old code via sdk
      // final runResponse = await createRunRequestviaHttp(threadResponse.id);
      // final runResponse = await createRun(
      //     assistantId: assistantId, threadId: threadResponse.id);
      // // final runResponse = await createThreadAndRun(
      // //     assistantId: assistantId, req: {"role": "user", "content": question});
      // debugPrint("run response : ${runResponse}");
      // Future.delayed(Duration(seconds: 2), () async {
      //   await retrieveRun(threadId: threadResponse.id, runId: runResponse.id);
      // });
      // final res = await openAI!.threads.v2.runs
      //     .listRunSteps(threadId: threadResponse.id, runId: runResponse.id);
      // debugPrint('result of list run steps : ${res.data?.first.toJson()}');
      // return " runid: ${runResponse.id}, ${runResponse.incompleteDetails} ,sttopdetial:${runResponse.stepDetails?.toJson()} toolchoice  :${runResponse.toolChoice}   ";
    } catch (error) {
      debugPrint("Error: ${error.toString()}");
      yield null;
    }
  }

  /// chat_gpt_sdk
  ///  create run thread
  Future<CreateRunResponse> createRun(
      {required String assistantId, required String threadId}) async {
    final request = CreateRun(assistantId: assistantId);
    debugPrint("run request : ${request.toJson()}");
    return await openAI!.threads.v2.runs
        .createRun(threadId: threadId, request: request);
  }

  /// chat_gpt_sdk
  /// create thread using sdk to process your query
  Future<ThreadResponse> createThread(Map<String, dynamic> req) async {
    final request = ThreadRequest(messages: [req]);

    return await openAI!.threads.v2.createThread(request: request);
  }

  /// chat_gpt_sdk
  /// after creating thread call this function to retrieve thread information
  Future<ThreadResponse> retrieveThread(String threadID) async {
    return await openAI!.threads.v2.retrieveThread(threadId: threadID);
  }

  /// chat_gpt_sdk
  /// after creating run , call this method to retrive run data
  /// mostly initially when run is created its status is inprogress or Queued
  /// after calling this method we recieved run status as completed
  Future<CreateRunResponse> retrieveRun(
      {required String threadId, required String runId}) async {
    return await openAI!.threads.v2.runs.retrieveRun(
      threadId: threadId,
      runId: runId,
    );
  }

  /// chat_gpt_sdk
  /// sdk provide create thread and create run process in single method
  /// so instead of using and calling two method
  /// we can call this method which will do the same task
  @Deprecated('dont use this funciton as it is depreceated in sdk')
  Future<CreateThreadAndRunData> createThreadAndRun(
      {required String assistantId, required Map<String, dynamic> req}) async {
    final request = CreateThreadAndRun(assistantId: assistantId, thread: {
      "messages": [req],
    });
    return await openAI!.threads.v2.runs.createThreadAndRun(request: request);
  }

  /// chat_gpt_sdk
  /// useing sdk we can modify run which we created from createrun method
  Future<CreateRunResponse> modifyRun(
      {required String threadId, required String runId}) async {
    return await openAI!.threads.v2.runs.modifyRun(
      threadId: threadId,
      runId: runId,
      metadata: {
        "metadata": {"user_id": "user_abc123"},
      },
    );
  }

  /// API Call
  /// Call run method on OpenAI and give response to UI
  Stream<ChatgptResponseChat?> runThread({
    required String threadId,
    required String openaiApiKey,
    required String inputText,
  }) async* {
    try {
      final request = http.Request(
        'POST',
        Uri.parse('https://api.openai.com/v1/threads/$threadId/runs'),
      );

      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $openaiApiKey',
        'OpenAI-Beta': 'assistants=v2',
      });

      request.body = jsonEncode({
        'assistant_id': assistantId,
        'stream': true,
      });

      // Send the request and handle the streamed response
      final response = await http.Client().send(request);

      if (response.statusCode != 200) {
        // return;
        throw Exception('HTTP error! status: ${response.statusCode}');
      }

      // this will transform response stream in tuf8
      // then filter repsonse
      // call the handlestream response function for processing data
      await for (var data in response.stream.transform(utf8.decoder)) {
        final lines =
            data.split('\n').where((e) => e.trim().isNotEmpty).toList();

        for (int i = 0; i < lines.length; i++) {
          // check if the line is starts from event
          if (lines[i].trim().startsWith('event:') &&
              lines[i].trim().substring(6).trim() == 'thread.message.delta') {
            // debugPrint(
            //     "recieved event . now we will process next line data : ${lines[i]}");
            // now go to next line and check if line starts with data
            // if then process it
            if (lines[i + 1].trim().startsWith('data:')) {
              final responseData = lines[i + 1].trim().substring(5);

              // debugPrint(
              //     "--------------------------\n this data will be handled byy handlestremaResp  :$responseData\n----------------------");

              // send pvchunk so that new response will be attached to old response
              // which will be make full sentence otherwise latest word will replace old words
              final result = handleStreamedResponse(
                  data: responseData, pvchunk: chatResponse);

              await for (String? chunk in result) {
                if (chunk != null) {
                  // debugPrint(
                  //     "response recvd from handel stream resposne : $chunk");

                  // new sentence recieved from response
                  // assign value to chatResponse so that for upcoming word will be attached to it
                  chatResponse = chunk;
                  yield ChatgptResponseChat(
                      isStreaming: true,
                      message: chunk); // Yield each new response chunk
                }
              }
            }
          }

          // completed stream response

          if (lines[i].trim().startsWith('event:') &&
              lines[i].trim().substring(6).trim() ==
                  'thread.message.completed') {
            // debugPrint(
            //     "recieved event . now we will process next line data : ${lines[i]}");
            // now go to next line and check if line starts with data
            // if then process it
            if (lines[i + 1].trim().startsWith('data:')) {
              final responseData = lines[i + 1].trim().substring(5);

              // debugPrint(
              //     "--------------------------\n this data will be handled byy handlestremaResp  :$responseData\n----------------------");
              final result =
                  handleStreamedResponse(data: responseData, pvchunk: '');

              await for (String? chunk in result) {
                if (chunk != null) {
                  // debugPrint(
                  //     "response recvd from handel stream resposne : $chunk");
                  yield ChatgptResponseChat(
                      isStreaming: false,
                      message: chunk); // Yield each new response chunk
                }
              }
            }
          }
        }
      }
    } catch (error) {
      debugPrint("Error running thread: $error");
      yield null; // Yield null in case of an error
      return;
    }
  }

  /// pass response recieved from http call to this funciton to process data
  Stream<String?> handleStreamedResponse({
    required String data,
    required String pvchunk,
  }) async* {
    try {
      // final lines = data.split('\n').where((e) => e.trim().isNotEmpty);

      // for (var line in lines) {
      //   line = line.trim();
      // if (line.startsWith('data:')) {
      //   final responseData = line.substring(5);

      if (data.trim() == '[DONE]') {
        // Pass to custom event handler
      } else {
        Map<String, dynamic>? event;
        try {
          event = json.decode(data);
        } on FormatException catch (e) {
          debugPrint("format exception while decoding string : $e");
        } catch (e) {
          debugPrint("error while decoding string : $e");
        }
        if (event != null) {
          final res = await handleStreamedEvent(event);
          pvchunk += res ?? '';
        }
      }
      // return '';

      debugPrint("returning pvchunk as : $pvchunk");
      yield pvchunk;
    } catch (error) {
      debugPrint(
          'Error parsing streamed response in handlestreamedresponse func: $error');
    }
  }

  /// iterate through response and filterout only neccasry data recieved from the response
  Future<String?> handleStreamedEvent(
    Map<String, dynamic> event,
  ) async {
    switch (event['object']) {
      case 'thread.run.step':
        return '';
      case 'thread.message.delta':
        debugPrint('inisde case thread.message.delta ');

        if (event['delta']?['content'] != null) {
          if (event['delta']['content'].isEmpty) {
            return null;
          }
          final content = event['delta']['content'][0]['text']['value'];

          final formattedContent = formatContent(content);

          return formattedContent;
        }
        return null;

      case 'thread.message':
        // Handle final message completion if needed
        final responsemodel =
            ChatgptResponsecompletedMessageModel.fromJson(event);
        debugPrint("Thread message completed: ${responsemodel.toJson()}");
        if (responsemodel.content.isEmpty) {
          return '';
        }
        final content = responsemodel.content.first.text.value;

        final formattedContent = formatContent(content);

        return formattedContent;
      // yield event['delta']['content'][0]['text']['value'];

      default:
        // yield '';
        return null;
    }
    // return null;
  }

  /// format the document such as markdown
  String formatContent(String content) {
    return content
        .replaceAll('\n', '\n') // Maintain newlines for Markdown
        .replaceAllMapped(RegExp(r'\_\_(.+?)\_\_'),
            (match) => '**${match[1]}**') // Convert to bold
        .replaceAllMapped(RegExp(r'\_(.+?)\_'),
            (match) => '*${match[1]}*') // Convert to italic
        .replaceAllMapped(RegExp(r'\`(.+?)\`'),
            (match) => '`${match[1]}`'); // Maintain inline code
  }
}

/// use this class only in vizzhy chatgpt service file
class ChatgptResponseChat {
  /// tell whether this data is one of streaming response
  /// and more data still to come
  final bool isStreaming;

  /// contains response
  final String message;

  /// constructor
  ChatgptResponseChat({required this.isStreaming, required this.message});
}
