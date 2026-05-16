// 📁 lib/features/more/presentation/more_page.dart
//
// Dependency: url_launcher
// pubspec.yaml-a əlavə et:
//   url_launcher: ^6.2.5
// iOS: ios/Runner/Info.plist-ə əlavə et:
//   <key>LSApplicationQueriesSchemes</key>
//   <array>
//     <string>whatsapp</string>
//     <string>tel</string>
//     <string>mailto</string>
//   </array>

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 30),
            const SizedBox(width: 10),
            const Text(
              'BENDY',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
                fontSize: 20,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(color: const Color(0xFFE8E8E8), height: 0.5),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ── Logo & brand ──────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Image.asset('assets/images/logo.png', height: 56),
                  const SizedBox(height: 10),
                  const Text(
                    'BENDY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Keyfiyyət | Güvən | Texnologiya',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.75),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Menu sections ─────────────────────────────────────────
            _MenuSection(
              items: [
                _MenuItem(
                  icon: Icons.info_outline_rounded,
                  label: 'Haqqımızda',
                  color: const Color(0xFF1565C0),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AboutPage()),
                  ),
                ),
                _MenuItem(
                  icon: Icons.contact_support_outlined,
                  label: 'Bizimlə əlaqə',
                  color: const Color(0xFF1565C0),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ContactPage()),
                  ),
                ),
                _MenuItem(
                  icon: Icons.privacy_tip_outlined,
                  label: 'Məxfilik siyasəti',
                  color: const Color(0xFF1565C0),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PrivacyPage()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _MenuSection(
              items: [
                _MenuItem(
                  icon: Icons.star_outline_rounded,
                  label: 'Tətbiqi qiymətləndir',
                  color: const Color(0xFFFF8F00),
                  onTap: () {},
                ),
                _MenuItem(
                  icon: Icons.share_outlined,
                  label: 'Dostlarınla paylaş',
                  color: const Color(0xFF2E7D32),
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Bendy v1.0.0',
              style: TextStyle(fontSize: 12, color: Colors.grey[400]),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ─── About Page ───────────────────────────────────────────────────────────────

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: _simpleAppBar(context, 'Haqqımızda'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: _cardDecor(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Bendy — Professional Qaynaq Avadanlıqları',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Bendy şirkəti Azərbaycanda professional qaynaq sistemləri '
                    'və svarka avadanlıqlarının satışı və xidmətləri sahəsində '
                    'fəaliyyət göstərir.\n\n'
                    'Missiyamız müştərilərimizə ən yüksək keyfiyyətli məhsulları '
                    'əlverişli qiymətlərlə çatdırmaq, professional texniki dəstək '
                    'göstərmək və uzunmüddətli tərəfdaşlıq qurmaqdan ibarətdir.\n\n'
                    'Bütün Azərbaycana çatdırılma xidmətimiz mövcuddur.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF555566),
                      height: 1.7,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ..._statCards(),
          ],
        ),
      ),
    );
  }

  List<Widget> _statCards() {
    final stats = [
      ('⚒️', 'Xidmətlər', 'Qaynaq, svarka, metal işləri'),
      ('📍', 'Ərazi', 'Bütün Azərbaycan'),
      ('✅', 'Zəmanət', 'Bütün məhsullarda 1 il'),
    ];
    return stats
        .map(
          (s) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: _cardDecor(),
            child: Row(
              children: [
                Text(s.$1, style: const TextStyle(fontSize: 28)),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.$2,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A2E))),
                    Text(s.$3,
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}

// ─── Contact Page ─────────────────────────────────────────────────────────────

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  // ⚠️  Bu dəyərləri öz məlumatlarınla dəyiş
  static const String _phone = '+994501234567';
  static const String _email = 'info@bendy.az';
  static const String _whatsapp = '994501234567'; // ölkə kodu ilə, + olmadan
  static const double _lat = 40.4093;
  static const double _lng = 49.8671;
  static const String _address = 'Bakı, Azərbaycan';

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: _simpleAppBar(context, 'Bizimlə əlaqə'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ── Map ───────────────────────────────────────────────────
            GestureDetector(
              onTap: () => _launch(
                'https://www.google.com/maps/search/?api=1&query=$_lat,$_lng',
              ),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://maps.googleapis.com/maps/api/staticmap'
                      '?center=$_lat,$_lng&zoom=15&size=600x300'
                      '&markers=color:blue%7C$_lat,$_lng'
                      '&key=YOUR_GOOGLE_MAPS_KEY', // ← Maps API key dəyiş
                    ),
                    fit: BoxFit.cover,
                    onError: (_, __) {},
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF1565C0).withOpacity(0.85),
                          const Color(0xFF42A5F5).withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            _address,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            child: const Text(
                              'Xəritədə aç →',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ── Contact buttons ───────────────────────────────────────
            _ContactTile(
              icon: Icons.phone_rounded,
              label: 'Telefon',
              value: _phone,
              color: const Color(0xFF1565C0),
              onTap: () => _launch('tel:$_phone'),
            ),
            _ContactTile(
              icon: Icons.email_rounded,
              label: 'E-poçt',
              value: _email,
              color: const Color(0xFFBF360C),
              onTap: () => _launch('mailto:$_email'),
            ),
            _ContactTile(
              icon: Icons.chat_rounded,
              label: 'WhatsApp',
              value: '+$_whatsapp',
              color: const Color(0xFF2E7D32),
              onTap: () => _launch(
                  'https://wa.me/$_whatsapp?text=Salam, Bendy haqqında məlumat almaq istəyirəm'),
            ),
            _ContactTile(
              icon: Icons.location_on_rounded,
              label: 'Ünvan',
              value: _address,
              color: const Color(0xFF4A148C),
              onTap: () => _launch(
                'https://www.google.com/maps/search/?api=1&query=$_lat,$_lng',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Privacy Page ─────────────────────────────────────────────────────────────

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: _simpleAppBar(context, 'Məxfilik siyasəti'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: _cardDecor(),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PrivacySection(
                title: '1. Toplanılan məlumatlar',
                body:
                    'Tətbiqimiz sifariş prosesində ad, əlaqə nömrəsi və çatdırılma '
                    'ünvanı kimi məlumatları toplayır. Bu məlumatlar yalnız sifarişin '
                    'yerinə yetirilməsi məqsədi ilə istifadə olunur.',
              ),
              _PrivacySection(
                title: '2. Məlumatların istifadəsi',
                body:
                    'Şəxsi məlumatlarınız üçüncü tərəflərlə paylaşılmır. '
                    'Məlumatlar yalnız xidmətlərimizi təqdim etmək, sifarişlərinizi '
                    'idarə etmək və müştəri dəstəyi üçün istifadə olunur.',
              ),
              _PrivacySection(
                title: '3. Məlumatların mühafizəsi',
                body:
                    'Bütün məlumatlar şifrələnmiş kanallar vasitəsilə ötürülür '
                    'və təhlükəsiz serverlərdə saxlanılır. Müasir təhlükəsizlik '
                    'standartlarına uyğun qorunur.',
              ),
              _PrivacySection(
                title: '4. Çərəzlər (Cookies)',
                body:
                    'Tətbiqimiz istifadəçi təcrübəsini yaxşılaşdırmaq məqsədi ilə '
                    'lokal saxlama (local storage) istifadə edə bilər. Bu heç bir '
                    'şəxsi məlumat içermir.',
              ),
              _PrivacySection(
                title: '5. Əlaqə',
                body:
                    'Məxfilik siyasəti ilə bağlı suallarınız üçün info@bendy.az '
                    'ünvanına müraciət edə bilərsiniz.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Shared helpers ───────────────────────────────────────────────────────────

BoxDecoration _cardDecor() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 3),
      )
    ],
  );
}

AppBar _simpleAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded,
          size: 18, color: Color(0xFF1565C0)),
      onPressed: () => Navigator.pop(context),
    ),
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFF1A1A2E),
        fontSize: 18,
      ),
    ),
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(0.5),
      child: Container(color: const Color(0xFFE8E8E8), height: 0.5),
    ),
  );
}

