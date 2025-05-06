import 'package:examenmobile/common/widgets/appbar/appbar.dart';
import 'package:examenmobile/common/widgets/products.cart/cart_menu_icon.dart';
import 'package:examenmobile/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:examenmobile/utils/constants/text_strings.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
          Text(
            TTexts.homeAppbarSubTitle,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.apply(color: TColors.white),
          ),
        ],
      ),
      actions: [TCartCountericon(onPressed: () {}, iconColor: TColors.black)],
    );
  }
}
