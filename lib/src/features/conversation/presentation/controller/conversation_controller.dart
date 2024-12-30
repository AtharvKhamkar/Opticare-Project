import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/data/local_storage/app_storage.dart';
import 'package:vizzhy/src/features/profile/controllers/profile_controller.dart';
import 'package:vizzhy/src/features/try_terra/presentation/controllers/try_terra_controller.dart';
import '../services/speech_to_text_service.dart';

/// Controller for managing the conversation screen, handling speech-to-text,
/// text field management, and user interactions.
class ConversationController extends GetxController {
  /// Controller for handling text input
  final TextEditingController textController = TextEditingController();

  /// Service for speech-to-text functionality
  final SpeechToTextService speechService = SpeechToTextService.service;

  /// Observable for tracking if the speech-to-text is listening
  var isListening = false.obs;

  /// Observable for storing the recognized text from speech
  var recognizedText = ''.obs;

  /// Observable for determining if the text field is editable
  var isEditable = true.obs;

  /// Observable for checking if the text field is empty
  var isTextFieldEmpty = true.obs;

  /// Observable for tracking the elapsed listening time in "MM:SS" format
  var listningTiming = '00:00'.obs;

  /// Observable for storing the last input meal (custom functionality)
  var lastInputMeal = ''.obs;

  /// Timer for updating the stopwatch
  Timer? timer;

  /// Stopwatch to track listening duration
  Stopwatch stopwatch = Stopwatch();

  /// Called when the controller is initialized.
  /// Adds a listener to track changes in the text field.
  @override
  void onInit() {
    super.onInit();
    textController.addListener(() {
      // Updates the observable to track if the text field is empty
      isTextFieldEmpty.value = textController.text.isEmpty;
    });
  }

  /// Called when the controller is disposed.
  /// Cleans up resources like the text controller.
  @override
  void onClose() {
    textController.dispose(); // Dispose of the text controller to free memory
    super.onClose();
  }

  /// Starts the speech-to-text listening process.
  /// Initializes the speech service and updates observables with recognized text.
  void startListening() {
    recognizedText.value = "";
    textController.text = "";
    startStopWatch(); // Start the stopwatch for timing the listening session

    // Initialize and start the speech service
    speechService.initializeAndStart(
      (result) {
        isListening.value = true; // Update listening status
        recognizedText.value = result; // Store recognized text
        debugPrint("result : $result");
        textController.value =
            TextEditingValue(text: result); // Update text field
      },
      (state) {
        if (state == 'listening') {
          isListening.value = true; // Update status when actively listening
        }
        debugPrint(state);
        if (state == 'done') {
          resetStopWatch(); // Reset the stopwatch when done listening
          isListening(false);
        }
      },
      (error) {
        // Handle errors during speech-to-text processing
        debugPrint('error on listening : $error');
        isEditable(false); // Make the text field non-editable
        isListening.value = false;
      },
    );
  }

  /// Stops the speech-to-text listening process.
  void stopListening() {
    if (isListening.value == true) {
      speechService.stop(); // Stop the speech service
      isEditable(false); // Disable editing
      isListening.value = false; // Update listening status
    }
  }

  /// Toggles the editability of the text field.
  void toggleEditable() {
    isEditable.toggle(); // Switch between editable and non-editable states
  }

  /// Starts the stopwatch and updates the listening time every 100 milliseconds.
  void startStopWatch() {
    stopwatch.start();
    timer = Timer.periodic(
      const Duration(milliseconds: 100),
      (Timer t) {
        // Format the elapsed time as "MM:SS"
        final minutesStr =
            (stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0');
        final secondStr =
            (stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0');
        listningTiming.value = '$minutesStr:$secondStr';
      },
    );
  }

  /// Resets the stopwatch and stops the timer.
  void resetStopWatch() {
    stopwatch.stop(); // Stop the stopwatch
    stopwatch.reset(); // Reset stopwatch to zero
    timer?.cancel(); // Cancel the periodic timer
    listningTiming.value = '00:00'; // Reset timing display
  }

  /// Resets all observable values and clears the text field.
  void reset() async {
    textController.clear(); // Clear text field content
    isListening.value = false;
    recognizedText.value = '';
    isEditable.value = true;
    isEditable.value = true;
    listningTiming.value = '00:00';
  }
}

/// Dependency binding class for the Conversation feature.
class ConversationBindings extends Bindings {
  /// Registers the ConversationController and ProfileController as dependencies.
  @override
  void dependencies() {
    // Lazy-load the ConversationController with `fenix` to keep it alive
    Get.lazyPut<ConversationController>(() => ConversationController(),
        fenix: true);

    Get.lazyPut<TryTerraController>(() => TryTerraController(), fenix: true);

    // Pre-fetch ProfileController
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
      fenix: true,
    );

    // Trigger the fetchProfile method on ProfileController
    Get.find<ProfileController>().fetchProfile();

    // initialize terra once loggedin or app starts
    Get.find<TryTerraController>().init(AppStorage.getUserId());
  }
}
