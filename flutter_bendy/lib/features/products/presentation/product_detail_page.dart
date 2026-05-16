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
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.08),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Material(
                  color: isWishlisted
                      ? const Color(0xFFFFEBEE)
                      : const Color(0xFFE3F2FD),
                  shape: const CircleBorder(),
                  child: IconButton(
                    onPressed: () =>
                        ref.read(wishlistProvider.notifier).toggle(p.id),
                    icon: Icon(
                      isWishlisted
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: isWishlisted ? Colors.red : const Color(0xFF1565C0),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: cartQty == 0
                      ? ElevatedButton(
                          onPressed: () =>
                              ref.read(cartProvider.notifier).addItem(p),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1565C0),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Səbətə əlavə et',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        )
                      : Container(
                          height: 52,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3F2FD),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  fontSize: 18,
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
                ),
              ],
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 340,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.white,
            clipBehavior: Clip.antiAlias,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
            ),
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.92),
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
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.92),
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
                fit: StackFit.expand,
                children: [
                  p.images.isNotEmpty
                      ? GestureDetector(
                          onTap: () => _openImageGallery(context),
                          child: PageView.builder(
                            controller: _imageCtrl,
                            scrollDirection: Axis.horizontal,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: p.images.length,
                            onPageChanged: (i) =>
                                setState(() => _currentImage = i),
                            itemBuilder: (_, i) => Image.network(
                              p.images[i],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  _gradientPlaceholder(),
                            ),
                          ),
                        )
                      : _gradientPlaceholder(),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color.fromRGBO(0, 0, 0, 0.28),
                        ],
                      ),
                    ),
                  ),
                  if (p.images.length > 1)
                    Positioned(
                      bottom: 18,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          p.images.length,
                          (i) => AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: _currentImage == i ? 18 : 6,
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
                  if (p.images.length > 1)
                    Positioned(
                      top: 60,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 0, 0, 0.45),
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

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          p.category,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1565C0),
                          ),
                        ),
                      ),
                      if (p.isDiscounted) ...[
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEBEE),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '-${p.discountPercent.toInt()}%',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFD32F2F),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    p.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (i) => Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Icon(
                            i < p.rating.floor()
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            color: const Color(0xFFFFC107),
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${p.rating} · ${p.reviewCount} rəylər',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _PriceToggle(
                    product: p,
                    showWholesale: _showWholesale,
                    onToggle: (v) => setState(() => _showWholesale = v),
                  ),
                  const SizedBox(height: 20),
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Məhsul haqqında',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            p.description.isEmpty
                                ? 'Məhsul haqqında məlumat mövcud deyil.'
                                : p.description,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                              height: 1.7,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openImageGallery(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => _FullScreenImageGallery(
        images: p.images,
        initialIndex: _currentImage,
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
          color: const Color.fromRGBO(255, 255, 255, 0.25),
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
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
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
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: active ? Colors.transparent : const Color(0xFFCED7EB),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: active ? FontWeight.w700 : FontWeight.w600,
              color: active ? const Color(0xFF1565C0) : const Color(0xFF6F7590),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Full-screen image gallery ────────────────────────────────────────────────

class _FullScreenImageGallery extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _FullScreenImageGallery({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_FullScreenImageGallery> createState() =>
      _FullScreenImageGalleryState();
}

class _FullScreenImageGalleryState extends State<_FullScreenImageGallery> {
  late PageController _pageCtrl;
  late int _currentIdx;

  @override
  void initState() {
    super.initState();
    _currentIdx = widget.initialIndex;
    _pageCtrl = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                color: Colors.black.withValues(alpha: 0.95),
              ),
            ),
          ),
          Positioned.fill(
            child: PageView.builder(
              controller: _pageCtrl,
              onPageChanged: (idx) => setState(() => _currentIdx = idx),
              itemCount: widget.images.length,
              itemBuilder: (_, idx) => InteractiveViewer(
                minScale: 1.0,
                maxScale: 4.0,
                child: Image.network(
                  widget.images[idx],
                  fit: BoxFit.contain,
                  errorBuilder: (ctx, err, stack) => Center(
                    child: Icon(
                      Icons.image_not_supported_rounded,
                      color: Colors.white.withValues(alpha: 0.5),
                      size: 60,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
          if (widget.images.length > 1)
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${_currentIdx + 1}/${widget.images.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
