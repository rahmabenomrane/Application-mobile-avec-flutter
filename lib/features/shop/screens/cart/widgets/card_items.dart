import 'package:examenmobile/common/widgets/products.cart/add_remove_button.dart';
import 'package:examenmobile/common/widgets/products.cart/cart_item.dart';
import 'package:examenmobile/common/widgets/texts/product_price_text.dart';
import 'package:examenmobile/features/shop/controllers/cart/cart_controller.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:examenmobile/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    required this.showAddRemoveButtons,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());

    return Obx(() {
      // Show loader while loading cart items
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      // Show empty message if cart is empty
      if (controller.cartItems.isEmpty) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart_outlined, size: 80),
              SizedBox(height: TSizes.spaceBtwItems),
              Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: TSizes.spaceBtwItems),
              Text('Add items to your cart to see them here'),
            ],
          ),
        );
      }

      // Show cart items
      return ListView.separated(
        shrinkWrap: true,
        itemCount: controller.cartItems.length,
        separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwSections),
        itemBuilder: (_, index) {
          final item = controller.cartItems[index];
          return Column(
            children: [
              /// Cart Item
              TCartItem(cartItem: item),

              if (showAddRemoveButtons) const SizedBox(height: TSizes.spaceBtwItems),

              /// Add Remove Button Row with total Price
              if (showAddRemoveButtons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        /// Extra Space
                        const SizedBox(width: 70),

                        /// Add Remove Buttons
                        TProductQuantityWithAddRemoveButton(
                          quantity: item.quantity,
                          onIncrement: () async {
                            try {
                              await controller.updateItemQuantity(item.id, item.quantity + 1);
                            } catch (e) {
                              TLoaders.errorSnackBar(title: 'Error', message: e.toString());
                            }
                          },
                          onDecrement: () async {
                            try {
                              if (item.quantity > 1) {
                                await controller.updateItemQuantity(item.id, item.quantity - 1);
                              } else {
                                await controller.removeFromCart(item.id);
                              }
                            } catch (e) {
                              TLoaders.errorSnackBar(title: 'Error', message: e.toString());
                            }
                          },
                        ),
                      ],
                    ),

                    /// -- Product total price
                    TProductPriceText(price: item.totalPrice.toString()),
                  ],
                ),
            ],
          );
        },
      );
    });
  }
}