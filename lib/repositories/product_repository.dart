import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductRepository {
  final ProductService _productService;

  ProductRepository(this._productService);

  Future<List<Product>> getProducts() {
    return _productService.getProducts();
  }

  Future<Product> getProduct(int id) {
    return _productService.getProduct(id);
  }
}