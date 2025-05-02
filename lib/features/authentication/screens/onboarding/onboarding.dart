import 'package:examenmobile/features/authentication/screens/onboarding/onboarding.dart';
import 'package:examenmobile/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:examenmobile/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:examenmobile/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:examenmobile/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:examenmobile/utils/constants/colors.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:examenmobile/utils/constants/text_strings.dart';
import 'package:examenmobile/utils/device/device_utility.dart';
import 'package:examenmobile/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:examenmobile/utils/constants/image_strings.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:examenmobile/features/authentication/controllers.onboarding/onboarding_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                image: TImages.onBoardingImage1,
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage2,
                title: TTexts.onBoardingTitle2,
                subTitle: TTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage3,
                title: TTexts.onBoardingTitle3,
                subTitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),
          const OnBoardingSkip(),
          const OnboardingDotNavigation(),
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}



