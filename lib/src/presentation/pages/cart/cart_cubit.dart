// lib/src/presentation/pages/cart/cart_cubit.dart
import 'package:edufy_mobile/src/data/repositories/remote/cart/i_cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final ICartRepository cartRepository;

  CartCubit({required this.cartRepository}) : super(const CartState());

  Future<void> load() async {
    emit(state.copyWith(isLoading: true, exception: null));

    final apiResult = await cartRepository.getMyCart();

    apiResult.when(
      success: (response) {
        emit(
          state.copyWith(
            isLoading: false,
            cart: response.data,
            exception: null,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            isLoading: false,
            exception: error,
          ),
        );
      },
    );
  }

  Future<void> refresh() async {
    await load();
  }
}
