import 'package:examenmobile/common/widgets/appbar/appbar.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:examenmobile/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:examenmobile/data/repositories/authentification/authentification_repository.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscureOldPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Change Password'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Current Password
              TextFormField(
                controller: oldPasswordController,
                obscureText: obscureOldPassword,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    icon: Icon(obscureOldPassword ? Iconsax.eye_slash : Iconsax.eye),
                    onPressed: () => setState(() => obscureOldPassword = !obscureOldPassword),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// New Password
              TextFormField(
                controller: newPasswordController,
                obscureText: obscureNewPassword,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    icon: Icon(obscureNewPassword ? Iconsax.eye_slash : Iconsax.eye),
                    onPressed: () => setState(() => obscureNewPassword = !obscureNewPassword),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// Confirm New Password
              TextFormField(
                controller: confirmPasswordController,
                obscureText: obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    icon: Icon(obscureConfirmPassword ? Iconsax.eye_slash : Iconsax.eye),
                    onPressed: () => setState(() => obscureConfirmPassword = !obscureConfirmPassword),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _changePassword(
                    oldPasswordController.text.trim(),
                    newPasswordController.text.trim(),
                    confirmPasswordController.text.trim(),
                  ),
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _changePassword(
      String oldPassword,
      String newPassword,
      String confirmPassword
      ) async {
    try {
      // Validation
      if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
        throw "Please fill in all fields";
      }

      if (newPassword != confirmPassword) {
        throw "Passwords do not match";
      }

      if (newPassword.length < 6) {
        throw "Password must be at least 6 characters";
      }

      await AuthenticationRepository.instance
          .changePassword(oldPassword, newPassword);

      Get.back();
      Get.snackbar(
        'Success',
        'Password updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    }
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}