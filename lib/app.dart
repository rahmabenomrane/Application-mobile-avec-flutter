import 'package:flutter/material.dart';
import 'package:examenmobile/utils/theme/theme.dart';
import 'package:examenmobile/features/authentication/screens/onboarding/onboarding.dart';
import 'package:get/get.dart';
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const OnBoardingScreen(),
    );
  }
}