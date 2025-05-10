import 'package:examenmobile/features/shop/controllers/cart/cart_controller.dart';
import 'package:examenmobile/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';  // If you're using Lottie animations

class SuccessScreenTwo extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  const SuccessScreenTwo({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Make sure cart is cleared on screen build
    _ensureCartIsCleared();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              // Image or Lottie animation
              Image.asset(image, width: 200),
              const SizedBox(height: 30),
              // Title
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              // Subtitle
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Make sure cart is cleared before navigating
                    _ensureCartIsCleared();
                    Get.offAll(() => const NavigationMenu());
                  },
                  child: const Text('Continue Shopping'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to ensure cart is cleared
  void _ensureCartIsCleared() {
    try {
      final cartController = CartController.instance;
      // Only clear if there are items
      if (cartController.cartItems.isNotEmpty) {
        cartController.clearCart();
      }
    } catch (e) {
      print('Error clearing cart: $e');
    }
  }
}