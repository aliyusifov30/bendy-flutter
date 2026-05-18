// 📁 lib/core/providers/providers.dart

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';
import '../repositories/product_repository.dart';
import 'dart:io';
import 'package:dio/io.dart';
// ── Dio ───────────────────────────────────────────────────────────────────────

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://10.0.2.2:7166/api/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

  return dio;
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
    FutureProvider.family<
      List<Product>,
      ({String? categoryId, String? subCategoryId})
    >((ref, params) async {
      return ref
          .watch(productRepositoryProvider)
          .getProducts(
            categoryId: params.categoryId,
            subCategoryId: params.subCategoryId,
          );
    });

// ── Categories ────────────────────────────────────────────────────────────────

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final list = await ref.watch(productRepositoryProvider).getCategories();
  list.sort((a, b) => a.order.compareTo(b.order));
  return list;
});

// Selected category / subcategory state
final selectedCategoryIdProvider = StateProvider<String?>((ref) => null);
final selectedSubCategoryIdProvider = StateProvider<String?>((ref) => null);

// Fetch subcategories for a given categoryId, filter active and sort by order
final subcategoriesProvider = FutureProvider.family<List<SubCategory>, String>((
  ref,
  categoryId,
) async {
  final subs = await ref
      .watch(productRepositoryProvider)
      .getSubCategories(categoryId);
  final filtered = subs.where((s) => s.isActive).toList()
    ..sort((a, b) => a.order.compareTo(b.order));
  return filtered;
});

// ── Cart ──────────────────────────────────────────────────────────────────────

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

  void addItem(Product p) {
    state = state.containsKey(p.id)
        ? {
            ...state,
            p.id: state[p.id]!.copyWith(quantity: state[p.id]!.quantity + 1),
          }
        : {...state, p.id: CartItem(product: p, quantity: 1)};
  }

  void removeItem(String id) {
    if (!state.containsKey(id)) return;
    if (state[id]!.quantity <= 1) {
      final s = Map<String, CartItem>.from(state)..remove(id);
      state = s;
    } else {
      state = {
        ...state,
        id: state[id]!.copyWith(quantity: state[id]!.quantity - 1),
      };
    }
  }

  void clearItem(String id) {
    final s = Map<String, CartItem>.from(state)..remove(id);
    state = s;
  }

  int qty(String id) => state[id]?.quantity ?? 0;

  int get totalCount => state.values.fold(0, (s, i) => s + i.quantity);

  double get totalPrice =>
      state.values.fold(0, (s, i) => s + i.product.retailPrice * i.quantity);
}

// ── Wishlist ──────────────────────────────────────────────────────────────────

final wishlistProvider = StateNotifierProvider<WishlistNotifier, Set<String>>((
  ref,
) {
  return WishlistNotifier();
});

class WishlistNotifier extends StateNotifier<Set<String>> {
  WishlistNotifier() : super({});

  void toggle(String id) {
    state = state.contains(id) ? (Set.from(state)..remove(id)) : {...state, id};
  }

  bool has(String id) => state.contains(id);
}
