import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/network/http_client.dart';
import '../models/product_model.dart';
import '../repositories/product_repository.dart';
import '../services/product_service.dart';

final httpClientProvider = Provider<HttpClient>((ref) {
  final client = HttpClient();

  ref.onDispose(client.dispose);

  return client;
});

final productServiceProvider = Provider<ProductService>((ref) {
  final httpClient = ref.watch(httpClientProvider);

  return ProductService(httpClient);
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final productService = ref.watch(productServiceProvider);

  return ProductRepository(productService);
});

final productsProvider =
    FutureProvider.autoDispose<List<Product>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);

  return repository.getProducts();
});