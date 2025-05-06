import 'package:examenmobile/utils/constants/colors.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:examenmobile/utils/device/device_utility.dart';
import 'package:examenmobile/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key, required this.text, this.icon=Iconsax.search_normal,this.padding=const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace) , this.showBackground=true,  this.showBorder=true, this.onTap,
  });
  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final void Function()? onTap;
  final EdgeInsetsGeometry padding ;



  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: TDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
              color: showBackground ? darkMode ? TColors.dark : TColors.light: Colors.transparent ,
              borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
              border: showBorder? Border.all(color: TColors.grey) :null
          ),
          child: Row(
            children: [
              Icon(icon,color: TColors.darkerGrey),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text(text, style: Theme.of(context).textTheme.bodySmall)
            ],
          ),
        ),
      ),
    );
  }
}