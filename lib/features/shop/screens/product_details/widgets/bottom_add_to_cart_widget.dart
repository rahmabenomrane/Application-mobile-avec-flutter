import 'package:examenmobile/common/icons/t_circular_icon.dart';
import 'package:examenmobile/features/shop/controllers/cart/cart_controller.dart';
import 'package:examenmobile/features/shop/models/product_model.dart';
import 'package:examenmobile/utils/constants/colors.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:examenmobile/utils/helpers/helper_functions.dart';
import 'package:examenmobile/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({
    super.key,
    required this.product,
    this.quantity = 1,
  });

  final ProductModel product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(CartController.instance);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.defaultSpace,
        vertical: TSizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? TColors.darkerGrey : TColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Quantity Controls
          Row(
            children: [
              TCircularIcon(
                icon: Iconsax.minus,
                backgroundColor: TColors.darkerGrey,
                width: 40,
                height: 40,
                color: TColors.white,
                onPressed: () {
                  // TODO: Implémenter la réduction de quantité
                },
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text(quantity.toString(), style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width: TSizes.spaceBtwItems),
              TCircularIcon(
                icon: Iconsax.add,
                backgroundColor: TColors.black,
                width: 40,
                height: 40,
                color: TColors.white,
                onPressed: () {
                  // TODO: Implémenter l'augmentation de quantité
                },
              ),
            ],
          ),

          // Add to Cart Button
          Obx(
                () => ElevatedButton(
              onPressed: controller.isItemAdding.value
                  ? null
                  : () async {
                try {
                  await controller.addToCart(product, quantity: quantity);
                  TLoaders.successSnackBar(
                    title: 'Added to Cart',
                    message: '${product.title} has been added to your cart',
                  );
                } catch (e) {
                  TLoaders.errorSnackBar(
                    title: 'Error',
                    message: e.toString(),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: TColors.black,
                side: const BorderSide(color: TColors.black),
                disabledBackgroundColor: TColors.darkGrey,
              ),
              child: controller.isItemAdding.value
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: TColors.white,
                  strokeWidth: 2,
                ),
              )
                  : const Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}