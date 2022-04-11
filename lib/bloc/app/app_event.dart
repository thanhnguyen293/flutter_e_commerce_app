import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/product_model.dart';
import '../../models/user_model.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutRequested extends AppEvent {}

class AppUserChanged extends AppEvent {
  @visibleForTesting
  const AppUserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

// class AppProductDetail extends AppEvent {
//   //@visibleForTesting
//   const AppProductDetail(this.product);

//   final Product product;

//   @override
//   List<Object> get props => [product];
// }
