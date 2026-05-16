// 📁 lib/core/data/mock_data.dart
//
// ⚠️  Bu fayl YALNIZ API əlçatmaz olduqda fallback kimi işlədilir.
//    API cavab verdikdə bu data avtomatik bypass olunur.

import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

// ─── Categories ──────────────────────────────────────────────────────────────

final List<Category> mockCategories = [
  Category(
    id: 1,
    name: 'Elektrik Alətlər',
    fallbackIcon: Icons.electrical_services_rounded,
    color: const Color(0xFF1565C0),
    subCategories: [
      SubCategory(id: 101, categoryId: 1, name: 'MIG/MAG'),
      SubCategory(id: 102, categoryId: 1, name: 'TIG'),
      SubCategory(id: 103, categoryId: 1, name: 'Elektrod'),
    ],
  ),
  Category(
    id: 2,
    name: 'Batareya Alətlər',
    fallbackIcon: Icons.battery_charging_full_rounded,
    color: const Color(0xFF2E7D32),
    subCategories: [
      SubCategory(id: 201, categoryId: 2, name: 'Portativ Qaynaq'),
      SubCategory(id: 202, categoryId: 2, name: 'Batareya Dəstləri'),
    ],
  ),
  Category(
    id: 3,
    name: 'Qaynaq Dəstləri',
    fallbackIcon: Icons.hardware_rounded,
    color: const Color(0xFFBF360C),
    subCategories: [
      SubCategory(id: 301, categoryId: 3, name: 'Tam Dəstlər'),
      SubCategory(id: 302, categoryId: 3, name: 'Əlavə Aksesuarlar'),
    ],
  ),
  Category(
    id: 4,
    name: 'Qoruyucu Vasitə',
    fallbackIcon: Icons.shield_rounded,
    color: const Color(0xFF4A148C),
    subCategories: [
      SubCategory(id: 401, categoryId: 4, name: 'Maska'),
      SubCategory(id: 402, categoryId: 4, name: 'Əlcək'),
      SubCategory(id: 403, categoryId: 4, name: 'Geyim'),
    ],
  ),
  Category(
    id: 5,
    name: 'Kəsici Alətlər',
    fallbackIcon: Icons.content_cut_rounded,
    color: const Color(0xFF006064),
    subCategories: [
      SubCategory(id: 501, categoryId: 5, name: 'Disk Kəsici'),
      SubCategory(id: 502, categoryId: 5, name: 'Plazma Kəsici'),
    ],
  ),
];

// ─── Products ─────────────────────────────────────────────────────────────────

