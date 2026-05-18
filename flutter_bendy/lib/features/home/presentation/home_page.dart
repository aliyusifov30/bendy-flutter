// 📁 lib/features/home/presentation/home_page.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/category_model.dart';
import '../../../core/models/product_model.dart';
import '../../../core/providers/providers.dart';
import 'widgets/product_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final PageController _bannerCtrl = PageController();
  int _currentBanner = 0;
  String? _selectedSubCat; // seçilmiş subcategory
  String? _selectedCategoryId; // seçilmiş kateqoriya
  Timer? _timer;

  final List<_BannerData> _banners = const [
    _BannerData(
      title: 'Professional Qaynaq\nAvadanlıqları',
      subtitle: 'Ən yüksək keyfiyyət, sübut edilmiş güvən',
      colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
      icon: Icons.build_rounded,
    ),
    _BannerData(
      title: 'Sürətli\nÇatdırılma',
      subtitle: 'Bütün Azərbaycana çatdırılma mövcuddur',
      colors: [Color(0xFF0D47A1), Color(0xFF26C6DA)],
      icon: Icons.local_shipping_rounded,
    ),
    _BannerData(
      title: 'Xüsusi\nEndirimlər',
      subtitle: 'Seçilmiş məhsullarda 30%-ə qədər endirim',
      colors: [Color(0xFFBF360C), Color(0xFFFF8A65)],
      icon: Icons.local_offer_rounded,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      final next = (_currentBanner + 1) % _banners.length;
      _bannerCtrl.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _bannerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBannerSlider(),
            const SizedBox(height: 22),
            // Categories temporarily disabled on the home page.
            // _buildCategorySection(),
            // const SizedBox(height: 22),
            /*
            if (_selectedCategoryId != null || _selectedSubCat != null)
              _buildProductSection(
                _selectedSubCat != null
                    ? 'Seçilmiş subkateqoriya məhsulları'
                    : 'Seçilmiş kateqoriya məhsulları',
                ref.watch(categoryProductsProvider((
                  categoryId: _selectedCategoryId,
                  subCategoryId: _selectedSubCat,
                ))),
              ),
            const SizedBox(height: 22),
            */
            _buildProductSection('Məhsullar', ref.watch(allProductsProvider)),
            const SizedBox(height: 22),
            _buildProductSection(
              'Çox Satılanlar 🔥',
              ref.watch(bestSellersProvider),
            ),
            const SizedBox(height: 22),
            _buildProductSection(
              'Endirimli Məhsullar 🏷️',
              ref.watch(discountedProvider),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ── AppBar ───────────────────────────────────────────────────────────────

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.5),
        child: Container(color: const Color(0xFFE8E8E8), height: 0.5),
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 30),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7FA),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE4E4E4)),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Icon(
                      Icons.search_rounded,
                      color: Colors.grey[400],
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Məhsul axtar...',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 4),
            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: Color(0xFF1565C0),
                    size: 24,
                  ),
                  onPressed: () {},
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Banner Slider ────────────────────────────────────────────────────────

  Widget _buildBannerSlider() {
    return Column(
      children: [
        SizedBox(
          height: 185,
          child: PageView.builder(
            controller: _bannerCtrl,
            itemCount: _banners.length,
            onPageChanged: (i) => setState(() => _currentBanner = i),
            itemBuilder: (_, i) {
              final b = _banners[i];
              return Padding(
                padding: EdgeInsets.only(
                  left: i == 0 ? 16 : 6,
                  right: i == _banners.length - 1 ? 16 : 6,
                  top: 16,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: LinearGradient(
                      colors: b.colors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -16,
                        bottom: -16,
                        child: Icon(
                          b.icon,
                          size: 140,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              b.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              b.subtitle,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.4),
                                ),
                              ),
                              child: const Text(
                                'Kəşfet →',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _banners.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _currentBanner == i ? 20 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _currentBanner == i
                    ? const Color(0xFF1565C0)
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Categories + Subcategories ───────────────────────────────────────────

  // ignore: unused_element
  Widget _buildCategorySection() {
    final categoriesAsync = ref.watch(categoriesProvider);

    return categoriesAsync.when(
      data: (cats) => _CategoriesSection(
        categories: cats,
        selectedCategoryId: _selectedCategoryId,
        selectedSubCat: _selectedSubCat,
        onCategorySelected: (id) => setState(() {
          if (_selectedCategoryId == id) {
            _selectedCategoryId = null;
            _selectedSubCat = null;
          } else {
            _selectedCategoryId = id;
            _selectedSubCat = null;
          }
        }),
        onSubCatSelected: (id) => setState(() {
          _selectedSubCat = _selectedSubCat == id ? null : id;
          if (_selectedSubCat != null) {
            final selectedCategory = cats.firstWhere(
              (category) => category.subCategories.any(
                (subCategory) => subCategory.id == _selectedSubCat,
              ),
            );
            _selectedCategoryId = selectedCategory.id;
          }
        }),
      ),
      loading: () => const SizedBox(
        height: 92,
        child: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF1565C0),
            strokeWidth: 2,
          ),
        ),
      ),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  // ── Product section ──────────────────────────────────────────────────────

  Widget _buildProductSection(
    String title,
    AsyncValue<List<Product>> productsAsync,
  ) {
    return productsAsync.when(
      data: (products) {
        if (products.isEmpty) return const SizedBox.shrink();
        final preview = products.length > 4 ? products.sublist(0, 4) : products;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Hamısı →',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF1565C0),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.63,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: preview.length,
              itemBuilder: (_, i) => ProductCard(product: preview[i]),
            ),
          ],
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF1565C0),
            strokeWidth: 2,
          ),
        ),
      ),
      error: (e, _) => Center(child: Text(e.toString())),
    );
  }
}

// ── Categories section widget ─────────────────────────────────────────────────

class _CategoriesSection extends StatefulWidget {
  final List<Category> categories;
  final String? selectedCategoryId;
  final String? selectedSubCat;
  final ValueChanged<String> onCategorySelected;
  final ValueChanged<String> onSubCatSelected;

  const _CategoriesSection({
    required this.categories,
    required this.selectedCategoryId,
    required this.selectedSubCat,
    required this.onCategorySelected,
    required this.onSubCatSelected,
  });

  @override
  State<_CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<_CategoriesSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Kateqoriyalar',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A2E),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // ── Category row ───────────────────────────────────────────
        SizedBox(
          height: 92,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
            itemCount: widget.categories.length,
            itemBuilder: (_, i) {
              final cat = widget.categories[i];
              final isExpanded = widget.selectedCategoryId == cat.id;

              return GestureDetector(
                onTap: () => widget.onCategorySelected(cat.id),
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  width: 78,
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: isExpanded
                              ? cat.color
                              : cat.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isExpanded
                                ? cat.color
                                : cat.color.withOpacity(0.2),
                          ),
                          boxShadow: isExpanded
                              ? [
                                  BoxShadow(
                                    color: cat.color.withOpacity(0.35),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : [],
                        ),
                        child: Icon(
                          cat.iconData,
                          color: isExpanded ? Colors.white : cat.color,
                          size: 26,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        cat.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: isExpanded
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: isExpanded
                              ? cat.color
                              : const Color(0xFF555566),
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // ── Subcategory chips ──────────────────────────────────────
        if (widget.selectedCategoryId != null) ...[
          const SizedBox(height: 10),
          () {
            final subs = widget.categories
                .firstWhere((c) => c.id == widget.selectedCategoryId)
                .subCategories;
            if (subs.isEmpty) return const SizedBox.shrink();
            final catColor = widget.categories
                .firstWhere((c) => c.id == widget.selectedCategoryId)
                .color;

            return SizedBox(
              height: 36,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                physics: const BouncingScrollPhysics(),
                itemCount: subs.length,
                itemBuilder: (_, i) {
                  final sub = subs[i];
                  final isSelected = widget.selectedSubCat == sub.id;

                  return GestureDetector(
                    onTap: () => widget.onSubCatSelected(sub.id),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? catColor : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected
                              ? catColor
                              : const Color(0xFFE4E4E4),
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: catColor.withOpacity(0.25),
                                  blurRadius: 6,
                                ),
                              ]
                            : [],
                      ),
                      child: Text(
                        sub.name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF555566),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }(),
        ],
      ],
    );
  }
}

// ── Banner data ───────────────────────────────────────────────────────────────

class _BannerData {
  final String title;
  final String subtitle;
  final List<Color> colors;
  final IconData icon;
  const _BannerData({
    required this.title,
    required this.subtitle,
    required this.colors,
    required this.icon,
  });
}
