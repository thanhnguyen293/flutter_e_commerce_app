import 'package:flutter_e_commerce_app/models/wishlist.dart';

import '../../models/product_model.dart';

abstract class BaseWishlistRepository {
  Stream<Wishlist> getWishlist();
  Future<void> removeProductToWishlist(Product product);
  Future<void> addProductToWishlist(Product product);
}
