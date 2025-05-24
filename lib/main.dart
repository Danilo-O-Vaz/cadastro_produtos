import 'package:flutter/material.dart';
import 'screens/product_form_screen.dart';
import 'screens/product_list_screen.dart';
import 'models/product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Produtos',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProductFormScreen(products: products),
    );
  }
}