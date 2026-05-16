// 📁 lib/core/repositories/product_repository.dart
//
// Repository pattern:
//   1. API-dan data çəkməyə çalışır
//   2. Uğurlu olarsa → API data qaytarır
//   3. Xəta / boş cavab → mock data ilə fallback edir
//   4. API hazır olanda yalnız DioClient-dəki baseUrl-i dəyişmək kifayətdir

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

class ProductRepository {
  final Dio _dio;

  ProductRepository(this._dio);

  // ── Products ─────────────────────────────────────────────────────────────

  Future<List<Product>> getProducts({
    int? categoryId,
    int? subCategoryId,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (categoryId != null) queryParams['categoryId'] = categoryId;
      if (subCategoryId != null) queryParams['subCategoryId'] = subCategoryId;

      final response = await _dio.get(
        'products',
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );

      if (response.statusCode == 200) {
        final List data = response.data as List;
        if (data.isNotEmpty) {
          return data.map((e) => Product.fromJson(e)).toList();
        }
      }
    } catch (_) {
      // API əlçatmaz → fallback
    }

    var result = mockProducts;
    if (categoryId != null) {
      result = result.where((p) => p.categoryId == categoryId).toList();
    }
    if (subCategoryId != null) {
      result = result.where((p) => p.subCategoryId == subCategoryId).toList();
    }
    return result;
  }

  Future<Product?> getProductById(int id) async {
    try {
      final response = await _dio.get('products/$id');
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      }
    } catch (_) {}

    try {
      return mockProducts.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<List<Product>> getBestSellers() async {
    try {
      final response = await _dio.get('products/best-sellers');
      if (response.statusCode == 200) {
        final List data = response.data as List;
        if (data.isNotEmpty) {
          return data.map((e) => Product.fromJson(e)).toList();
        }
      }
    } catch (_) {}

    return mockProducts.where((p) => p.isBestSeller).toList();
  }

  Future<List<Product>> getDiscounted() async {
    try {
      final response = await _dio.get('products/discounted');
      if (response.statusCode == 200) {
        final List data = response.data as List;
        if (data.isNotEmpty) {
          return data.map((e) => Product.fromJson(e)).toList();
        }
      }
    } catch (_) {}

    return mockProducts.where((p) => p.isDiscounted).toList();
  }

  // ── Categories ────────────────────────────────────────────────────────────

  Future<List<Category>> getCategories() async {
    try {
      final response = await _dio.get('categories');
      if (response.statusCode == 200) {
        final List data = response.data as List;
        if (data.isNotEmpty) {
          return data.map((e) {
            final subs = (e['subCategories'] as List? ?? [])
                .map((s) => SubCategory.fromJson(s))
                .toList();
            return Category.fromJson(
              e,
              color: _colorFor(e['id']),
              fallbackIcon: _iconFor(e['id']),
              subCategories: subs,
            );
          }).toList();
        }
      }
    } catch (_) {}

    return mockCategories;
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  static Color _colorFor(dynamic id) {
    const map = {
      1: Color(0xFF1565C0),
      2: Color(0xFF2E7D32),
      3: Color(0xFFBF360C),
      4: Color(0xFF4A148C),
      5: Color(0xFF006064),
    };
    return map[id as int? ?? 0] ?? const Color(0xFF1565C0);
  }

  static IconData _iconFor(dynamic id) {
    switch (id as int? ?? 0) {
      case 1: return Icons.electrical_services_rounded;
      case 2: return Icons.battery_charging_full_rounded;
      case 3: return Icons.hardware_rounded;
      case 4: return Icons.shield_rounded;
      case 5: return Icons.content_cut_rounded;
      default: return Icons.category_rounded;
    }
  }
}
