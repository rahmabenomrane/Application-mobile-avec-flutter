import 'package:examenmobile/data/repositories/authentification/authentification_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';
import 'app.dart';
import 'package:get/get.dart';

Future<void> main() async {
  // Initialisation des widgets
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Initialisation de GetStorage
  await GetStorage.init();

  // Préserver l'écran de splash jusqu'à la fin du chargement
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// -- Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
          (FirebaseApp value) => Get.put(AuthenticationRepository())
  );



  // Lancer l'application
  runApp(const App());
}
