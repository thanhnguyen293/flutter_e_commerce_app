part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent extends Equatable {
  const WishlistEvent();
}

class LoadWishlist extends WishlistEvent {
  @override
  List<Object?> get props => [];
}

class WishlistProductAdded extends WishlistEvent {
  final Product product;

  const WishlistProductAdded(this.product);

  @override
  List<Object?> get props => [product];
}

class WishlistProductRemoved extends WishlistEvent {
  final Product product;

  const WishlistProductRemoved(this.product);

  @override
  List<Object?> get props => [product];
}

class WishlistUpdate extends WishlistEvent {
  final Wishlist wishlist;

  const WishlistUpdate(this.wishlist);

  @override
  List<Object?> get props => [wishlist];
}
