import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examenmobile/data/repositories/authentification/authentification_repository.dart';
import 'package:examenmobile/models/card_item_model.dart';
import 'package:examenmobile/utils/exceptions/firebase_exceptions.dart';
import 'package:examenmobile/utils/exceptions/format_exceptions.dart';
import 'package:examenmobile/utils/exceptions/platform_exceptions.dart';
import 'package:examenmobile/utils/popups/loaders.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;
  final _authRepo = AuthenticationRepository.instance;

  // Observables
  final cartItems = <CartItemModel>[].obs;
  final isLoading = false.obs;
  final isItemAdding = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserCart();
  }

  /// Get user's cart collection reference
  String? get getUserId => _authRepo.authUser?.uid;

  /// Get cart collection reference
  CollectionReference<Map<String, dynamic>> get userCartCollection =>
      _db.collection('Users').doc(getUserId).collection('Cart');

  /// Calculate total number of items in cart
  int get totalCartItems => cartItems.fold(0, (sum, item) => sum + item.quantity);

  /// Calculate total price of items in cart
  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

  /// Fetch all cart items for current user
  Future<void> fetchUserCart() async {
    try {
      isLoading.value = true;

      if (getUserId == null) return;

      final snapshot = await userCartCollection.get();
      final items = snapshot.docs.map((doc) => CartItemModel.fromSnapshot(doc)).toList();

      cartItems.assignAll(items);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    } finally {
      isLoading.value = false;
    }
  }

  /// Add product to cart
  Future<void> addToCart(dynamic product, {int quantity = 1, String? variant}) async {
    try {
      isItemAdding.value = true;

      if (getUserId == null) {
        TLoaders.warningSnackBar(
          title: 'Not Logged In',
          message: 'Please login to add items to your cart',
        );
        return;
      }

      // Check if the product is already in cart
      final existingItem = cartItems.firstWhereOrNull(
            (item) => item.productId == product.id && item.variant == variant,
      );

      if (existingItem != null) {
        // Update quantity if product already exists
        await updateItemQuantity(existingItem.id, existingItem.quantity + quantity);
      } else {
        try {
          // Create new cart item
          final cartItemId = userCartCollection.doc().id;
          final cartItem = CartItemModel.fromProductModel(
            product,
            cartItemId: cartItemId,
            quantity: quantity,
            variant: variant,
          );

          // Add to Firestore
          await userCartCollection.doc(cartItemId).set(cartItem.toJson());

          // Add to local list
          cartItems.add(cartItem);

          TLoaders.successSnackBar(
            title: 'Added to Cart',
            message: '${product.title} has been added to your cart',
          );
        } catch (e) {
          print('Error creating cart item: $e');
          TLoaders.errorSnackBar(
            title: 'Error Adding to Cart',
            message: 'There was an issue with adding this product to your cart. Please try again.',
          );
        }
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print('Unexpected error in addToCart: $e');
      throw 'Something went wrong. Please try again';
    } finally {
      isItemAdding.value = false;
    }
  }

  /// Remove item from cart
  Future<void> removeFromCart(String cartItemId) async {
    try {
      if (getUserId == null) return;

      // Remove from Firestore
      await userCartCollection.doc(cartItemId).delete();

      // Remove from local list
      cartItems.removeWhere((item) => item.id == cartItemId);

      TLoaders.successSnackBar(
        title: 'Item Removed',
        message: 'Product has been removed from your cart',
      );
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Update item quantity
  Future<void> updateItemQuantity(String cartItemId, int newQuantity) async {
    try {
      if (getUserId == null) return;

      if (newQuantity < 1) {
        await removeFromCart(cartItemId);
        return;
      }

      // Update in Firestore
      await userCartCollection.doc(cartItemId).update({'quantity': newQuantity});

      // Update in local list
      final index = cartItems.indexWhere((item) => item.id == cartItemId);
      if (index != -1) {
        cartItems[index].quantity = newQuantity;
        cartItems.refresh();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Clear entire cart
  Future<void> clearCart() async {
    try {
      if (getUserId == null) return;

      // Get all documents in the cart collection
      final snapshots = await userCartCollection.get();

      // Create a batch write operation
      final batch = _db.batch();

      // Add delete operations for each document to the batch
      for (final doc in snapshots.docs) {
        batch.delete(doc.reference);
      }

      // Commit the batch
      await batch.commit();

      // Clear local list
      cartItems.clear();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}