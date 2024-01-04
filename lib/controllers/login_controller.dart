import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class SigInController extends GetxController {
  final isPasswordVisible = true.obs;
  void changeVisibleIcons() {
    isPasswordVisible.value = false;
  }
}
