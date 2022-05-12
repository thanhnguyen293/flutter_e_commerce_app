import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/cart_model.dart';
import '../../controller/cart/base_cart_repository.dart';

class CartRepository extends BaseCartRepository {
  final FirebaseFirestore _firebaseFirestore;

  CartRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  @override
  Future<void> addProductToCart(CartItem cartItem, int quantity) async {
    String email = FirebaseAuth.instance.currentUser!.email!;

    _firebaseFirestore
        .collection('cart')
        .doc(email)
        .collection('items')
        .doc(cartItem.id)
        .set(
      {
        'id': cartItem.id,
        'productId': cartItem.productId,
        'title': cartItem.title,
        'price': cartItem.price,
        'size': cartItem.size,
        'imageUrl': cartItem.imageUrl,
        'quantity': quantity,
      },
    );
  }

  @override
  Future<void> removeSingleProductFromCart(
      CartItem cartItem, int quantity) async {
    String email = FirebaseAuth.instance.currentUser!.email!;

    _firebaseFirestore
        .collection('cart')
        .doc(email)
        .collection('items')
        .doc(cartItem.id)
        .set(
      {
        'id': cartItem.id,
        'productId': cartItem.productId,
        'title': cartItem.title,
        'price': cartItem.price,
        'size': cartItem.size,
        'imageUrl': cartItem.imageUrl,
        'quantity': quantity,
      },
    );
  }

  @override
  Future<void> removeProductFromCart(CartItem cartItem) async {
    String email = FirebaseAuth.instance.currentUser!.email!;

    _firebaseFirestore
        .collection('cart')
        .doc(email)
        .collection('items')
        .doc(cartItem.id)
        .delete();
  }

  @override
  Stream<Cart> getCart() {
    String email = FirebaseAuth.instance.currentUser!.email!;
    return _firebaseFirestore
        .collection('cart')
        .doc(email)
        .collection('items')
        .snapshots()
        .map((snapshot) {
      List<Map<CartItem, int>> cartItems = snapshot.docs
          .map((doc) => {
                CartItem.fromSnapshot(doc):
                    int.parse(doc['quantity'].toString())
              })
          .toList();
      Map<CartItem, int> map = {
        for (var item in cartItems) item.keys.first: item.values.first
      };

      Cart cart = Cart(cartItems: map);

      return cart;
    });
  }
}
