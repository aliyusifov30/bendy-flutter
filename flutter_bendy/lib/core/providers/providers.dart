// 📁 lib/core/providers/providers.dart

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';
import '../repositories/product_repository.dart';

// ── Dio ───────────────────────────────────────────────────────────────────────

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'https://your-api.com/api/',   // ← API hazır olanda bura dəyiş
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );
});

// ── Repository ────────────────────────────────────────────────────────────────

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository(ref.watch(dioProvider));
});

// ── Products ──────────────────────────────────────────────────────────────────

final allProductsProvider = FutureProvider<List<Product>>((ref) async {
  return ref.watch(productRepositoryProvider).getProducts();
});

final bestSellersProvider = FutureProvider<List<Product>>((ref) async {
  return ref.watch(productRepositoryProvider).getBestSellers();
});

final discountedProvider = FutureProvider<List<Product>>((ref) async {
  return ref.watch(productRepositoryProvider).getDiscounted();
});

// Kateqoriyaya görə məhsullar
final categoryProductsProvider =
    FutureProvider.family<List<Product>, ({int? categoryId, int? subCategoryId})>(
        (ref, params) async {
  return ref.watch(productRepositoryProvider).getProducts(
        categoryId: params.categoryId,
        subCategoryId: params.subCategoryId,
      );
});

// ── Categories ────────────────────────────────────────────────────────────────

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  return ref.watch(productRepositoryProvider).getCategories();
});

// ── Cart ──────────────────────────────────────────────────────────────────────

class CartItem {
  final Product product;
  final int quantity;
  const CartItem({required this.product, required this.quantity});
  CartItem copyWith({int? quantity}) =>
      CartItem(product: product, quantity: quantity ?? this.quantity);
}

final cartProvider =
    StateNotifierProvider<CartNotifier, Map<int, CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<Map<int, CartItem>> {
  CartNotifier() : super({});

  void addItem(Product p) {
    state = state.containsKey(p.id)
        ? {...state, p.id: state[p.id]!.copyWith(quantity: state[p.id]!.quantity + 1)}
        : {...state, p.id: CartItem(product: p, quantity: 1)};
  }

  void removeItem(int id) {
    if (!state.containsKey(id)) return;
    if (state[id]!.quantity <= 1) {
      final s = Map<int, CartItem>.from(state)..remove(id);
      state = s;
    } else {
      state = {
        ...state,
        id: state[id]!.copyWith(quantity: state[id]!.quantity - 1)
      };
    }
  }

  void clearItem(int id) {
    final s = Map<int, CartItem>.from(state)..remove(id);
    state = s;
  }

  int qty(int id) => state[id]?.quantity ?? 0;

  int get totalCount =>
      state.values.fold(0, (s, i) => s + i.quantity);

  double get totalPrice =>
      state.values.fold(0, (s, i) => s + i.product.retailPrice * i.quantity);
}

// ── Wishlist ──────────────────────────────────────────────────────────────────

final wishlistProvider =
    StateNotifierProvider<WishlistNotifier, Set<int>>((ref) {
  return WishlistNotifier();
});

class WishlistNotifier extends StateNotifier<Set<int>> {
  WishlistNotifier() : super({});

  void toggle(int id) {
    state = state.contains(id)
        ? (Set.from(state)..remove(id))
        : {...state, id};
  }

  bool has(int id) => state.contains(id);
}
