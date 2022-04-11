import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../models/product_model.dart';

class CartItem extends Equatable {
  final Product product;
  final String size;

  const CartItem({
    required this.product,
    required this.size,
  });

  @override
  List<Object?> get props => [product, size];
}

class Cart extends Equatable {
  final Map<CartItem, int> cartItems;

  const Cart({
    this.cartItems = const <CartItem, int>{},
  });

  @override
  List<Object?> get props => [cartItems];

  static Cart fromSnapshot(DocumentSnapshot snapshot) {
    Cart cart = Cart(cartItems: {
      CartItem(
        product: Product.fromSnapshot(snapshot['product']),
        size: snapshot['size'].toString(),
      ): int.parse(snapshot['quantity'].toString())
    });

    return cart;
  }

  double get subtotal {
    double sub = 0.0;
    cartItems.forEach((key, value) {
      sub += key.product.price * value;
    });
    return sub;
  }

  int get subItem {
    int sub = 0;
    for (var value in cartItems.values) {
      sub += value;
    }
    return sub;
  }

  double deliveryFee(subtotal) {
    if (subtotal >= 500.0) {
      return 0.0;
    } else {
      return 10.0;
    }
  }

  String freeDelivery(subtotal) {
    if (subtotal >= 500.0) {
      return 'You have Free Delivery';
    } else {
      double missing = 500.0 - subtotal;
      return 'Add \$${missing.toStringAsFixed(2)} for FREE Delivery';
    }
  }

  double total(subtotal, deliveryFee) {
    return subtotal + deliveryFee(subtotal);
  }

  String get deliveryFeeString => deliveryFee(subtotal).toStringAsFixed(2);

  String get subtotalString => subtotal.toStringAsFixed(2);

  String get totalString => total(subtotal, deliveryFee).toStringAsFixed(2);

  String get freeDeliveryString => freeDelivery(subtotal);
}
