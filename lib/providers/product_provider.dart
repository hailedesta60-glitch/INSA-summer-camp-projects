import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/network/http_client.dart';
import '../models/product_model.dart';
import '../repositories/product_repository.dart';
import '../services/product_service.dart';
import '../providers/search_provider.dart';

final httpClientProvider = Provider<HttpClient>((ref) {
  return HttpClient();
});

final productServiceProvider = Provider<ProductService>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return ProductService(httpClient);
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final productService = ref.watch(productServiceProvider);
  return ProductRepository(productService);
});

final productsProvider = FutureProvider<List<Product>>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProducts();
});

// <--- Add filteredProductsProvider right here at the bottom!
final filteredProductsProvider = Provider<AsyncValue<List<Product>>>((ref) {
  final productsAsync = ref.watch(productsProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();

  return productsAsync.whenData((products) {
    if (query.isEmpty) {
      return products;
    }
    return products.where((product) {
      return product.title.toLowerCase().contains(query) ||
             product.category.toLowerCase().contains(query);
    }).toList();
  });
});