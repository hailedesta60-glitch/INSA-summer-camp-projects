import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/product_provider.dart';
import '../../providers/search_provider.dart';
import '../../widgets/product_card.dart';


class HomePage extends ConsumerWidget {
  const HomePage({super.key});

 @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to filtered products instead of raw products
    final productsAsync = ref.watch(filteredProductsProvider);
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fake Store'),
        actions: [
          IconButton(
        icon: const Icon(Icons.favorite_border),
        onPressed: () => context.push('/wishlist'),
                 ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.push('/profile'),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => context.push('/cart'),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                // Update search query state dynamically as user types
                ref.read(searchQueryProvider.notifier).updateQuery(value);
              },
              decoration: InputDecoration(
                hintText: 'Search products by title or category...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
        ),
      ),
      body: productsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Failed to load products: $error'),
        ),
        data: (products) {
          if (products.isEmpty) {
            return const Center(
              child: Text('No matching products found'),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.55,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                product: product,
                onTap: () {
                  context.push('/detail', extra: product);
                },
              );
            },
          );
        },
      ),
    );
  }
}