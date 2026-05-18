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
    id: 'b801f77c-4521-4db3-ae3f-1d3c8e9a1234',
    name: 'Elektrik Alətlər',
    icon: 'electrical_services',
    fallbackIcon: Icons.electrical_services_rounded,
    color: const Color(0xFF1565C0),
    subCategories: [
      SubCategory(
        id: 'b1a4c5d6-e7f8-4123-9b0a-1c2d3e4f5a6b',
        categoryId: 'b801f77c-4521-4db3-ae3f-1d3c8e9a1234',
        name: 'MIG/MAG',
        icon: 'build',
      ),
      SubCategory(
        id: 'c2b5d6e7-f8a1-4234-9b0c-2d3e4f5a6b7c',
        categoryId: 'b801f77c-4521-4db3-ae3f-1d3c8e9a1234',
        name: 'TIG',
        icon: 'bolt',
      ),
      SubCategory(
        id: 'd3c6e7f8-a1b2-4345-9b0d-3e4f5a6b7c8d',
        categoryId: 'b801f77c-4521-4db3-ae3f-1d3c8e9a1234',
        name: 'Elektrod',
        icon: 'electrical_services',
      ),
    ],
  ),
  Category(
    id: '3c3b9c6b-a460-4c5f-8e64-22f2b1a7d891',
    name: 'Batareya Alətlər',
    icon: 'battery_charging_full',
    fallbackIcon: Icons.battery_charging_full_rounded,
    color: const Color(0xFF2E7D32),
    subCategories: [
      SubCategory(
        id: 'e4d7f8a1-b2c3-4456-9b0e-4f5a6b7c8d9e',
        categoryId: '3c3b9c6b-a460-4c5f-8e64-22f2b1a7d891',
        name: 'Portativ Qaynaq',
        icon: 'battery_charging_full',
      ),
      SubCategory(
        id: 'f5e8a1b2-c3d4-4567-9b0f-5a6b7c8d9e0f',
        categoryId: '3c3b9c6b-a460-4c5f-8e64-22f2b1a7d891',
        name: 'Batareya Dəstləri',
        icon: 'battery_full',
      ),
    ],
  ),
  Category(
    id: 'a4d8f6f2-5b1e-4e3c-949c-11a2b3c4d5e6',
    name: 'Qaynaq Dəstləri',
    icon: 'hardware',
    fallbackIcon: Icons.hardware_rounded,
    color: const Color(0xFFBF360C),
    subCategories: [
      SubCategory(
        id: 'a6f9b2c3-d4e5-4678-9a1b-6c7d8e9f0a1b',
        categoryId: 'a4d8f6f2-5b1e-4e3c-949c-11a2b3c4d5e6',
        name: 'Tam Dəstlər',
        icon: 'engineering',
      ),
      SubCategory(
        id: 'b7e0c3d4-e5f6-4789-0a1b-7c8d9e0f1a2b',
        categoryId: 'a4d8f6f2-5b1e-4e3c-949c-11a2b3c4d5e6',
        name: 'Əlavə Aksesuarlar',
        icon: 'add_box',
      ),
    ],
  ),
  Category(
    id: 'd2e5b1c0-9f7a-4a6c-b8d9-0f1e2d3c4b5a',
    name: 'Qoruyucu Vasitə',
    icon: 'shield',
    fallbackIcon: Icons.shield_rounded,
    color: const Color(0xFF4A148C),
    subCategories: [
      SubCategory(
        id: 'c8f1d4e5-a6b7-4890-1a2b-8c9d0e1f2a3b',
        categoryId: 'd2e5b1c0-9f7a-4a6c-b8d9-0f1e2d3c4b5a',
        name: 'Maska',
        icon: 'medical_services',
      ),
      SubCategory(
        id: 'd9e2f5a6-b7c8-49a0-1b2c-9d0e1f2a3b4c',
        categoryId: 'd2e5b1c0-9f7a-4a6c-b8d9-0f1e2d3c4b5a',
        name: 'Əlcək',
        icon: 'pan_tool',
      ),
      SubCategory(
        id: 'e0f3a6b7-c8d9-4ab0-1c2d-0e1f2a3b4c5d',
        categoryId: 'd2e5b1c0-9f7a-4a6c-b8d9-0f1e2d3c4b5a',
        name: 'Geyim',
        icon: 'checkroom',
      ),
    ],
  ),
  Category(
    id: 'e7f6a1b2-3c4d-5e6f-8a9b-0c1d2e3f4a5b',
    name: 'Kəsici Alətlər',
    icon: 'content_cut',
    fallbackIcon: Icons.content_cut_rounded,
    color: const Color(0xFF006064),
    subCategories: [
      SubCategory(
        id: 'f1a4b7c8-d9e0-4bc1-2d3e-1f2a3b4c5d6e',
        categoryId: 'e7f6a1b2-3c4d-5e6f-8a9b-0c1d2e3f4a5b',
        name: 'Disk Kəsici',
        icon: 'content_cut',
      ),
      SubCategory(
        id: 'a2b5c8d9-e0f1-4cd2-3e4f-2a3b4c5d6e7f',
        categoryId: 'e7f6a1b2-3c4d-5e6f-8a9b-0c1d2e3f4a5b',
        name: 'Plazma Kəsici',
        icon: 'bolt',
      ),
    ],
  ),
];

