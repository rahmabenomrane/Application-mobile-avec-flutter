import 'package:examenmobile/common/styles/spacing_styles.dart';
import 'package:examenmobile/features/authentication/screens/login/login.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:examenmobile/utils/constants/text_strings.dart';
import 'package:examenmobile/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subtitle, this.onPressed});
  final String image, title, subtitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
       child: Padding(
           padding: TSpacingStyle.paddingWithBarHeight * 2,
         child: Column(
           children: [
             Image(image: AssetImage(image),width: THelperFunctions.screenWidth()* 0.6),
             const SizedBox(height: TSizes.spaceBtwSections),

             ///Title subtitle
             Text(title, style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center ),
             const SizedBox(height: TSizes.spaceBtwItems),
             Text(subtitle, style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center ),
             const SizedBox(height: TSizes.spaceBtwSections),
             ///Buttons
             SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=>Get.to(()=>const LoginScreen()), child: const Text(TTexts.tContinue))),

           ],
         ),
       ),
      ),
    );
  }
}
