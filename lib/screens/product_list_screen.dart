import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatelessWidget {
  final List<Product> products;

  const ProductListScreen({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Produtos')),
      body: products.isEmpty
          ? const Center(child: Text('Nenhum produto cadastrado.'))
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final precoComDesconto = product.isOnSale
                    ? product.salePrice * (1 - product.discount / 100)
                    : product.salePrice;

                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  leading: ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Image.network(
      product.imageUrl,
      width: 60,
      height: 60,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.image_not_supported, size: 40),
    ),
  ),
  title: Text(
    product.name,
    style: const TextStyle(fontWeight: FontWeight.bold),
  ),
  subtitle: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Categoria: ${product.category}'),
      Text('Qtd: ${product.quantity}'),
      Text(
        product.isOnSale
            ? 'Promoção: R\$ ${precoComDesconto.toStringAsFixed(2)} (-${product.discount.toInt()}%)'
            : 'Preço: R\$ ${product.salePrice.toStringAsFixed(2)}',
        style: TextStyle(
          color: product.isOnSale ? Colors.red : Colors.black87,
          fontWeight: product.isOnSale ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      Text(
        product.isActive ? 'Status: Ativo' : 'Status: Inativo',
        style: TextStyle(
          color: product.isActive ? Colors.green : Colors.grey,
        ),
      ),
    ],
  ),
  trailing: product.isOnSale
      ? const Icon(Icons.local_offer, color: Colors.red)
      : null,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailScreen(product: product),
      ),
    );
  },
),
                );
              },
            ),
    );
  }
}
