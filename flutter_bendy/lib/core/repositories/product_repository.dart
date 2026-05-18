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
    String? categoryId,
    String? subCategoryId,
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

  Future<Product?> getProductById(String id) async {
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
      final response = await _dio.get('Categories/GetAll');
      if (response.statusCode == 200) {
        final List data = response.data as List;
        print(response);
        if (data.isNotEmpty) {
          print("API Categories: ${data.length}");
          return data.map((e) {
            // API returns CategoryDTO (id, name, icon, order)
            return Category.fromJson(
              e,
              color: _colorFor(e['id']),
              fallbackIcon: _iconFor(e['id']),
            );
          }).toList();
        }
      }
    } catch (e, stack) {
      print("CATEGORY API ERROR: $e");
      print(stack);
    }

    return mockCategories;
  }

  Future<List<SubCategory>> getSubCategories(String categoryId) async {
    try {
      final response = await _dio.get(
        'Subcategories/GetAll',
        queryParameters: {'categoryId': categoryId},
      );
      if (response.statusCode == 200) {
        final List data = response.data as List;
        if (data.isNotEmpty) {
          return data.map((e) => SubCategory.fromJson(e)).toList();
        }
      }
    } catch (_) {}

    // Fallback: filter mock data
    try {
      final subs = mockCategories
          .firstWhere((c) => c.id == categoryId)
          .subCategories;
      return subs;
    } catch (_) {
      return [];
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  static Color _colorFor(String id) {
    const map = {
      '0a5f0b3a-1f11-4a0b-8ee5-9c8f1d912345': Color(0xFF1565C0),
      'f8a6b22e-3d4c-4f0b-9c6f-1a2a3b4c5d6e': Color(0xFF2E7D32),
      '51ba27d7-6ed9-4d57-91c8-2b3c4d5e6f7a': Color(0xFFBF360C),
      '60d33e62-0f2b-4701-9e0a-3b4c5d6e7f8a': Color(0xFF4A148C),
      '7d40c393-a2b7-4f3d-b9c1-4e5f6a7b8c9d': Color(0xFF006064),
    };
    return map[id] ?? const Color(0xFF1565C0);
  }

  static IconData _iconFor(String id) {
    switch (id) {
      case '0a5f0b3a-1f11-4a0b-8ee5-9c8f1d912345':
        return Icons.electrical_services_rounded;
      case 'f8a6b22e-3d4c-4f0b-9c6f-1a2a3b4c5d6e':
        return Icons.battery_charging_full_rounded;
      case '51ba27d7-6ed9-4d57-91c8-2b3c4d5e6f7a':
        return Icons.hardware_rounded;
      case '60d33e62-0f2b-4701-9e0a-3b4c5d6e7f8a':
        return Icons.shield_rounded;
      case '7d40c393-a2b7-4f3d-b9c1-4e5f6a7b8c9d':
        return Icons.content_cut_rounded;
      default:
        return Icons.category_rounded;
    }
  }
}
