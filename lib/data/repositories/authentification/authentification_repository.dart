import 'package:examenmobile/features/authentication/screens/login/login.dart';
import 'package:examenmobile/features/authentication/screens/onboarding/onboarding.dart';
import 'package:examenmobile/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:examenmobile/utils/exceptions/firebase_exceptions.dart';
import 'package:examenmobile/utils/exceptions/format_exceptions.dart';
import 'package:examenmobile/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  void screenRedirect() {
    deviceStorage.writeIfNull('IsFirstTime', true);
    final isFirstTime = deviceStorage.read('IsFirstTime') as bool;
    if (isFirstTime) {
      Get.offAll(() => const OnBoardingScreen());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  /// Email & Password Registration
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception('Something went wrong. Please try again.');
    }
  }
}
