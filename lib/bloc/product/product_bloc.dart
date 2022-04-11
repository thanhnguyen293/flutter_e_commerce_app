import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../controller/product/product_repository.dart';
import '../../models/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  // late final StreamSubscription? _productSubscription;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductLoading()) {
    on<LoadProducts>(_onLoadProducts);
    on<UpdateProducts>(_onUpdateProducts);
  }

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) {
    //_productSubscription =
    _productRepository.getAllProducts().listen(
          (products) => add(
            UpdateProducts(products),
          ),
        );
  }

  void _onUpdateProducts(UpdateProducts event, Emitter<ProductState> emit) {
    emit(ProductLoaded(products: event.products));
  }

  @override
  Future<void> close() {
    //_productSubscription!.cancel();
    return super.close();
  }

  // @override
  // Stream<ProductState> mapEventToState(
  //   ProductEvent event,
  // ) async* {
  //   if (event is LoadProducts) {
  //     yield* _mapLoadProductsToState();
  //   }
  //   if (event is UpdateProduct) {
  //     yield* _mapUpdateProductsToState(event);
  //   }
  // }

  // Stream<ProductState> _mapLoadProductsToState() async* {
  //   _productSubscription?.cancel();
  //   _productSubscription = _productRepository.getAllProducts().listen(
  //     (products) {
  //       add(UpdateProduct(products));
  //     },
  //   );
  // }

  // Stream<ProductState> _mapUpdateProductsToState(UpdateProduct event) async* {
  //   yield ProductLoaded(products: event.products);
  // }
}
