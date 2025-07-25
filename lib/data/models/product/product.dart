// import 'package:flutter_mini/domain/entities/product_entity.dart';

// class Product extends ProductEntity {
//   final int id;
//   final String name;
//   final double price;
//   final int stock;
//   final String? image;

//   Product({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.stock,
//     required this.image,
//   }) : super(id: id, name: name, price: price, stock: stock, image: image);

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'] as int,
//       name: json['name'] as String,
//       price: double.tryParse(json['price']?.toString() ?? '0') ?? 0,
//       stock: json['stock'] as int,
//       image: json['image'] as String?,
//     );
//   }

//   ProductEntity toProductEntity() {
//     return ProductEntity(
//       id: id,
//       name: name,
//       price: price,
//       stock: stock,
//       image: image,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'name': name,
//     'price': price.toStringAsFixed(2),
//     'stock': stock,
//     'image': image,
//   };

//   @override
//   String toString() {
//     return 'Product(id: $id, name: $name, price: $price, stock: $stock';
//   }
// }

import 'package:flutter_mini/domain/entities/product_entity.dart';

class Product extends ProductEntity {
  Product({
    required super.id,
    required super.name,
    required super.price,
    required super.stock,
    super.image,
    required super.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id:
          json['id'] is int
              ? json['id']
              : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0,
      stock:
          json['stock'] is int
              ? json['stock']
              : int.tryParse(json['stock'].toString()) ?? 0,
      image: json['image']?.toString(),
      description: json['description']?.toString() ?? '',
    );
  }

  ProductEntity toProductEntity() {
    return ProductEntity(
      id: id,
      name: name,
      price: price,
      stock: stock,
      image: image,
      description: description,
    );
  }
}
