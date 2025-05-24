class Product {
  String name;
  double purchasePrice;
  double salePrice;
  int quantity;
  String description;
  String category;
  String imageUrl;
  bool isActive;
  bool isOnSale;
  double discount;

  Product({
    required this.name,
    required this.purchasePrice,
    required this.salePrice,
    required this.quantity,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.isActive,
    required this.isOnSale,
    required this.discount,
  });
}