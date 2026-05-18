// 📁 lib/features/cart/providers/cart_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/product_model.dart';

class CartItem {
  final Product product;
  final int quantity;

  const CartItem({required this.product, required this.quantity});

  CartItem copyWith({int? quantity}) =>
      CartItem(product: product, quantity: quantity ?? this.quantity);
}

final cartProvider = StateNotifierProvider<CartNotifier, Map<String, CartItem>>(
  (ref) {
    return CartNotifier();
  },
);

class CartNotifier extends StateNotifier<Map<String, CartItem>> {
  CartNotifier() : super({});

  void addItem(Product product) {
    if (state.containsKey(product.id)) {
      state = {
        ...state,
        product.id: state[product.id]!.copyWith(
          quantity: state[product.id]!.quantity + 1,
        ),
      };
    } else {
      state = {...state, product.id: CartItem(product: product, quantity: 1)};
    }
  }

  void removeItem(String productId) {
    if (!state.containsKey(productId)) return;
    final current = state[productId]!;
    if (current.quantity <= 1) {
      final newState = Map<String, CartItem>.from(state);
      newState.remove(productId);
      state = newState;
    } else {
      state = {
        ...state,
        productId: current.copyWith(quantity: current.quantity - 1),
      };
    }
  }

  void clearItem(String productId) {
    final newState = Map<String, CartItem>.from(state);
    newState.remove(productId);
    state = newState;
  }

  int getQuantity(String productId) => state[productId]?.quantity ?? 0;

  int get totalCount =>
      state.values.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice => state.values.fold(
    0,
    (sum, item) => sum + item.product.retailPrice * item.quantity,
  );
}
