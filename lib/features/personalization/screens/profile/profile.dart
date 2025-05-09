import 'package:examenmobile/common/widgets/appbar/appbar.dart';
import 'package:examenmobile/common/widgets/texts/section_heading.dart';
import 'package:examenmobile/features/authentication/screens/password_configuration/change_password.dart';
import 'package:examenmobile/features/personalization/controllers/user_controller.dart';
import 'package:examenmobile/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:examenmobile/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:examenmobile/utils/constants/image_strings.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: TAppBar(showBackArrow: true,title: Text('Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Profile Picture Section
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(TImages.user),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Change Profile Picture'),
              ),

              // Profile Information Section
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              const TSectionHeading(title: 'Profile Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(
                title: 'Name',
                value: controller.user.value.fullName,
                onPressed: () => Get.to(()=> const ChangeNameScreen()),
              ),
              TProfileMenu(
                title: 'Username',
                value: controller.user.value.username,
                onPressed: () {},
              ),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Personal Information Section
              const TSectionHeading(title: 'Personal Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),


              TProfileMenu(
                title: 'E-mail',
                value: controller.user.value.email,
                onPressed: () {},
              ),
              TProfileMenu(
                title: 'Phone Number',
                value: controller.user.value.phoneNumber,
                onPressed: () {},
              ),
              TProfileMenu(
                title: 'Gender',
                value: 'Male',
                onPressed: () {},
              ),
              TProfileMenu(
                title: 'Date of Birth',
                value: '18 Oct, 1994',
                onPressed: () {},
              ),
              TProfileMenu(
                title: 'Password',
                value: '********',
                icon: Iconsax.password_check,
                onPressed: () => Get.to(() => const ChangePasswordScreen()),
              ),




              // Close Account Button
              const SizedBox(height: TSizes.spaceBtwSections),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}