import 'package:examenmobile/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:examenmobile/utils/constants/text_strings.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:examenmobile/data/repositories/authentification/authentification_repository.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading
            Text(TTexts.forgetPasswordTitle, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(TTexts.forgetPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: TSizes.spaceBtwSections * 2),

            /// Text field
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: TTexts.email,
                prefixIcon: Icon(Iconsax.direct_right),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => sendPasswordResetEmail(emailController.text.trim()),
                child: const Text(TTexts.submit),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);
      Get.snackbar(
        'Email Sent',
        'Password reset link sent to $email',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.to(() => ResetPassword(email: email));
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}