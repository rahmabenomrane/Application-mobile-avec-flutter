import 'package:examenmobile/common/styles/spacing_styles.dart';
import 'package:examenmobile/common/widgets/login_signup/form_divider.dart';
import 'package:examenmobile/common/widgets/login_signup/social_buttons.dart';
import 'package:examenmobile/features/authentication/screens/login/widgets/login_form.dart';
import 'package:examenmobile/features/authentication/screens/login/widgets/login_header.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TLoginHeader(),
              TLoginForm(),
              TFormDivider(),
              SizedBox(height: TSizes.spaceBtwSections),
              TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
