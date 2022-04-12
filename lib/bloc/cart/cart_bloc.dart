import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/cart/cart_repository.dart';
import '../../models/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<LoadCart>(_onLoadCart);
    on<CartUpdate>(_onCartUpdate);
    on<CartProductAdded>(_onCartProductAdded);
    on<CartSingleProductRemoved>(_onCartSingleProductRemoved);
    on<CartProductRemoved>(_onCartProductRemoved);
  }
  _onLoadCart(event, emit) {
    emit(CartLoading());
    final CartRepository _cartRepository = CartRepository();
    _cartRepository.getCart().listen((cart) {
      add(CartUpdate(cart));
    });
  }

  _onCartUpdate(CartUpdate event, Emitter<CartState> emit) {
    emit(CartLoaded(cart: event.cart));
  }

  _onCartProductAdded(CartProductAdded event, Emitter<CartState> emit) {
    final state = this.state;
    final CartItem cartItem = event.cartItem;

    if (state is CartLoaded) {
      final CartRepository _cartRepository = CartRepository();

      if (state.cart.cartItems.containsKey(cartItem)) {
        _cartRepository.addProductToCart(
            cartItem, state.cart.cartItems[cartItem]! + 1);
      } else {
        _cartRepository.addProductToCart(cartItem, 1);
      }

      try {
        emit(CartLoaded(
          cart: Cart(
            cartItems: Map.from(state.cart.cartItems)
              ..update(
                event.cartItem,
                (value) => value + 1,
                ifAbsent: () => 1,
              ),
          ),
        ));
      } on Exception {
        emit(CartError());
      }
    }
  }

  _onCartSingleProductRemoved(
      CartSingleProductRemoved event, Emitter<CartState> emit) {
    final state = this.state;
    if (state is CartLoaded) {
      final CartRepository _cartRepository = CartRepository();
      final CartItem cartItem = event.cartItem;
      if (state.cart.cartItems.containsKey(cartItem)) {
        _cartRepository.addProductToCart(
            cartItem, state.cart.cartItems[cartItem]! - 1);
      }
      try {
        emit(
          CartLoaded(
            cart: Cart(
              cartItems: Map.from(state.cart.cartItems)
                ..update(event.cartItem, (value) => value - 1),
            ),
          ),
        );
      } on Exception {
        emit(CartError());
      }
    }
  }

  _onCartProductRemoved(CartProductRemoved event, Emitter<CartState> emit) {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        final CartRepository _cartRepository = CartRepository();
        final CartItem cartItem = event.cartItem;
        _cartRepository.removeProductFromCart(cartItem);
        emit(
          CartLoaded(
            cart: Cart(
                cartItems: Map.from(state.cart.cartItems)
                  ..remove(event.cartItem)),
          ),
        );
      } on Exception {
        emit(CartError());
      }
    }
  }
}
