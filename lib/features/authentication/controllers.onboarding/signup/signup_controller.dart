import 'package:examenmobile/data/repositories/authentification/authentification_repository.dart';
import 'package:examenmobile/data/repositories/user/user_repository.dart';
import 'package:examenmobile/features/authentication/screens/signup/verify_email.dart';
import 'package:examenmobile/models/user_model.dart';
import 'package:examenmobile/utils/constants/image_strings.dart';
import 'package:examenmobile/utils/helpers/network_manager.dart';
import 'package:examenmobile/utils/popups/full_screen_loader.dart';
import 'package:examenmobile/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();

  //final agreeToTerms = false.obs;
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signup() async {
    try {
      //Start Loading
      TFullScreenLoader.openLoadingDialog(
        'we are processing your information',
        TImages.docerAnimation      );
      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //from validation
      // Validate Form
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // privacy policy check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
          title: 'Accept Privicy Policy',
          message:
              "In order to create accent , you must have read the Privicy Policy & Terms of Use",
        );
        return;
      }

      //register user

      final userCredential= await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
            email.text.trim(),
            password.text.trim(),
          );
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Show success msg
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your account has been created ! Verify email to continue.');
      Get.to(() =>  VerifyEmailScreen(email:email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Error!', message: e.toString());
    }
  }


}
