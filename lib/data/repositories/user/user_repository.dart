import 'package:examenmobile/data/repositories/authentification/authentification_repository.dart';
import 'package:examenmobile/models/user_model.dart';
import 'package:examenmobile/utils/exceptions/firebase_exceptions.dart';
import 'package:examenmobile/utils/exceptions/format_exceptions.dart';
import 'package:examenmobile/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// save user data to  Firestore.
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db
          .collection("Users")
          .doc(user.id)
          .set(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong .please try again ';
    }
  }

// fetch user details based on ID
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db.collection("Users").doc(
          AuthenticationRepository.instance.authUser?.uid).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    }
    on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (_) {
      throw const TFormatException();
    }
    on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

// update user data in firebase
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db.collection("Users").doc(updatedUser.id).update(
          updatedUser.toJson());
    }
    on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (_) {
      throw const TFormatException();
    }
    on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

// update any field in specific users collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection("Users").doc(
          AuthenticationRepository.instance.authUser?.uid).update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

// remove user data from Firebase
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
