import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/product_service.dart';

final productProvider = FutureProvider((ref) async {

  final dio = Dio(
    BaseOptions(
      baseUrl: "https://your-api.com/api/",
    ),
  );

  final service = ProductService(dio);

  return service.getProducts();
});