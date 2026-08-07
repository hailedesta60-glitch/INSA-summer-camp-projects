import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/product_provider.dart';
import '../../widgets/product_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fake Store'),
        actions: [
    IconButton(
      icon: const Icon(Icons.shopping_cart),
      onPressed: () {
        context.push('/cart');
      },
    ),
    IconButton(
      icon: const Icon(Icons.person_outline),
      onPressed: () {
        context.push('/profile');
      },
    ),
  ],
      ),
      body: productsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
        ),
        data: (products) {
          return GridView.builder(
  padding: const EdgeInsets.all(12),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 0.7,
  ),
  itemCount: products.length,
  itemBuilder: (context, index) {
    final product = products[index];

    return ProductCard(
      product: product,
      onTap: (){
      context.go('/detail',extra:product);
      },
    );
  },
);
          
            },
      ),
    );
  }
}