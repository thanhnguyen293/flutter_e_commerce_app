import '../../models/cart_model.dart';

abstract class BaseCartRepository {
  Stream<Cart> getCart();
  Future<void> removeSingleProductFromCart(CartItem cartItem, int quantity);
  Future<void> removeProductFromCart(CartItem cartItem);
  Future<void> addProductToCart(CartItem cartItem, int quantity);
}
