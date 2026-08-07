import 'dart:convert';

import '../core/network/http_client.dart';
import '../models/product_model.dart';

class ProductService {
  final HttpClient _httpClient;

  ProductService(this._httpClient);

  Future<List<Product>> getProducts() async {
    final response = await _httpClient.get('/products');

    if (response.statusCode != 200) {
      throw Exception('Failed to load products');
    }

    final List<dynamic> data = jsonDecode(response.body);

    return data
        .map((json) => Product.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Product> getProduct(int id) async {
    final response = await _httpClient.get('/products/$id');

    if (response.statusCode != 200) {
      throw Exception('Failed to load product');
    }

    final data = jsonDecode(response.body);

    return Product.fromJson(data as Map<String, dynamic>);
  }
}