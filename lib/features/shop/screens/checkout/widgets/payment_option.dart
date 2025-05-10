import 'package:examenmobile/utils/constants/colors.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:examenmobile/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TPaymentOptions extends StatefulWidget {
  const TPaymentOptions({super.key});

  @override
  State<TPaymentOptions> createState() => _TPaymentOptionsState();
}

class _TPaymentOptionsState extends State<TPaymentOptions> {
  int selectedPaymentMethod = 0;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment Method', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: TSizes.spaceBtwItems),

        // Cash on Delivery Option
        PaymentMethodTile(
          isSelected: selectedPaymentMethod == 0,
          onTap: () => setState(() => selectedPaymentMethod = 0),
          title: 'Cash on Delivery',
          subtitle: 'Pay cash when your order arrives',
          icon: Icons.money_rounded,
          dark: dark,
        ),

        const SizedBox(height: TSizes.spaceBtwItems / 2),

        // Credit/Debit Card Option
        PaymentMethodTile(
          isSelected: selectedPaymentMethod == 1,
          onTap: () => setState(() => selectedPaymentMethod = 1),
          title: 'Credit/Debit Card',
          subtitle: 'Pay securely with your card',
          icon: Icons.credit_card,
          dark: dark,
        ),

        const SizedBox(height: TSizes.spaceBtwItems / 2),
      ],
    );
  }
}

class PaymentMethodTile extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool dark;

  const PaymentMethodTile({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.dark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(TSizes.md),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? TColors.primary.withOpacity(0.1)
                  : dark
                  ? TColors.dark
                  : TColors.white,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
          border: Border.all(
            color: isSelected ? TColors.primary : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? TColors.primary : null, size: 32),
            const SizedBox(width: TSizes.spaceBtwItems),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: isSelected ? FontWeight.bold : null,
                      color: isSelected ? TColors.primary : null,
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 4),
                  Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? TColors.primary : null,
            ),
          ],
        ),
      ),
    );
  }
}
