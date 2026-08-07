import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../models/cart_item.dart';

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() {
    return []; // Initial empty cart state
  }

  // Add product to cart (or increment quantity if it already exists)
  void addItem(Product product) {
    final existingIndex = state.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex >= 0) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == existingIndex)
            CartItem(product: state[i].product, quantity: state[i].quantity + 1)
          else
            state[i]
      ];
    } else {
      state = [...state, CartItem(product: product)];
    }
  }

  // Remove product from cart
  void removeItem(int productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  // Calculate total price
  double get totalAmount {
    return state.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  }
}

// Modern NotifierProvider syntax
final cartProvider = NotifierProvider<CartNotifier, List<CartItem>>(() {
  return CartNotifier();
});