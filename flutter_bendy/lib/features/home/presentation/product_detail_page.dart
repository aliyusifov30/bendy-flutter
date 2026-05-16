// 📁 lib/features/home/presentation/product_detail_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/product_model.dart';
import '../../../core/providers/providers.dart';

class ProductDetailPage extends ConsumerStatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  int _currentImage = 0;
  final PageController _imageCtrl = PageController();
  bool _showWholesale = false;

  Product get p => widget.product;

  @override
  void dispose() {
    _imageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWishlisted = ref.watch(wishlistProvider).contains(p.id);
    final cartQty =
        ref.watch(cartProvider.select((c) => c[p.id]?.quantity ?? 0));

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: CustomScrollView(
        slivers: [
          // ── Image Header (SliverAppBar) ──────────────────────────────
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded,
                    size: 18, color: Color(0xFF1565C0)),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () =>
                    ref.read(wishlistProvider.notifier).toggle(p.id),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isWishlisted
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    size: 20,
                    color: isWishlisted ? Colors.red : const Color(0xFF1565C0),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // ── Image carousel ─────────────────────────────────
                  p.images.isNotEmpty
                      ? PageView.builder(
                          controller: _imageCtrl,
                          itemCount: p.images.length,
                          onPageChanged: (i) =>
                              setState(() => _currentImage = i),
                          itemBuilder: (_, i) => Image.network(
                            p.images[i],
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _gradientPlaceholder(),
                          ),
                        )
                      : _gradientPlaceholder(),

                  // ── Dots ───────────────────────────────────────────
                  if (p.images.length > 1)
                    Positioned(
                      bottom: 12,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          p.images.length,
                          (i) => AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: _currentImage == i ? 20 : 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: _currentImage == i
                                  ? Colors.white
                                  : Colors.white54,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),

                  // ── Image count indicator ──────────────────────────
                  if (p.images.length > 1)
                    Positioned(
                      top: 60,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${_currentImage + 1}/${p.images.length}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // ── Content ───────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      p.category,
                      style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF1565C0),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Name
                  Text(
                    p.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Rating
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (i) => Icon(
                          i < p.rating.floor()
                              ? Icons.star_rounded
                              : Icons.star_border_rounded,
                          color: const Color(0xFFFFC107),
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${p.rating} (${p.reviewCount} rəy)',
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // ── Price toggle ──────────────────────────────────
                  _PriceToggle(
                    product: p,
                    showWholesale: _showWholesale,
                    onToggle: (v) => setState(() => _showWholesale = v),
                  ),
                  const SizedBox(height: 20),

                  // ── Description ───────────────────────────────────
                  const Text(
                    'Məhsul haqqında',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    p.description.isEmpty
                        ? 'Məhsul haqqında məlumat mövcud deyil.'
                        : p.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // ── Add to cart ───────────────────────────────────
                  cartQty == 0
                      ? SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton.icon(
                            onPressed: () => ref
                                .read(cartProvider.notifier)
                                .addItem(p),
                            icon: const Icon(Icons.shopping_cart_rounded),
                            label: const Text(
                              'Səbətə əlavə et',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1565C0),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3F2FD),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () => ref
                                    .read(cartProvider.notifier)
                                    .removeItem(p.id),
                                icon: const Icon(Icons.remove_rounded,
                                    color: Color(0xFF1565C0)),
                              ),
                              Text(
                                '$cartQty',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1565C0),
                                ),
                              ),
                              IconButton(
                                onPressed: () =>
                                    ref.read(cartProvider.notifier).addItem(p),
                                icon: const Icon(Icons.add_rounded,
                                    color: Color(0xFF1565C0)),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _gradientPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: p.gradientColors,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.build_circle_outlined,
          size: 90,
          color: Colors.white.withOpacity(0.25),
        ),
      ),
    );
  }
}

// ── Price toggle widget ───────────────────────────────────────────────────────

class _PriceToggle extends StatelessWidget {
  final Product product;
  final bool showWholesale;
  final ValueChanged<bool> onToggle;

  const _PriceToggle({
    required this.product,
    required this.showWholesale,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [
          // Toggle tabs
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                _Tab(
                  label: 'Pərakəndə',
                  active: !showWholesale,
                  onTap: () => onToggle(false),
                ),
                _Tab(
                  label: 'Topdan',
                  active: showWholesale,
                  onTap: () => onToggle(true),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Price display
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                showWholesale
                    ? '₼${product.wholesalePrice.toStringAsFixed(2)}'
                    : '₼${product.retailPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: showWholesale
                      ? const Color(0xFF2E7D32)
                      : const Color(0xFF1565C0),
                ),
              ),
              if (product.isDiscounted && !showWholesale) ...[
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    '₼${product.originalPrice!.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFFAAAAAA),
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '-${product.discountPercent.toInt()}%',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(
            showWholesale
                ? 'Minimum sifariş məbləği satıcı ilə razılaşdırılır'
                : 'Pərakəndə qiymət (vahid üçün)',
            style: TextStyle(fontSize: 11, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _Tab(
      {required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(3),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: active
                ? [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 6)
                  ]
                : [],
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight:
                  active ? FontWeight.w700 : FontWeight.w500,
              color: active
                  ? const Color(0xFF1565C0)
                  : const Color(0xFF888899),
            ),
          ),
        ),
      ),
    );
  }
}
