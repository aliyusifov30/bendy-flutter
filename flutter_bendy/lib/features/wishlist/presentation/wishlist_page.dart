// 📁 lib/features/wishlist/presentation/wishlist_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/providers.dart';
import '../../home/presentation/widgets/product_card.dart';

class WishlistPage extends ConsumerWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistIds = ref.watch(wishlistProvider);
    final productsAsync = ref.watch(allProductsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Sevimlilər',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A2E),
            fontSize: 20,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(color: const Color(0xFFE8E8E8), height: 0.5),
        ),
      ),
      body: productsAsync.when(
        data: (products) {
          final wishlistItems = products
              .where((p) => wishlistIds.contains(p.id))
              .toList();

          if (wishlistItems.isEmpty) {
            return _EmptyWishlist();
          }

          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Text(
                      '${wishlistItems.length} məhsul',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        for (final p in wishlistItems) {
                          ref.read(wishlistProvider.notifier).toggle(p.id);
                        }
                      },
                      child: const Text(
                        'Hamısını sil',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.68,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: wishlistItems.length,
                  itemBuilder: (_, i) => ProductCard(product: wishlistItems[i]),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(
              color: Color(0xFF1565C0), strokeWidth: 2),
        ),
        error: (error, _) => Center(
          child: Text(error.toString(), style: const TextStyle(color: Colors.red)),
        ),
      ),
    );
  }
}

class _EmptyWishlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.favorite_border_rounded,
              size: 52,
              color: Color(0xFF1565C0),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Sevimliləriniz yoxdur',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Məhsulların üzərindəki ♡ ikonuna\nbasaraq buraya əlavə edin',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
