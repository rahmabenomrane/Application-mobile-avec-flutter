import 'package:examenmobile/common/widgets/chips/choice_chip.dart';
import 'package:examenmobile/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:examenmobile/common/widgets/texts/product_price_text.dart';
import 'package:examenmobile/common/widgets/texts/product_title_text.dart';
import 'package:examenmobile/common/widgets/texts/section_heading.dart';
import 'package:examenmobile/utils/constants/colors.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:examenmobile/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Column(
      children: [
        /// -- Selected Attribute Pricing & Description
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Column(
            children: [
              /// Title, Price and Stock Status
              Row(
                children: [
                  const TSectionHeading(
                    title: 'Variation',
                    showActionButton: false,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const TProductTitleText(
                            title: 'Price : ',
                            smallSize: true,
                          ),

                          /// Actual Price
                          Text(
                            'DT25',
                            style: Theme.of(context).textTheme.titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),

                          /// Sale Price
                          const TProductPriceText(price: '20'),
                        ],
                      ),
                      Row(
                        children: [
                          const TProductTitleText(
                            title: 'Stock : ',
                            smallSize: true,
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              /// Variation Description
              const TProductTitleText(
                title: "this is a good red coat for cats and little puppies ",
                smallSize: true,
                maxLines: 4,
              ),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Colors',showActionButton: false,),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
           Wrap(
             spacing: 8,
             children: [
               TChoiceChip(text: 'Green', selected: true,onSelected: (value){}),
               TChoiceChip(text: 'Blue', selected: false,onSelected: (value){}),
               TChoiceChip(text: 'Yellow', selected: false,onSelected: (value){}),],
           )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Size',showActionButton: false),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
           Wrap(
             spacing: 8,
             children: [
               TChoiceChip(text: 'Small', selected: true,onSelected: (value){}),
               TChoiceChip(text: 'Medium', selected: false,onSelected: (value){}),
               TChoiceChip(text: 'Large', selected: false,onSelected: (value){}),
             ],
           )
          ],
        ),
      ],
    );
  }
}


