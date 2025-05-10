import 'package:examenmobile/common/widgets/chips/choice_chip.dart';
import 'package:examenmobile/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:examenmobile/common/widgets/texts/product_price_text.dart';
import 'package:examenmobile/common/widgets/texts/product_title_text.dart';
import 'package:examenmobile/common/widgets/texts/section_heading.dart';
import 'package:examenmobile/features/shop/controllers/product/variation_controller.dart';
import 'package:examenmobile/features/shop/models/product_model.dart';
import 'package:examenmobile/utils/constants/colors.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:examenmobile/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    final controller = Get.put(VariationController());
    return Column(
      children: [
        /// -- Selected Attribute Pricing & Description
        /// if (controller.selectedVariation.value.id.isNotEmpty)
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
                            'DT${controller.getVariationPrice()}',
                            style: Theme.of(context).textTheme.titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),

                          /// Sale Price
                          TProductPriceText(
                            price: controller.getVariationPrice(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const TProductTitleText(
                            title: 'Stock : ',
                            smallSize: true,
                          ),
                          Text('${product.stock}'),
                          const SizedBox(width: TSizes.spaceBtwItems),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              /// Variation Description
              TProductTitleText(
                title: product.description ?? '',
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
          children:
              product.productAttributes!
                  .map(
                    (attribute) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TSectionHeading(
                          title: attribute.name ?? '',
                          showActionButton: false,
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems / 2),
                        Obx(
                          () => Wrap(
                            spacing: 8,
                            children:
                                attribute.values!.map((attributeValue) {
                                  final isSelected =
                                      controller.selectedAttributes[attribute
                                          .name] ==
                                      attributeValue;
                                  final available = controller
                                      .getAttributesAvailabilityInVariation(
                                        product.productVariations!,
                                        attribute.name!,
                                      )
                                      .contains(attributeValue);
                                  return TChoiceChip(
                                    text: attributeValue,
                                    selected: isSelected,
                                    onSelected:
                                        available
                                            ? (selected) {
                                              if (selected && available) {
                                                controller.onAttributeSelected(
                                                  product,
                                                  attribute.name ?? '',
                                                  attributeValue,
                                                );
                                              }
                                            }
                                            : null,
                                  );
                                }).toList(),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}
