import 'package:flutter/material.dart';
import 'package:examenmobile/features/shop/controllers/cart/cart_controller.dart';
import 'package:get/get.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    // Constants for shipping and tax rates
    const shippingFee = 6.0;
    const taxRate = 0.05; // 5% tax

    return Obx(() {
      // Calculate values
      final subtotal = cartController.totalPrice;
      final taxFee = subtotal * taxRate;
      final total = subtotal + shippingFee + taxFee;

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
              Text('${subtotal.toStringAsFixed(2)} DT', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium),
              Text('${shippingFee.toStringAsFixed(2)} DT', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tax Fee (5%)', style: Theme.of(context).textTheme.bodyMedium),
              Text('${taxFee.toStringAsFixed(2)} DT', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order Total', style: Theme.of(context).textTheme.titleMedium),
              Text('${total.toStringAsFixed(2)} DT', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ],
      );
    });
  }
}