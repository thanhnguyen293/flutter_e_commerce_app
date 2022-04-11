import 'package:equatable/equatable.dart';

enum HomeTab { home, favorites, cart, profile }

class HomeState extends Equatable {
  HomeState({
    this.tab = HomeTab.home,
  });
  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}
