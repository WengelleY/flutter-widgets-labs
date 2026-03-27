import 'package:flutter/material.dart';

void main() => runApp(const CatalogApp());

// 1. Define the Data Model
class Product {
  final String name;
  final String price;
  final String imageUrl;
  final Color color;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.color,
  });
}

class CatalogApp extends StatelessWidget {
  const CatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Product Catalog',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: CatalogScreen(),
    );
  }
}

class CatalogScreen extends StatelessWidget {
  CatalogScreen({super.key});

  // 2. Sample Data List
  final List<Product> products = [
    Product(
      name: 'Coffee Mug',
      price: '\$12.99',
      imageUrl:
          'https://picsum.photos/id/1/200/200',
      color: Colors.brown,
    ),
    Product(
      name: 'Notebook',
      price: '\$5.99',
      imageUrl:
          'https://picsum.photos/id/2/200/200',
      color: Colors.blue,
    ),
    Product(
      name: 'Pen Set',
      price: '\$8.49',
      imageUrl:
          'https://picsum.photos/id/3/200/200',
      color: Colors.green,
    ),
    Product(
      name: 'Backpack',
      price: '\$49.99',
      imageUrl:
          'https://picsum.photos/id/4/200/200',
      color: Colors.red,
    ),
    Product(
      name: 'Headphones',
      price: '\$89.99',
      imageUrl:
          'https://picsum.photos/id/5/200/200',
      color: Colors.grey,
    ),
    Product(
      name: 'Smart Watch',
      price: '\$199.99',
      imageUrl:
          'https://picsum.photos/id/6/200/200',
      color: Colors.black,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // 3. The Grid Layout
        child: GridView.builder(
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    2, // Two items per row
                childAspectRatio:
                    0.75, // Makes the cards taller than they are wide
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              // Using withOpacity since withValues is a newer Flutter 3.27+ feature
              color: product.color.withOpacity(
                0.1,
              ),
              child: InkWell(
                onTap: () {
                  // 4. Handle the Tap event
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    SnackBar(
                      content: Text(
                        'You selected ${product.name}',
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.all(
                            8.0,
                          ),
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(product.price),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