// ─── Reusable widgets ─────────────────────────────────────────────────────────

class _MenuSection extends StatelessWidget {
  final List<_MenuItem> items;
  const _MenuSection({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _cardDecor(),
      child: Column(
        children: List.generate(items.length, (i) {
          final item = items[i];
          return Column(
            children: [
              ListTile(
                onTap: item.onTap,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: item.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(item.icon, color: item.color, size: 20),
                ),
                title: Text(
                  item.label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                trailing: const Icon(Icons.chevron_right_rounded,
                    color: Color(0xFFCCCCCC)),
              ),
              if (i < items.length - 1)
                Divider(
                    height: 1,
                    color: Colors.grey[100],
                    indent: 56),
            ],
          );
        }),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _MenuItem(
      {required this.icon,
      required this.label,
      required this.color,
      required this.onTap});
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final VoidCallback onTap;

  const _ContactTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: _cardDecor(),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                          fontSize: 11, color: Colors.grey[500])),
                  const SizedBox(height: 2),
                  Text(value,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A2E),
                      )),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}

class _PrivacySection extends StatelessWidget {
  final String title;
  final String body;
  const _PrivacySection({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1565C0),
              )),
          const SizedBox(height: 6),
          Text(body,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[700],
                  height: 1.6)),
        ],
      ),
    );
  }
}
