// 📁 lib/features/home/presentation/home_page.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/data/mock_data.dart';
import '../../../core/models/product_model.dart';
import 'widgets/product_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final PageController _bannerCtrl = PageController();
  int _currentBanner = 0;
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

  final List<_CategoryData> _categories = const [
    _CategoryData(
        name: 'Elektrik\nAlətlər',
        icon: Icons.electrical_services_rounded,
        color: Color(0xFF1565C0)),
    _CategoryData(
        name: 'Batareya\nAlətlər',
        icon: Icons.battery_charging_full_rounded,
        color: Color(0xFF2E7D32)),
    _CategoryData(
        name: 'Qaynaq\nDəstləri',
        icon: Icons.hardware_rounded,
        color: Color(0xFFBF360C)),
    _CategoryData(
        name: 'Qoruyucu\nVasitə',
        icon: Icons.shield_rounded,
        color: Color(0xFF4A148C)),
    _CategoryData(
        name: 'Kəsici\nAlətlər',
        icon: Icons.content_cut_rounded,
        color: Color(0xFF006064)),
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
            _buildCategories(),
            const SizedBox(height: 22),
            _buildSection(
              title: 'Məhsullar',
              products: mockProducts,
            ),
            const SizedBox(height: 22),
            _buildSection(
              title: 'Çox Satılanlar 🔥',
              products: mockProducts.where((p) => p.isBestSeller).toList(),
            ),
            const SizedBox(height: 22),
            _buildSection(
              title: 'Endirimli Məhsullar 🏷️',
              products: mockProducts.where((p) => p.isDiscounted).toList(),
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
            // Logo (small)
            Image.asset('assets/images/logo.png', height: 30),            
            const SizedBox(width: 10),

            // Search bar
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
                    Icon(Icons.search_rounded,
                        color: Colors.grey[400], size: 18),
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
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 4),

            // Notification icon
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
                      // Background icon
                      Positioned(
                        right: -16,
                        bottom: -16,
                        child: Icon(
                          b.icon,
                          size: 140,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      // Text content
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
                                  horizontal: 14, vertical: 7),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.4)),
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

        // Dots
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

  // ── Categories ───────────────────────────────────────────────────────────

  Widget _buildCategories() {
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
        SizedBox(
          height: 92,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
            itemCount: _categories.length,
            itemBuilder: (_, i) {
              final cat = _categories[i];
              return GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  width: 78,
                  child: Column(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: cat.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: cat.color.withOpacity(0.2), width: 1),
                        ),
                        child: Icon(cat.icon, color: cat.color, size: 26),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        cat.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF555566),
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
      ],
    );
  }

  // ── Product Section ──────────────────────────────────────────────────────

  Widget _buildSection({required String title, required List<Product> products}) {
    if (products.isEmpty) return const SizedBox.shrink();

    // Show max 4 in preview; all on "Hamısı" tap
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
                onTap: () {
                  // TODO: Navigate to full product list
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
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
            childAspectRatio: 0.68,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: preview.length,
          itemBuilder: (_, i) => ProductCard(product: preview[i]),
        ),
      ],
    );
  }
}

// ── Data classes ─────────────────────────────────────────────────────────────

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

class _CategoryData {
  final String name;
  final IconData icon;
  final Color color;

  const _CategoryData(
      {required this.name, required this.icon, required this.color});
}
