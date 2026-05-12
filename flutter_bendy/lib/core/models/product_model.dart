// 📁 lib/core/models/product_model.dart

import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  final double price;
  final double? originalPrice;
  final String category;
  final bool isBestSeller;
  final List<Color> gradientColors;
  final double rating;
  final int reviewCount;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.originalPrice,
    required this.category,
    this.isBestSeller = false,
    required this.gradientColors,
    this.rating = 4.5,
    this.reviewCount = 0,
  });

  bool get isDiscounted => originalPrice != null && originalPrice! > price;

  double get discountPercent =>
      isDiscounted ? ((originalPrice! - price) / originalPrice! * 100) : 0;
}
