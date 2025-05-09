import 'dart:ui';

import 'package:examenmobile/common/widgets/appbar/appbar.dart';
import 'package:examenmobile/common/widgets/products.cart/cart_menu_icon.dart';
import 'package:examenmobile/common/widgets/shimmers/shimmer.dart';
import 'package:examenmobile/features/personalization/controllers/user_controller.dart';
import 'package:examenmobile/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:examenmobile/utils/constants/text_strings.dart';
import 'package:get/get.dart';
class THomeAppBar extends StatelessWidget {
  const THomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TTexts.homeAppbarTitle,
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.apply(color: TColors.grey),
          ),
          Obx(() {
            if (controller.profileLoading.value) {
              return const TShimmerEffect(width: 80, height: 15);
            } else {
              return Text(
                controller.user.value.fullName,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.apply(color: TColors.white),
              );
            }
          }),
        ],
      ),
      actions: [TCartCountericon(onPressed: () {}, iconColor: TColors.black)],
    );
  }
}
