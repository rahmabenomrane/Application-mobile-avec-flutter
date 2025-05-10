import 'dart:developer' as console;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:examenmobile/features/shop/models/product_model.dart';
import 'package:examenmobile/utils/constants/colors.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagesController extends GetxController {
  // Méthode statique pour obtenir l'instance unique du contrôleur
  static ImagesController get instance => Get.find();

  /// Variables
  RxString selectedProductImage = ''.obs;

  /// Méthode pour récupérer toutes les images d'un produit et de ses variantes
  List<String> getAllProductImages(ProductModel product) {

    Set<String> images = {};


    images.add(product.thumbnail);
    console.log(product.thumbnail);

    // Assigner l'image  comme image sélectionnée
    selectedProductImage.value = product.thumbnail;


    if (product.images != null) {
      images.addAll(product.images!);
    }

    // Récupérer toutes les images des variantes du produit s'il en existe
    if (product.productVariations != null && product.productVariations!.isNotEmpty) {
      images.addAll(
        product.productVariations!.map((variation) => variation.image),
      );
    }


    return images.toList();
  }
  /// Affiche une image agrandie dans un dialogue plein écran
  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
          () => Dialog.fullscreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image Widget avec gestion des deux types d'images
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: TSizes.defaultSpace * 2,
                horizontal: TSizes.defaultSpace,
              ),
              child: image.startsWith('http')
                  ? CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.contain,
                progressIndicatorBuilder: (_, __, progress) =>
                    CircularProgressIndicator(
                      value: progress.progress,
                      color: TColors.primary,
                    ),
                errorWidget: (context, url, error) => _buildErrorWidget(),
              )
                  : Image.asset(
                image,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  child: const Text('Close'),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

}
Widget _buildErrorWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(Icons.error_outline, size: 50, color: Colors.red),
      const SizedBox(height: TSizes.spaceBtwItems),
      Text(
        'Failed to load image',
        style: Theme.of(Get.context!).textTheme.bodyLarge,
      ),
    ],
  );
}