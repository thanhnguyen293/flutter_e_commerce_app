import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_e_commerce_app/models/product_model.dart';

class Wishlist extends Equatable {
  final List<Product> products;

  const Wishlist({this.products = const <Product>[]});

  @override
  List<Object?> get props => [products];

  // static fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> doc) {}
}
