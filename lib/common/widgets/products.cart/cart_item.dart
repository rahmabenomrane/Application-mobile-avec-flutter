import 'package:examenmobile/common/widgets/images/t_rounded_image.dart';
import 'package:examenmobile/common/widgets/texts/product_title_text.dart';
import 'package:examenmobile/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:examenmobile/utils/constants/colors.dart';
import 'package:examenmobile/utils/constants/image_strings.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:examenmobile/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Image
        TRoundedImage(
          imageUrl: TImages.productImage78,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkerGrey
              : TColors.light,
        ),

        const SizedBox(width: TSizes.spaceBtwItems),

        /// Title, Price, & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TBrandTitleWithVerifiedIcon(title: 'OWNAT'),
              const Flexible(
                child: TProductTitleText(
                  title: 'OWNAT JUST GF',
                  maxLines: 1,
                ),
              ),

              /// Attributes
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Adulte Poulet ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
