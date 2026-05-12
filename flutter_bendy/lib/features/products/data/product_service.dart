import 'package:dio/dio.dart';

class ProductService {

  final Dio dio;

  ProductService(this.dio);

  Future<List<dynamic>> getProducts() async {

    final response = await dio.get(
      "products",
    );

    return response.data;
  }
}