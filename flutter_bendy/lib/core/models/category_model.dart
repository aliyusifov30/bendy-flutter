// 📁 lib/core/models/category_model.dart

import 'package:flutter/material.dart';

class SubCategory {
  final String id;
  final String categoryId;
  final String name;
  final String? icon;
  final String? slug;
  final String? description;
  final bool isActive;
  final int order;

  const SubCategory({
    required this.id,
    required this.categoryId,
    required this.name,
    this.icon,
    this.slug,
    this.description,
    this.isActive = true,
    this.order = 0,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json['id']?.toString() ?? '',
    categoryId: json['categoryId']?.toString() ?? '',
    name: json['name'] as String,
    icon: json['icon']?.toString(),
    slug: json['slug'] as String?,
    description: json['description'] as String?,
    isActive: json['isActive'] as bool? ?? true,
    order: json['order'] as int? ?? 0,
  );
}

class Category {
  final String id;
  final String name;
  final String? icon;
  final int order;
  final Color color;
  final IconData fallbackIcon;
  final List<SubCategory> subCategories;

  const Category({
    required this.id,
    required this.name,
    this.icon,
    this.order = 0,
    required this.color,
    required this.fallbackIcon,
    this.subCategories = const [],
  });

  IconData get iconData => _iconDataFor(icon) ?? fallbackIcon;

  static IconData? _iconDataFor(String? icon) {
    switch (icon) {
      case 'electrical_services':
        return Icons.electrical_services_rounded;
      case 'battery_charging_full':
        return Icons.battery_charging_full_rounded;
      case 'hardware':
        return Icons.hardware_rounded;
      case 'shield':
        return Icons.shield_rounded;
      case 'content_cut':
        return Icons.content_cut_rounded;
      case 'checkroom':
        return Icons.checkroom_rounded;
      case 'build':
        return Icons.build_rounded;
      case 'bolt':
        return Icons.bolt_rounded;
      case 'medical_services':
        return Icons.medical_services_rounded;
      case 'pan_tool':
        return Icons.pan_tool_rounded;
      case 'add_box':
        return Icons.add_box_rounded;
      case 'engineering':
        return Icons.engineering_rounded;
      default:
        return null;
    }
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    Color color = const Color(0xFF1565C0),
    IconData fallbackIcon = Icons.category_rounded,
    List<SubCategory> subCategories = const [],
  }) => Category(
    id: json['id']?.toString() ?? '',
    name: json['name'] as String,
    icon: json['icon']?.toString(),
    order: json['order'] as int? ?? 0,
    color: color,
    fallbackIcon: fallbackIcon,
    subCategories: subCategories,
  );
}
