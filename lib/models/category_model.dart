import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
  const Category({
    required this.name,
  });

  static Category fromSnapshot(DocumentSnapshot snapshot) {
    Category category = Category(name: snapshot['name']);
    return category;
  }

  @override
  List<Object?> get props => [name];
}
