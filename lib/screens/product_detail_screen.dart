import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final precoComDesconto = product.isOnSale
        ? product.salePrice * (1 - product.discount / 100)
        : product.salePrice;

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.imageUrl,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported, size: 100),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Categoria: ${product.category}'),
            Text('Descrição: ${product.description}'),
            Text('Quantidade: ${product.quantity}'),
            const SizedBox(height: 10),
            Text('Preço de Compra: R\$ ${product.purchasePrice.toStringAsFixed(2)}'),
            product.isOnSale
                ? Text(
                    'Preço em Promoção: R\$ ${precoComDesconto.toStringAsFixed(2)} (-${product.discount.toInt()}%)',
                    style: const TextStyle(color: Colors.red),
                  )
                : Text(
                    'Preço de Venda: R\$ ${product.salePrice.toStringAsFixed(2)}'),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  product.isActive ? 'Produto Ativo' : 'Produto Inativo',
                  style: TextStyle(
                    color: product.isActive ? Colors.green : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 20),
                if (product.isOnSale)
                  const Icon(Icons.local_offer, color: Colors.red),
              ],
            )
          ],
        ),
      ),
    );
  }
}
