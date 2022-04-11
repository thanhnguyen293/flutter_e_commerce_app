import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String category;
  final String description;
  final List<String> imageUrl;
  final List<String> availableSize;
  final double price;
  final bool isRecommended;
  final bool isPopular;
  const Product({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.availableSize,
    required this.price,
    required this.isPopular,
    required this.isRecommended,
  });

  static Product fromSnapshot(DocumentSnapshot snapshot) {
    Product product = Product(
        id: snapshot['id'],
        title: snapshot['title'],
        category: snapshot['category'],
        description: snapshot['description'],
        imageUrl: List<String>.from(snapshot['imageUrl']),
        availableSize: List<String>.from(snapshot['availableSize']),
        price: double.parse(snapshot['price'].toString()),
        isPopular: snapshot['isPopular'],
        isRecommended: snapshot['isRecommended']);

    return product;
  }

  static Map<String, dynamic> toSnapshot(Product product) {
    return {
      'id': product.id,
      'title': product.title,
      'category': product.category,
      'description': product.description,
      'imageUrl': product.imageUrl,
      'availableSize': product.availableSize,
      'price': product.price,
      'isPopular': product.isPopular,
      'isRecommended': product.isRecommended,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        category,
        description,
        imageUrl,
        price,
        isRecommended,
        isPopular,
      ];
}
