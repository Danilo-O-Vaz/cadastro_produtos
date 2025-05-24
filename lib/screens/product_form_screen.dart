import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_list_screen.dart';

class ProductFormScreen extends StatefulWidget {
  final List<Product> products;

  ProductFormScreen({required this.products});

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _salePriceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();

  String _selectedCategory = 'Eletrônicos';
  bool _isActive = false;
  bool _isOnSale = false;
  double _discount = 0;

  final List<String> _categories = ['Eletrônicos', 'Vestuário', 'Alimentos', 'Outros'];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newProduct = Product(
        name: _nameController.text,
        purchasePrice: double.parse(_purchasePriceController.text),
        salePrice: double.parse(_salePriceController.text),
        quantity: int.parse(_quantityController.text),
        description: _descriptionController.text,
        category: _selectedCategory,
        imageUrl: _imageUrlController.text,
        isActive: _isActive,
        isOnSale: _isOnSale,
        discount: _discount,
      );

      widget.products.add(newProduct);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductListScreen(products: widget.products),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Produto')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _purchasePriceController,
                decoration: InputDecoration(labelText: 'Preço de Compra'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _salePriceController,
                decoration: InputDecoration(labelText: 'Preço de Venda'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantidade'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              Text('Categoria'),
              Column(
                children: _categories.map((category) {
                  return RadioListTile<String>(
                    title: Text(category),
                    value: category,
                    groupValue: _selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  );
                }).toList(),
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'URL da Imagem'),
              ),
              SizedBox(height: 10),
              _imageUrlController.text.isEmpty
                  ? Container()
                  : Image.network(
                      _imageUrlController.text,
                      height: 100,
                      errorBuilder: (context, error, stackTrace) {
                        return Text('Erro ao carregar imagem');
                      },
                    ),
              CheckboxListTile(
                title: Text('Produto Ativo'),
                value: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value!;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Em Promoção'),
                value: _isOnSale,
                onChanged: (value) {
                  setState(() {
                    _isOnSale = value!;
                  });
                },
              ),
              Text('Desconto: ${_discount.toInt()}%'),
              Slider(
                value: _discount,
                onChanged: (value) {
                  setState(() {
                    _discount = value;
                  });
                },
                min: 0,
                max: 100,
                divisions: 20,
                label: '${_discount.toInt()}%',
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Cadastrar Produto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}