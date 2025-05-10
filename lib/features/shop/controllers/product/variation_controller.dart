import 'package:examenmobile/features/shop/controllers/product/images_controller.dart';
import 'package:examenmobile/features/shop/models/product_model.dart';
import 'package:examenmobile/features/shop/models/product_variation_model.dart';
import 'package:get/get.dart';

class VariationController extends GetxController {
  // Méthode statique pour obtenir l'instance unique du contrôleur
  static VariationController get instance => Get.find();

  /// Variables
  RxMap selectedAttributes = {}.obs; // Stocke les attributs sélectionnés
  RxString variationStockStatus =
      ''.obs; // Stocke le statut de stock de la variation
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs; // Stocke la variation sélectionnée

  /// -- Sélection d'un attribut et d'une variation
  void onAttributeSelected(
    ProductModel product,
    attributeName,
    attributeValue,
  ) {
    final selectedAttributes = Map<String, dynamic>.from(
      this.selectedAttributes,
    );
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;
    final selectedVariation = product.productVariations!.firstWhere(
      (variation) =>
          _isSameAttributeValues(variation.attributeValues, selectedAttributes),
      orElse: () => ProductVariationModel.empty(),
    );
    if (selectedVariation.image.isNotEmpty) {
      ImagesController.instance.selectedProductImage.value =
          selectedVariation.image;
    }
    this.selectedVariation.value = selectedVariation;
    getProductVariationStockStatus();
  }

  bool _isSameAttributeValues(
    Map<String, dynamic> variationAttributes,
    Map<String, dynamic> selectedAttributes,
  ) {
    if (variationAttributes.length != selectedAttributes.length) {
      return false;
    }
    for (final key in variationAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes[key]) {
        return false;
      }
    }
    return true;
  }

  /// -- Vérifier la disponibilité des attributs dans une variation
  Set<String?> getAttributesAvailabilityInVariation(
    List<ProductVariationModel> variations,
    String attributeName,
  ) {
    final availableVariationAttributesValues =
        variations
            .where(
              (variation) =>
                  variation.attributeValues[attributeName] != null &&
                  variation.attributeValues[attributeName]!.isNotEmpty &&
                  variation.stock > 0,
            )
            .map((variation) => variation.attributeValues[attributeName])
            .toSet();
    return availableVariationAttributesValues;
  }

  String getVariationPrice() {
    return (selectedVariation.value.salePrice >0 ? selectedVariation.value.salePrice : selectedVariation.value.price).toString();
  }

  /// -- Vérifier le statut de stock de la variation sélectionnée
  void getProductVariationStockStatus() {
    // Met à jour le statut de stock en fonction de la quantité disponible
    variationStockStatus.value =
        selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  /// -- Réinitialiser les attributs sélectionnés lors du changement de produit
  void resetSelectedAttributes() {
    // Efface les attributs sélectionnés
    selectedAttributes.clear();
    // Réinitialise le statut de stock
    variationStockStatus.value = '';
    // Réinitialise la variation sélectionnée
    selectedVariation.value = ProductVariationModel.empty();
  }
}
