class ProductEntity {
  final int id;
  final String name;
  final double price;
  final int stock;
  final String? image;
  final String? description;

  ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.image,
    required this.description,
  });
}
