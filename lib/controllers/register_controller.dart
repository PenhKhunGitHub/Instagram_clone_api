import 'dart:io';

import 'package:futter_api_project/services/api_service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';

class RegisterController extends GetxController {
  File? profileImage;
  final apiService = APIService();
  void pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        profileImage = File(pickedFile.path);
        print('Select image $profileImage');
      } else {
        print('No image');
      }
      update(); //refresh ui after pick image
    } catch (e) {
      print('Error Pick image from galley: $e');
    }
  }

  void register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await apiService.registerUser(
          name: name,
          email: email,
          password: password,
          profileImage: profileImage);
      if (res) {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.success,
          text: 'Transaction Completed Successfully!',
        );
      } else {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'Sorry, something went wrong',
        );
      }
    } catch (e) {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: '$e',
      );
      throw Exception(e);
    }
  }

  bool isPasswordVisible = true;
  void changeVisibleIcons() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }
}
