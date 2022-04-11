import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/product_model.dart';
import 'base_wishlist_repository.dart';
import '../../models/wishlist.dart';

class WishlistRepository extends BaseWishlistRepository {
  final FirebaseFirestore _firebaseFirestore;

  WishlistRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> addProductToWishlist(Product product) async {
    String email = FirebaseAuth.instance.currentUser!.email!;

    _firebaseFirestore
        .collection('wishlist')
        .doc(email)
        .collection('items')
        .doc(product.id)
        .set(Product.toSnapshot(product));
  }

  @override
  Future<void> removeProductToWishlist(Product product) async {
    String email = FirebaseAuth.instance.currentUser!.email!;

    _firebaseFirestore
        .collection('wishlist')
        .doc(email)
        .collection('items')
        .doc(product.id)
        .delete();
  }

  @override
  Stream<Wishlist> getWishlist() {
    String email = FirebaseAuth.instance.currentUser!.email!;
    return _firebaseFirestore
        .collection('wishlist')
        .doc(email)
        .collection('items')
        .snapshots()
        .map((snapshot) {
      final List<Product> products =
          snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
      final Wishlist wishlist = Wishlist(products: products);
      return wishlist;
    });
  }
}
