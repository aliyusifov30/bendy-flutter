// 📁 lib/core/models/category_model.dart

import 'package:flutter/material.dart';

class SubCategory {
  final int id;
  final int categoryId;
  final String name;
  final String? iconUrl;

  const SubCategory({
    required this.id,
    required this.categoryId,
    required this.name,
    this.iconUrl,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json['id'],
        categoryId: json['categoryId'],
        name: json['name'],
        iconUrl: json['iconUrl'],
      );
}

class Category {
  final int id;
  final String name;
  final String? iconUrl;
  final Color color;
  final IconData fallbackIcon;
  final List<SubCategory> subCategories;

  const Category({
    required this.id,
    required this.name,
    this.iconUrl,
    required this.color,
    required this.fallbackIcon,
    this.subCategories = const [],
  });

  factory Category.fromJson(
    Map<String, dynamic> json, {
    Color color = const Color(0xFF1565C0),
    IconData fallbackIcon = Icons.category_rounded,
    List<SubCategory> subCategories = const [],
  }) =>
      Category(
        id: json['id'],
        name: json['name'],
        iconUrl: json['iconUrl'],
        color: color,
        fallbackIcon: fallbackIcon,
        subCategories: subCategories,
      );
}
