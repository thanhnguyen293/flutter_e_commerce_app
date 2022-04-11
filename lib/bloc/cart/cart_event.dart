part of 'cart_bloc.dart';

@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();
}

class LoadCart extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartProductAdded extends CartEvent {
  final CartItem cartItem;

  const CartProductAdded(this.cartItem);

  @override
  List<Object> get props => [cartItem];
}

class CartSingleProductRemoved extends CartEvent {
  final CartItem cartItem;

  const CartSingleProductRemoved(this.cartItem);

  @override
  List<Object> get props => [cartItem];
}

class CartProductRemoved extends CartEvent {
  final CartItem cartItem;

  const CartProductRemoved(this.cartItem);

  @override
  List<Object> get props => [cartItem];
}
