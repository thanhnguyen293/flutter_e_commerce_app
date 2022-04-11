part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {}

class UpdateProducts extends ProductEvent {
  const UpdateProducts(this.products);
  final List<Product> products;

  @override
  List<Object> get props => [products];
}