// ─── Products ─────────────────────────────────────────────────────────────────

final List<Product> mockProducts = [
  Product(
    id: '11111111-1111-4111-8111-111111111111',
    name: 'MIG Qaynaq Aparatı 200A',
    description:
        'Professional MIG qaynaq aparatı. 200A güc, soyutma sistemi mövcuddur. '
        'Ev və sənaye istifadəsi üçün uyğundur. 1 il zəmanət.',
    retailPrice: 850,
    wholesalePrice: 720,
    originalPrice: 1100,
    categoryId: 'b801f77c-4521-4db3-ae3f-1d3c8e9a1234',
    subCategoryId: 'b1a4c5d6-e7f8-4123-9b0a-1c2d3e4f5a6b',
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
    id: '22222222-2222-4222-8222-222222222222',
    name: 'TIG Qaynaq Dəsti 160A',
    description:
        'TIG qaynaq texnologiyası ilə dəqiq qaynaq. Paslanmaz polad və alüminium '
        'üçün ideal. Komplit dəst olaraq gəlir.',
    retailPrice: 1200,
    wholesalePrice: 980,
    categoryId: 'b801f77c-4521-4db3-ae3f-1d3c8e9a1234',
    subCategoryId: 'c2b5d6e7-f8a1-4234-9b0c-2d3e4f5a6b7c',
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
    id: '33333333-3333-4333-8333-333333333333',
    name: 'Batareya Portativ Qaynaq',
    description:
        'Elektrik olmayan yerlərdə istifadə üçün nəzərdə tutulmuş batareya ilə '
        'işləyən portativ qaynaq aparatı. Yüngül çəki, güclü batareya.',
    retailPrice: 650,
    wholesalePrice: 530,
    originalPrice: 800,
    categoryId: '3c3b9c6b-a460-4c5f-8e64-22f2b1a7d891',
    subCategoryId: 'e4d7f8a1-b2c3-4456-9b0e-4f5a6b7c8d9e',
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
    id: '44444444-4444-4444-8444-444444444444',
    name: 'Elektrod Qaynaq 140A',
    description:
        'Giriş səviyyəli elektrod qaynaq aparatı. Başlanğıc səviyyə üçün '
        'uyğundur. Yüngül və daşıması asandır.',
    retailPrice: 320,
    wholesalePrice: 260,
    categoryId: 'b801f77c-4521-4db3-ae3f-1d3c8e9a1234',
    subCategoryId: 'd3c6e7f8-a1b2-4345-9b0d-3e4f5a6b7c8d',
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
    id: '55555555-5555-4555-8555-555555555555',
    name: 'Portativ Batareya Dəsti',
    description:
        'Komplit portativ batareya dəsti. Kabel, adaptör və çanta daxildir. '
        'Uzun istifadə müddəti, sürətli şarj.',
    retailPrice: 480,
    wholesalePrice: 390,
    originalPrice: 560,
    categoryId: '3c3b9c6b-a460-4c5f-8e64-22f2b1a7d891',
    subCategoryId: 'f5e8a1b2-c3d4-4567-9b0f-5a6b7c8d9e0f',
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
    id: '66666666-6666-4666-8666-666666666666',
    name: 'Avtomatik Qaynaq Maskası',
    description:
        'Avtomatik qaraltma texnologiyası. DIN 9-13 qoruma səviyyəsi. '
        'Ayarlanabilir baş bandı. Uzunmüddətli rahat istifadə.',
    retailPrice: 95,
    wholesalePrice: 72,
    originalPrice: 120,
    categoryId: 'd2e5b1c0-9f7a-4a6c-b8d9-0f1e2d3c4b5a',
    subCategoryId: 'c8f1d4e5-a6b7-4890-1a2b-8c9d0e1f2a3b',
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
    id: '77777777-7777-4777-8777-777777777777',
    name: 'İstilik Davamlı Əlcək',
    description:
        'Yüksək temperaturaya davamlı qaynaq əlcəyi. Dəri material, '
        'daxili istilik izolyasiyası. L/XL ölçü mövcuddur.',
    retailPrice: 35,
    wholesalePrice: 24,
    categoryId: 'd2e5b1c0-9f7a-4a6c-b8d9-0f1e2d3c4b5a',
    subCategoryId: 'd9e2f5a6-b7c8-49a0-1b2c-9d0e1f2a3b4c',
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
    id: '88888888-8888-4888-8888-888888888888',
    name: 'Plazma Kəsici 40A',
    description:
        'Plazma texnologiyası ilə dəqiq metal kəsmə. 40A güc, 12mm kəsmə '
        'dərinliyi. Sürətli və enerji qənaətli.',
    retailPrice: 280,
    wholesalePrice: 225,
    categoryId: 'e7f6a1b2-3c4d-5e6f-8a9b-0c1d2e3f4a5b',
    subCategoryId: 'a2b5c8d9-e0f1-4cd2-3e4f-2a3b4c5d6e7f',
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
