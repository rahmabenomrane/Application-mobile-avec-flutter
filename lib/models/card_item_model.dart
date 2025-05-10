import 'package:cloud_firestore/cloud_firestore.dart';

/// Model class for items in a user's shopping cart.
class CartItemModel {
  final String id;
  final String productId;
  final String title;
  final String? thumbnail;
  final String brandName;
  final double price;
  final String? variant;
  int quantity;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.title,
    this.thumbnail,
    required this.brandName,
    required this.price,
    this.variant,
    required this.quantity,
  });

  /// Convert model to JSON for storing in Firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'title': title,
      'thumbnail': thumbnail,
      'brandName': brandName,
      'price': price,
      'variant': variant,
      'quantity': quantity,
    };
  }

  /// Create cart item from Firebase document snapshot
  factory CartItemModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return CartItemModel(
      id: document.id,
      productId: data['productId'] ?? '',
      title: data['title'] ?? '',
      thumbnail: data['thumbnail'],
      brandName: data['brandName'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      variant: data['variant'],
      quantity: data['quantity'] ?? 1,
    );
  }

  /// Create cart item from a Product model with a specific quantity
  factory CartItemModel.fromProductModel(
      dynamic product, {
        required String cartItemId,
        required int quantity,
        String? variant,
      }) {
    // Get the brand name safely - handle both string and map cases
    String getBrandName() {
      if (product.brand == null) {
        return '';
      } else if (product.brand is String) {
        return product.brand;
      } else if (product.brand is Map || product.brand is Map<String, dynamic>) {
        // If brand is a map, try to get the Name property
        return product.brand['Name'] ?? '';
      } else {
        return '';
      }
    }

    return CartItemModel(
      id: cartItemId,
      productId: product.id,
      title: product.title,
      thumbnail: product.thumbnail,
      brandName: getBrandName(),
      price: product.price.toDouble(),  // Ensure price is a double
      variant: variant,
      quantity: quantity,
    );
  }

  /// Calculate the total price for this cart item (price * quantity)
  double get totalPrice => price * quantity;
}