// 📁 lib/features/wishlist/providers/wishlist_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishlistProvider = StateNotifierProvider<WishlistNotifier, Set<String>>((
  ref,
) {
  return WishlistNotifier();
});

class WishlistNotifier extends StateNotifier<Set<String>> {
  WishlistNotifier() : super({});

  void toggle(String productId) {
    if (state.contains(productId)) {
      state = Set.from(state)..remove(productId);
    } else {
      state = {...state, productId};
    }
  }

  bool isWishlisted(String productId) => state.contains(productId);
}
