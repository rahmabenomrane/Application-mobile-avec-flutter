import 'package:examenmobile/features/shop/controllers/cart/cart_controller.dart';
import 'package:examenmobile/features/shop/screens/cart/cart.dart';
import 'package:examenmobile/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:get/get.dart';

class TCartCountericon extends StatelessWidget {
  const TCartCountericon({
    super.key,
    required this.onPressed,
    this.iconColor,
  });

  final VoidCallback onPressed;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    // Initialize cart controller to get cart items count
    final cartController = Get.put(CartController());

    return Obx(
          () => Stack(
        children: [
          // Cart Icon
          IconButton(
            onPressed: () => Get.to(() => const CartScreen()),
            icon: Icon(
              Iconsax.shopping_bag,
              color: iconColor,
            ),
          ),

          // Counter badge showing total quantity of items
          Positioned(
            right: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: TColors.black,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  '${cartController.totalCartItems}',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: TColors.white, fontSizeFactor: 0.8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}