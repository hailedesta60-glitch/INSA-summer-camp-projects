import 'package:go_router/go_router.dart';
import '../models/product_model.dart';
import '../screens/home/home_screen.dart';
import '../screens/details/product_detail_page.dart';
import '../screens/cart/cart_page.dart';
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
  path: '/cart',
  name: 'cart',
  builder: (context, state) => const CartPage(),
),
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'detail',
          name: 'detail',
          builder: (context, state) {
            final product = state.extra as Product;
            return ProductDetailPage(product: product);
          },
        ),
      ],
    ),
  ],
);