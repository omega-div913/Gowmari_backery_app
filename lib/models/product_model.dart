class Product {
  final String id;
  final String name;
  final String unit; // e.g., PCS, NOS
  final double availableStock;
  final double price;
  final bool isActive;

  Product({
    required this.id,
    required this.name,
    required this.unit,
    required this.availableStock,
    required this.price,
    this.isActive = true,
  });
}