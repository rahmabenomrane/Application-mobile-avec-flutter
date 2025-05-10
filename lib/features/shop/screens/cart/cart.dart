import 'package:examenmobile/common/widgets/appbar/appbar.dart';
import 'package:examenmobile/features/shop/controllers/cart/cart_controller.dart';
import 'package:examenmobile/features/shop/screens/cart/widgets/card_items.dart';
import 'package:examenmobile/features/shop/screens/checkout/checkout.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:examenmobile/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());

    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall)
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: const TCartItems(showAddRemoveButtons: true),
      ),

      // Checkout Button with dynamic pricing
      bottomNavigationBar: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: ElevatedButton(
            onPressed: controller.cartItems.isEmpty
                ? null
                : () {
              try {
                Get.to(() => const CheckoutScreen());
              } catch (e) {
                TLoaders.errorSnackBar(title: 'Error', message: e.toString());
              }
            },
            child: Text(
                controller.cartItems.isEmpty
                    ? 'Your Cart is Empty'
                    : 'Checkout \$${controller.totalPrice.toStringAsFixed(2)}'
            ),
          ),
        );
      }),
    );
  }
}