final List<Product> mockProducts = [
  Product(
    id: 1,
    name: 'MIG Qaynaq Aparatı 200A',
    description:
        'Professional MIG qaynaq aparatı. 200A güc, soyutma sistemi mövcuddur. '
        'Ev və sənaye istifadəsi üçün uyğundur. 1 il zəmanət.',
    retailPrice: 850,
    wholesalePrice: 720,
    originalPrice: 1100,
    categoryId: 1,
    subCategoryId: 101,
    category: 'Elektrik Alətlər',
    images: [
      'https://picsum.photos/seed/mig1/600/400',
      'https://picsum.photos/seed/mig2/600/400',
      'https://picsum.photos/seed/mig3/600/400',
    ],
    isBestSeller: true,
    gradientColors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
    rating: 4.8,
    reviewCount: 124,
  ),
  Product(
    id: 2,
    name: 'TIG Qaynaq Dəsti 160A',
    description:
        'TIG qaynaq texnologiyası ilə dəqiq qaynaq. Paslanmaz polad və alüminium '
        'üçün ideal. Komplit dəst olaraq gəlir.',
    retailPrice: 1200,
    wholesalePrice: 980,
    categoryId: 1,
    subCategoryId: 102,
    category: 'Elektrik Alətlər',
    images: [
      'https://picsum.photos/seed/tig1/600/400',
      'https://picsum.photos/seed/tig2/600/400',
    ],
    isBestSeller: true,
    gradientColors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
    rating: 4.9,
    reviewCount: 89,
  ),
  Product(
    id: 3,
    name: 'Batareya Portativ Qaynaq',
    description:
        'Elektrik olmayan yerlərdə istifadə üçün nəzərdə tutulmuş batareya ilə '
        'işləyən portativ qaynaq aparatı. Yüngül çəki, güclü batareya.',
    retailPrice: 650,
    wholesalePrice: 530,
    originalPrice: 800,
    categoryId: 2,
    subCategoryId: 201,
    category: 'Batareya Alətlər',
    images: [
      'https://picsum.photos/seed/battery1/600/400',
      'https://picsum.photos/seed/battery2/600/400',
    ],
    gradientColors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
    rating: 4.6,
    reviewCount: 56,
  ),
  Product(
    id: 4,
    name: 'Elektrod Qaynaq 140A',
    description:
        'Giriş səviyyəli elektrod qaynaq aparatı. Başlanğıc səviyyə üçün '
        'uyğundur. Yüngül və daşıması asandır.',
    retailPrice: 320,
    wholesalePrice: 260,
    categoryId: 1,
    subCategoryId: 103,
    category: 'Elektrik Alətlər',
    images: [
      'https://picsum.photos/seed/electrode1/600/400',
      'https://picsum.photos/seed/electrode2/600/400',
    ],
    gradientColors: [Color(0xFFBF360C), Color(0xFFFF7043)],
    rating: 4.4,
    reviewCount: 203,
  ),
  Product(
    id: 5,
    name: 'Portativ Batareya Dəsti',
    description:
        'Komplit portativ batareya dəsti. Kabel, adaptör və çanta daxildir. '
        'Uzun istifadə müddəti, sürətli şarj.',
    retailPrice: 480,
    wholesalePrice: 390,
    originalPrice: 560,
    categoryId: 2,
    subCategoryId: 202,
    category: 'Batareya Alətlər',
    images: [
      'https://picsum.photos/seed/batteryset1/600/400',
      'https://picsum.photos/seed/batteryset2/600/400',
    ],
    isBestSeller: true,
    gradientColors: [Color(0xFF4A148C), Color(0xFF9C27B0)],
    rating: 4.7,
    reviewCount: 78,
  ),
  Product(
    id: 6,
    name: 'Avtomatik Qaynaq Maskası',
    description:
        'Avtomatik qaraltma texnologiyası. DIN 9-13 qoruma səviyyəsi. '
        'Ayarlanabilir baş bandı. Uzunmüddətli rahat istifadə.',
    retailPrice: 95,
    wholesalePrice: 72,
    originalPrice: 120,
    categoryId: 4,
    subCategoryId: 401,
    category: 'Qoruyucu Vasitə',
    images: [
      'https://picsum.photos/seed/mask1/600/400',
      'https://picsum.photos/seed/mask2/600/400',
    ],
    gradientColors: [Color(0xFF37474F), Color(0xFF78909C)],
    rating: 4.5,
    reviewCount: 315,
  ),
  Product(
    id: 7,
    name: 'İstilik Davamlı Əlcək',
    description:
        'Yüksək temperaturaya davamlı qaynaq əlcəyi. Dəri material, '
        'daxili istilik izolyasiyası. L/XL ölçü mövcuddur.',
    retailPrice: 35,
    wholesalePrice: 24,
    categoryId: 4,
    subCategoryId: 402,
    category: 'Qoruyucu Vasitə',
    images: [
      'https://picsum.photos/seed/glove1/600/400',
      'https://picsum.photos/seed/glove2/600/400',
    ],
    gradientColors: [Color(0xFF795548), Color(0xFFBCAAA4)],
    rating: 4.3,
    reviewCount: 442,
  ),
  Product(
    id: 8,
    name: 'Plazma Kəsici 40A',
    description:
        'Plazma texnologiyası ilə dəqiq metal kəsmə. 40A güc, 12mm kəsmə '
        'dərinliyi. Sürətli və enerji qənaətli.',
    retailPrice: 280,
    wholesalePrice: 225,
    categoryId: 5,
    subCategoryId: 502,
    category: 'Kəsici Alətlər',
    images: [
      'https://picsum.photos/seed/plasma1/600/400',
      'https://picsum.photos/seed/plasma2/600/400',
    ],
    isBestSeller: true,
    gradientColors: [Color(0xFF006064), Color(0xFF26C6DA)],
    rating: 4.8,
    reviewCount: 167,
  ),
];
