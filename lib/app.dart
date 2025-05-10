import 'package:examenmobile/binding/general_binding.dart';
import 'package:examenmobile/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:examenmobile/utils/theme/theme.dart';
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
      initialBinding:GenerateBindings() ,
      ///home: const OnBoardingScreen(),
      home: const Scaffold(
        backgroundColor: TColors.primary, body: Center(child: CircularProgressIndicator(color: Colors.white))
      ),
    );
  }
}