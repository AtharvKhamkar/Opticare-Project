import 'package:flutter/foundation.dart';
import 'package:vizzhy/src/core/injection/injection.dart';
import 'package:vizzhy/src/data/remote/api_client.dart';
import 'package:vizzhy/src/features/conversation/presentation/services/error_handler.dart';
import 'package:vizzhy/src/features/profile/models/profile_model.dart';
import 'package:vizzhy/src/utils/failure.dart';

///This is a ProfileRepository class used to handle all network request related to the profile feature
class ProfileRepository {
  ///Instance of the ApiClient
  final apiClient = getIt<ApiClient>();

  ///Function that handles API requestto get profile details of the user
  Future<ProfileModel?> getProfileDetails(String userId) async {
    try {
      final response = await apiClient.getRequest('onboarding/customer/$userId',
          serverType: ServerTypes.onboarding);
      final result = response.fold((l) {
        ErrorHandle.error(l.message);

        return null;
      }, (r) {
        final profileDetails = r.data['customerDetails'];
        return ProfileModel.fromJson(profileDetails);
      });
      return result;
    } catch (e) {
      ErrorHandle.error(VizzhySomethingWentWrongFailure());
      debugPrint('error caught in getprofiledetails : $e');
      return null;
    }
  }
}
