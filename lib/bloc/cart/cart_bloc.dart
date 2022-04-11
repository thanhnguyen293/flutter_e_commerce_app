import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<LoadCart>(_onLoadCart);
    on<CartProductAdded>(_onCartProductAdded);
    on<CartSingleProductRemoved>(_onCartSingleProductRemoved);
    on<CartProductRemoved>(_onCartProductRemoved);
  }
  _onLoadCart(event, emit) {
    emit(CartLoading());
    try {
      Future<void>.delayed(const Duration(seconds: 2));
      emit(const CartLoaded());
    } catch (_) {
      emit(CartError());
    }
  }

  _onCartProductAdded(CartProductAdded event, Emitter<CartState> emit) {
    final state = this.state;
    final CartItem prd = event.cartItem;

    if (state is CartLoaded) {
      try {
        emit(CartLoaded(
          cart: Cart(
              cartItems: state.cart.cartItems.containsKey(event.cartItem)
                  ? (Map.from(state.cart.cartItems)
                    ..update(event.cartItem, (value) => value + 1))
                  : (Map.from(state.cart.cartItems)..addAll({prd: 1}))),
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
      try {
        emit(
          CartLoaded(
            cart: Cart(
              cartItems: state.cart.cartItems[event.cartItem] == 1
                  ? (Map.from(state.cart.cartItems)..remove(event.cartItem))
                  : (Map.from(state.cart.cartItems)
                    ..update(event.cartItem, (value) => value - 1)),
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
        emit(
          CartLoaded(
            cart: Cart(
                cartItems: (Map.from(state.cart.cartItems)
                  ..remove(event.cartItem))),
          ),
        );
      } on Exception {
        emit(CartError());
      }
    }
  }
}
