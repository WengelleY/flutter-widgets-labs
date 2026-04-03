import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(const MyApp());

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>
          const HomeScreen(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final filter =
            state.uri.queryParameters['filter'] ??
            'all';

        return ProductDetailScreen(
          id: id,
          filter: filter,
        );
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go(
            '/product/42?filter=popular',
          ),
          child: const Text('Go to Details'),
        ),
      ),
    );
  }
}

class ProductDetailScreen
    extends StatelessWidget {
  final String id;
  final String filter;

  const ProductDetailScreen({
    super.key,
    required this.id,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product $id')),
      body: Center(
        child: Text(
          'Showing product $id\nFilter: $filter',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
