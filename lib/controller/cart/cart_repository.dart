import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_e_commerce_app/models/cart_model.dart';
import 'package:flutter_e_commerce_app/models/product_model.dart';

import '../../controller/cart/base_cart_repository.dart';

class CartRepository extends BaseCartRepository {
  final FirebaseFirestore _firebaseFirestore;

  CartRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  // Future<void> addProductToCart(CartItem cartItem, int quantity) async {
  //   String email = FirebaseAuth.instance.currentUser!.email!;

  //   _firebaseFirestore.collection('cart').doc(email).collection('items').add({
  //     'product': Product.toSnapshot(cartItem.product),
  //     'size': cartItem.size,
  //     'quantity': quantity,
  //   });
  // }

  // @override
  // Future<void> removeProductToWishlist(CartItem cartItem, int quantity) async {
  //   String email = FirebaseAuth.instance.currentUser!.email!;

  //   _firebaseFirestore
  //       .collection('wishlist')
  //       .doc(email)
  //       .collection('items')
  //       .doc(cartItem.id)
  //       .delete();
  // }

  // @override
  // Stream<Cart> getWishlist() {
  //   String email = FirebaseAuth.instance.currentUser!.email!;
  //   return _firebaseFirestore
  //       .collection('wishlist')
  //       .doc(email)
  //       .collection('items')
  //       .snapshots()
  //       .map((snapshot) {
  //     final List<Cart> carts =
  //         snapshot.docs.map((doc) => Cart.fromSnapshot(doc)).toList();
  //     final Cart cart = Cart(cartItems: carts);
  //     return carts;
  //   });
  // }
}
