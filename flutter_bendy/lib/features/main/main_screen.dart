// 📁 lib/features/main/main_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../cart/providers/cart_provider.dart';
import '../home/presentation/home_page.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _index = 0;

  final List<Widget> _pages = const [
    HomePage(),
    _PlaceholderPage(label: 'Kateqoriyalar', icon: Icons.grid_view_rounded),
    _PlaceholderPage(label: 'Sevimlilər', icon: Icons.favorite_rounded),
    _PlaceholderPage(label: 'Səbət', icon: Icons.shopping_cart_rounded),
    _PlaceholderPage(label: 'Daha çoxu', icon: Icons.more_horiz_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final cartCount = ref.watch(
      cartProvider.select(
        (cart) => cart.values.fold(0, (s, i) => s + i.quantity),
      ),
    );

    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 28,
                offset: const Offset(0, -6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BottomNavigationBar(
              currentIndex: _index,
              onTap: (i) => setState(() => _index = i),
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: const Color(0xFF1565C0),
              unselectedItemColor: const Color(0xFFAAAAAA),
              selectedFontSize: 10,
              unselectedFontSize: 10,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home_rounded),
                  label: 'Bendy',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.grid_view_outlined),
                  activeIcon: Icon(Icons.grid_view_rounded),
                  label: 'Kateqoriyalar',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border_rounded),
                  activeIcon: Icon(Icons.favorite_rounded),
                  label: 'Sevimlilər',
                ),
                BottomNavigationBarItem(
                  icon: _CartIcon(count: cartCount, active: false),
                  activeIcon: _CartIcon(count: cartCount, active: true),
                  label: 'Səbət',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.more_horiz_rounded),
                  label: 'Daha çoxu',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Cart icon with badge ──────────────────────────────────────────────────────

class _CartIcon extends StatelessWidget {
  final int count;
  final bool active;

  const _CartIcon({required this.count, required this.active});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
          active
              ? Icons.shopping_cart_rounded
              : Icons.shopping_cart_outlined,
        ),
        if (count > 0)
          Positioned(
            right: -7,
            top: -5,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                count > 99 ? '99+' : '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

// ── Placeholder pages (replace later) ────────────────────────────────────────

class _PlaceholderPage extends StatelessWidget {
  final String label;
  final IconData icon;

  const _PlaceholderPage({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: Colors.grey[300]),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Tezliklə...',
              style: TextStyle(fontSize: 13, color: Colors.grey[350]),
            ),
          ],
        ),
      ),
    );
  }
}
