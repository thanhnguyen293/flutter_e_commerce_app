import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app/controller/wishlist/wishlist_repository.dart';
import 'package:flutter_e_commerce_app/models/product_model.dart';

import '../../models/wishlist.dart';

part 'wishlist_state.dart';
part 'wishlist_event.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  //final WishlistRepository _wishlistRepository;

  WishlistBloc() : super(WishlistLoading()) {
    on<LoadWishlist>(_onLoadWishlist);
    on<WishlistUpdate>(onWishlistUpdate);
    on<WishlistProductAdded>(_onWishlistProductAdded);
    on<WishlistProductRemoved>(_onWishlistProductRemoved);
  }
  _onLoadWishlist(event, Emitter<WishlistState> emit) async {
    emit(WishlistLoading());
    final WishlistRepository _wishlistRepository = WishlistRepository();
    _wishlistRepository.getWishlist().listen((wishlist) {
      add(WishlistUpdate(wishlist));
    });
  }

  onWishlistUpdate(WishlistUpdate event, Emitter<WishlistState> emit) {
    emit(WishlistLoaded(wishlist: event.wishlist));
  }

  _onWishlistProductAdded(
    WishlistProductAdded event,
    Emitter<WishlistState> emit,
  ) {
    final WishlistRepository _wishlistRepository = WishlistRepository();
    _wishlistRepository.addProductToWishlist(event.product);
    final state = this.state;
    if (state is WishlistLoaded) {
      emit(
        WishlistLoaded(
          wishlist: Wishlist(
            products: List.from(state.wishlist.products)..add(event.product),
          ),
        ),
      );
    }
  }

  _onWishlistProductRemoved(
    WishlistProductRemoved event,
    Emitter<WishlistState> emit,
  ) {
    final WishlistRepository _wishlistRepository = WishlistRepository();
    _wishlistRepository.removeProductToWishlist(event.product);
    final state = this.state;
    if (state is WishlistLoaded) {
      emit(
        WishlistLoaded(
          wishlist: Wishlist(
            products: List.from(state.wishlist.products)..remove(event.product),
          ),
        ),
      );
    }
  }
}
