import 'package:speech_to_text/speech_to_text.dart';

/// A Service Class to provide speech to text functionality
class SpeechToTextService {
  SpeechToTextService._();

  static final SpeechToTextService _service = SpeechToTextService._();

  /// get SpeechToTextService instance of the class
  static SpeechToTextService get service => _service;

  // final _errorMessage =
  //     "Sorry, Vizzhy cannot access your device's audio capabilities at this time. Please ensure that the app has permission to use the microphone and audio settings in your device's settings";

  final _speechToText = SpeechToText();

  Future<void> initializeAndStart(Function(String result) onResult,
      Function(String state) onState, Function(String erro) onError) async {
    await _speechToText
        .initialize(
      finalTimeout: const Duration(seconds: 10),
      options: [
        SpeechToText.androidAlwaysUseStop,
        SpeechToText.androidIntentLookup,
      ],
      onStatus: (state) {
        onState.call(state);
      },
      onError: (error) => onError.call(error.errorMsg),
    )
        .then((value) {
      if (value) {
        _start(onResult);
      }
    });
  }

  Future<void> _start(onResult) async {
    await _speechToText.listen(
      pauseFor: const Duration(seconds: 5),
      listenOptions: SpeechListenOptions(
          listenMode: ListenMode.dictation,
          cancelOnError: true,
          enableHapticFeedback: true),
      onResult: (value) {
        onResult.call(value.recognizedWords);
      },
    );
  }

  /// Stop the speech to text functionality
  Future<void> stop() async {
    if (_speechToText.isListening) await _speechToText.stop();
  }
}
