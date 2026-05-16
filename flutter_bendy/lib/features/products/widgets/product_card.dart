// 📁 lib/features/home/presentation/widgets/product_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/product_model.dart';
import '../../../../core/providers/providers.dart';
import '../../home/presentation/product_detail_page.dart';

class ProductCard extends ConsumerWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWishlisted = ref.watch(wishlistProvider).contains(product.id);
    final cartQty = ref.watch(
      cartProvider.select((c) => c[product.id]?.quantity ?? 0),
    );

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductDetailPage(product: product),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image / Gradient ──────────────────────────────────────
            Stack(
              children: [
                _buildImage(),
                if (product.isDiscounted)
                  _badge('-${product.discountPercent.toInt()}%', Colors.red,
                      topLeft: true),
                if (product.isBestSeller && !product.isDiscounted)
                  _badge('🔥 Top', const Color(0xFFFF8F00), topLeft: true),
                // Wishlist heart
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () =>
                        ref.read(wishlistProvider.notifier).toggle(product.id),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isWishlisted
                            ? Colors.red.withOpacity(0.12)
                            : Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                          )
                        ],
                      ),
                      child: Icon(
                        isWishlisted
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: isWishlisted ? Colors.red : Colors.grey[400],
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ── Info ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A2E),
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          size: 13, color: Color(0xFFFFC107)),
                      const SizedBox(width: 2),
                      Text('${product.rating}',
                          style:
                              TextStyle(fontSize: 11, color: Colors.grey[600])),
                      Text(' (${product.reviewCount})',
                          style:
                              TextStyle(fontSize: 11, color: Colors.grey[400])),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // ── Dual pricing ────────────────────────────────────
                  _PriceColumn(product: product),
                  const SizedBox(height: 8),

                  // ── Cart button / counter ───────────────────────────
                  cartQty == 0
                      ? SizedBox(
                          width: double.infinity,
                          height: 34,
                          child: ElevatedButton(
                            onPressed: () =>
                                ref.read(cartProvider.notifier).addItem(product),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1565C0),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Səbətə əlavə et',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _CountBtn(
                              onTap: () => ref
                                  .read(cartProvider.notifier)
                                  .removeItem(product.id),
                              icon: Icons.remove,
                              filled: false,
                            ),
                            Text('$cartQty',
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1565C0))),
                            _CountBtn(
                              onTap: () => ref
                                  .read(cartProvider.notifier)
                                  .addItem(product),
                              icon: Icons.add,
                              filled: true,
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: SizedBox(
        height: 130,
        width: double.infinity,
        child: Image.network(
          product.posterImage,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _gradientBox(),
        ),
      ),
    );
  }

  Widget _gradientBox() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: product.gradientColors,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.build_circle_outlined,
          color: Colors.white.withOpacity(0.35),
          size: 48,
        ),
      ),
    );
  }

  Widget _badge(String text, Color color, {bool topLeft = false}) {
    return Positioned(
      top: 8,
      left: topLeft ? 8 : null,
      right: topLeft ? null : 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}

// ── Price display ─────────────────────────────────────────────────────────────

class _PriceColumn extends StatelessWidget {
  final Product product;
  const _PriceColumn({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pərakəndə
        Row(
          children: [
            const Text('Pər: ',
                style: TextStyle(fontSize: 10, color: Color(0xFF888899))),
            Text(
              '₼${product.retailPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1565C0),
              ),
            ),
            if (product.isDiscounted) ...[
              const SizedBox(width: 4),
              Text(
                '₼${product.originalPrice!.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFFAAAAAA),
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 2),
        // Topdan
        Row(
          children: [
            const Text('Top: ',
                style: TextStyle(fontSize: 10, color: Color(0xFF888899))),
            Text(
              '₼${product.wholesalePrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2E7D32),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Counter button ────────────────────────────────────────────────────────────

class _CountBtn extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final bool filled;
  const _CountBtn({required this.onTap, required this.icon, required this.filled});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: filled
              ? const Color(0xFF1565C0)
              : const Color(0xFFE3F2FD),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Icon(icon,
            size: 16,
            color: filled ? Colors.white : const Color(0xFF1565C0)),
      ),
    );
  }
}
