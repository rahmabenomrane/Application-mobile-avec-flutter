import 'package:examenmobile/data/repositories/user/user_repository.dart';
import 'package:examenmobile/features/personalization/screens/profile/profile.dart';
import 'package:examenmobile/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:examenmobile/models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  final profileFormKey = GlobalKey<FormState>();

  // Contrôleurs de formulaire
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);

      // Initialisation des contrôleurs
      firstName.text = user.firstName;
      lastName.text = user.lastName;
      username.text = user.username;
      email.text = user.email;
      phoneNumber.text = user.phoneNumber;
    } catch (e) {
      user(UserModel.empty());
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      profileLoading.value = false;
    }
  }

  // Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        // Convert Name to First and Last Name
        final nameParts = UserModel.nameParts(
          userCredentials.user!.displayName ?? '',
        );
        final username = UserModel.generateUsername(
          userCredentials.user!.displayName ?? '',
        );

        // Map Data
        final user = UserModel(
          id: userCredentials.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          username: username,
          email: userCredentials.user!.email ?? '',
          phoneNumber: userCredentials.user!.phoneNumber ?? '',
          profilePicture: userCredentials.user!.photoURL ?? '',
        );

        // Save user data
        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      TLoaders.warningSnackBar(
        title: 'Data not saved',
        message:
            'Something went wrong while saving your information. You can re-save your data in your Profile.',
      );
    }
  }
  Future<void> updateUserDetails() async {
    try {
      if (!profileFormKey.currentState!.validate()) {
        TLoaders.warningSnackBar(
          title: 'Validation Error',
          message: 'Please fill all required fields correctly',
        );
        return;
      }

      profileLoading.value = true;

      final updatedUser = UserModel(
        id: user.value.id,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: user.value.profilePicture,
      );

      await userRepository.updateUserDetails(updatedUser);
      user(updatedUser);

      TLoaders.successSnackBar(
        title: 'Success!',
        message: 'Your profile has been updated',
      );

      // Redirection après succès
      Get.offAll(() => ProfileScreen());

    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Error',
        message: e.toString(),
      );
    } finally {
      profileLoading.value = false;
    }
  }}

