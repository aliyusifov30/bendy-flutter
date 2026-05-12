// 📁 lib/features/wishlist/providers/wishlist_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishlistProvider =
    StateNotifierProvider<WishlistNotifier, Set<int>>((ref) {
  return WishlistNotifier();
});

class WishlistNotifier extends StateNotifier<Set<int>> {
  WishlistNotifier() : super({});

  void toggle(int productId) {
    if (state.contains(productId)) {
      state = Set.from(state)..remove(productId);
    } else {
      state = {...state, productId};
    }
  }

  bool isWishlisted(int productId) => state.contains(productId);
}
