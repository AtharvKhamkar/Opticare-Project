import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/data/local_storage/app_storage.dart';

// import 'package:vizzhy/src/features/conversation/presentation/services/error_handler.dart';

// import 'package:vizzhy/src/features/conversation/presentation/services/error_handler.dart';
import 'package:vizzhy/src/features/profile/Repository/profile_repository.dart';

import '../models/profile_model.dart';

///ProfileController is used to manage the state of the Reports Upload feature
class ProfileController extends GetxController with StateMixin<dynamic> {
  final _profileRepo = ProfileRepository();

  ///default profile Model
  var profile = ProfileModel(
          uniqueCustomerId: 'VZ0001',
          firstName: "",
          lastName: "Doe",
          gender: "Male",
          dateOfBirth: "1/04/1990",
          email: "john.doe@gmail.com",
          phone: "8888456754",
          address: "201, Palm Springs,",
          assistanceId: "")
      .obs;

  ///UserId fetched from localstorage
  var userId = AppStorage.getUserId();

  ///Used to store error message in the controller
  var errorMessage = ''.obs;

  ///tracks the loading state of the controller
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchProfile();
    super.onInit();
  }

  ///function used to fetch profile details
  Future<void> fetchProfile() async {
    if (isLoading.value) return;
    isLoading(true);
    update();

    final result = await _profileRepo.getProfileDetails(userId);
    // .then(
    //   (value) {
    isLoading(false);
    if (result != null) {
      profile(result);
      debugPrint(
          'AssistanceId received in the fetchProfile is ${result.assistanceId}');
      AppStorage.setAssistanceId(result.assistanceId);
    }
    update();
    //   },
    //   onError: (e) {
    //     isLoading(false);
    //     ErrorHandle.error("$e");
    //     update();
    //   },
    // );
  }
}

///ProfileBinding is used to initialize the controller before the profile page
class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}
