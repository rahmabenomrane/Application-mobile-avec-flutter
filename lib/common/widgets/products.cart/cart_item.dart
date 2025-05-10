import 'package:examenmobile/common/widgets/images/t_rounded_image.dart';
import 'package:examenmobile/common/widgets/texts/product_title_text.dart';
import 'package:examenmobile/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:examenmobile/features/shop/controllers/cart/cart_controller.dart';
import 'package:examenmobile/models/card_item_model.dart';
import 'package:examenmobile/utils/constants/colors.dart';
import 'package:examenmobile/utils/constants/image_strings.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:examenmobile/utils/helpers/helper_functions.dart';
import 'package:examenmobile/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TCartItem extends StatelessWidget {
  final CartItemModel cartItem;

  const TCartItem({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();
    final dark = THelperFunctions.isDarkMode(context);

    return Dismissible(
      key: Key(cartItem.id),
      background: Container(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.7),
          borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
        ),
        child: const Icon(Iconsax.trash, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) async {
        try {
          await controller.removeFromCart(cartItem.id);
        } catch (e) {
          TLoaders.errorSnackBar(title: 'Error', message: e.toString());
          // Recreate the item in the list
          controller.fetchUserCart();
        }
      },
      child: Row(
        children: [
          /// Image
          TRoundedImage(
            imageUrl: cartItem.thumbnail ?? TImages.productImage78,
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: dark ? TColors.darkerGrey : TColors.light,
          ),
          const SizedBox(width: TSizes.spaceBtwItems),

          /// Title, Price, & Size
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TBrandTitleWithVerifiedIcon(title: cartItem.brandName),
                Flexible(
                  child: TProductTitleText(
                    title: cartItem.title,
                    maxLines: 1,
                  ),
                ),

                /// Attributes
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: cartItem.variant ?? 'No Variant',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}