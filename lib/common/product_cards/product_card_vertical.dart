import 'package:examenmobile/common/icons/t_circular_icon.dart';
import 'package:examenmobile/common/styles/shadows.dart';
import 'package:examenmobile/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:examenmobile/common/widgets/images/t_rounded_image.dart';
import 'package:examenmobile/common/widgets/texts/product_price_text.dart';
import 'package:examenmobile/common/widgets/texts/product_title_text.dart';
import 'package:examenmobile/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:examenmobile/features/shop/controllers/product/product_controller.dart';
import 'package:examenmobile/features/shop/models/product_model.dart';
import 'package:examenmobile/features/shop/screens/product_details/product_details.dart';
import 'package:examenmobile/utils/constants/colors.dart';
import 'package:examenmobile/utils/constants/enums.dart';
import 'package:examenmobile/utils/constants/image_strings.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:examenmobile/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController.instance);
    final salePercentage = controller.calculateSalePercentage(
      product.price,
      product.salePrice,
    );
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Container(
        width: 180,
        constraints: const BoxConstraints(maxHeight: 300),
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          color: dark ? TColors.darkerGrey : TColors.white,
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        ),
        child: Column(
          children: [
            /// Thumbnail Image
            TRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              //
              child: Stack(
                children: [
                  TRoundedImage(
                    imageUrl: product.thumbnail,
                    applyImageRadius: true,
                  ),

                  /// Sale Tag
                  Positioned(
                    top: 10,
                    child: TRoundedContainer(
                      radius: TSizes.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: EdgeInsets.symmetric(
                        horizontal: TSizes.sm,
                        vertical: TSizes.xs,
                      ),
                      child: Text(
                        '$salePercentage%',
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge!.apply(color: TColors.black),
                      ),
                    ),
                  ),

                  // Favourite Icon
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: TCircularIcon(
                      icon: Iconsax.heart,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: TSizes.spaceBtwItems / 2),

            /// Details
            Padding(
              padding: EdgeInsets.only(left: TSizes.sm),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TProductTitleText(title: product.title, smallSize: true),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    TBrandTitleWithVerifiedIcon(title: product.brand!.name),
                  ],
                ),
              ),
            ),
            Spacer(),

            ///price row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Price
                Flexible(
                  child: Column(
                    children: [
                      if (product.productType == ProductType.variable.toString() && product.salePrice> 0)
                        Padding(
                          padding: const EdgeInsets.only(left: TSizes.sm),
                          child: Text(product.price.toString(),style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough),),
                        ),

                      Padding(
                        padding: EdgeInsets.only(left: TSizes.sm),
                        child: TProductPriceText(price: controller.getProductPrice(product), isLarge: true),
                      ),
                    ],
                  ),
                ),

                // add to cart Button
                Container(
                  decoration: const BoxDecoration(
                    color: TColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(TSizes.cardRadiusMd),
                      bottomRight: Radius.circular(TSizes.productImageRadius),
                    ),
                  ),
                  child: const SizedBox(
                    width: TSizes.iconLg * 1.2,
                    height: TSizes.iconLg * 1.2,
                    child: Center(
                      child: Icon(Iconsax.add, color: TColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
