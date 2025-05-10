import 'package:examenmobile/common/widgets/products.cart/add_remove_button.dart';
import 'package:examenmobile/common/widgets/products.cart/cart_item.dart';
import 'package:examenmobile/common/widgets/texts/product_price_text.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key, required this.showAddRemoveButtons,
  });
  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 2,
      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwSections),
      itemBuilder: (_, index) =>  Column(
        children: [
          /// Cart Item
          const TCartItem(),
          if (showAddRemoveButtons) const SizedBox(height: TSizes.spaceBtwItems),

          /// Add Remove Button Row with total Price
          if (showAddRemoveButtons) const  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  /// Extra Space
                  SizedBox(width: 70),

                  /// Add Remove Buttons
                  TProductQuantityWithAddRemoveButton(),
                ],
              ), // Row

              /// -- Product total price
              TProductPriceText(price: '256'),
            ],
          ), // Row
        ],
      ), // Column
    ); // ListView.separated
  }
}
