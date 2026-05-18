// 📁 lib/core/models/product_model.dart

import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String description;

  // Pricing
  final double retailPrice; // Pərakəndə qiymət
  final double wholesalePrice; // Topdan qiymət
  final double? originalPrice; // Endirimli məhsulda əsl qiymət

  // Category
  final String categoryId;
  final String? subCategoryId;
  final String category;

  // Images — ilk şəkil poster/thumbnail kimi işlədilir
  final List<String> images;

  // Flags
  final bool isBestSeller;
  final bool isActive;

  // Visual fallback (real şəkil olmadıqda gradient göstər)
  final List<Color> gradientColors;

  // Stats
  final double rating;
  final int reviewCount;

  const Product({
    required this.id,
    required this.name,
    this.description = '',
    required this.retailPrice,
    required this.wholesalePrice,
    this.originalPrice,
    required this.categoryId,
    this.subCategoryId,
    required this.category,
    this.images = const [],
    this.isBestSeller = false,
    this.isActive = true,
    required this.gradientColors,
    this.rating = 4.5,
    this.reviewCount = 0,
  });

  bool get isDiscounted =>
      originalPrice != null && originalPrice! > retailPrice;

  double get discountPercent => isDiscounted
      ? ((originalPrice! - retailPrice) / originalPrice! * 100)
      : 0;

  String get posterImage => images.isNotEmpty
      ? images.first
      : 'https://picsum.photos/seed/product-$id/600/400';

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id']?.toString() ?? '',
    name: json['name'] ?? '',
    description: json['description'] ?? '',
    retailPrice: (json['retailPrice'] as num).toDouble(),
    wholesalePrice: (json['wholesalePrice'] as num).toDouble(),
    originalPrice: json['originalPrice'] != null
        ? (json['originalPrice'] as num).toDouble()
        : null,
    categoryId: json['categoryId']?.toString() ?? '',
    subCategoryId: json['subCategoryId']?.toString(),
    category: json['categoryName'] ?? '',
    images: json['images'] != null ? List<String>.from(json['images']) : [],
    isBestSeller: json['isBestSeller'] ?? false,
    isActive: json['isActive'] ?? true,
    // API-dan gələndə gradient göstərilmir — şəkil var
    gradientColors: const [Color(0xFF1565C0), Color(0xFF42A5F5)],
    rating: (json['rating'] as num?)?.toDouble() ?? 4.5,
    reviewCount: json['reviewCount'] ?? 0,
  );
}
