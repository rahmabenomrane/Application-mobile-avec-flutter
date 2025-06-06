import 'package:examenmobile/common/widgets/appbar/appbar.dart';
import 'package:examenmobile/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:examenmobile/common/widgets/products.cart/coupon_widget.dart';
import 'package:examenmobile/common/widgets/success_screen/success_screen_two.dart';
import 'package:examenmobile/features/shop/controllers/cart/cart_controller.dart';
import 'package:examenmobile/features/shop/screens/cart/widgets/card_items.dart';
import 'package:examenmobile/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:examenmobile/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:examenmobile/features/shop/screens/checkout/widgets/billing_paymet_section.dart';
import 'package:examenmobile/navigation_menu.dart';
import 'package:examenmobile/utils/constants/colors.dart';
import 'package:examenmobile/utils/constants/image_strings.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:examenmobile/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cartController = CartController.instance;

    // Constants for shipping and tax rates
    const shippingFee = 6.0;
    const taxRate = 0.05; // 5% tax

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Items in Cart
            const TCartItems(showAddRemoveButtons: false),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// -- Coupon TextField
            TCouponCode(),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// -- Billing Section
            TRoundedContainer(
              showBorder: true,
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: dark ? TColors.black : TColors.white,
              child: const Column(
                children: [
                  /// Pricing
                  TBillingAmountSection(),
                  SizedBox(height: TSizes.spaceBtwItems),

                  /// Divider
                  Divider(),
                  SizedBox(height: TSizes.spaceBtwItems),

                  /// Payment Methods
                  TBillingPaymentSection(),
                  SizedBox(height: TSizes.spaceBtwItems),

                  /// Address
                  TBillingAddressSection(),
                ],
              ),
            ),
          ],
        ),
      ),

      /// Checkout Button with dynamic total
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Obx(() {
          // Calculate total with tax and shipping
          final subtotal = cartController.totalPrice;
          final taxFee = subtotal * taxRate;
          final total = subtotal + shippingFee + taxFee;

          return ElevatedButton(
            onPressed: () => Get.to(() => SuccessScreenTwo(
              image: TImages.successfulPaymentIcon,
              title: "Payment Success!",
              subtitle: "Your items will be shipped soon",
              onPressed: () => Get.offAll(() => const NavigationMenu()),
            )),
            child: Text('Checkout ${total.toStringAsFixed(2)} DT'),
          );
        }),
      ),
    );
  }
}