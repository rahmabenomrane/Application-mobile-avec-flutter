import 'package:examenmobile/common/brands/t_brand_card.dart';
import 'package:examenmobile/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:examenmobile/utils/constants/colors.dart';
import 'package:examenmobile/utils/constants/image_strings.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:examenmobile/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TBrandShowcase extends StatelessWidget {
  const TBrandShowcase({
    super.key,
    required this.images,
  });

  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.md),
        showBorder: true,
        borderColor: TColors.darkerGrey,
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        child: Column(
            children: [
              //brand with product count
              const TBrandCard(showBorder: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              //brand top3 prod img
              Row(
                  children:
                  images.map((image) => brandTopProductWidget(image, context)).toList()),
            ]
        )

    );
  }
  Widget brandTopProductWidget(String image, BuildContext context) {
    return Expanded(
      child: TRoundedContainer(
        height: 100,
        padding: const EdgeInsets.all(TSizes.md),
        margin: const EdgeInsets.only(right: TSizes.sm),
        backgroundColor: THelperFunctions.isDarkMode(context)
            ? TColors.darkerGrey
            : TColors.light,
        child: Image(
          fit: BoxFit.contain,
          image: AssetImage(image),
        ),
      ),
    );
  }
}

