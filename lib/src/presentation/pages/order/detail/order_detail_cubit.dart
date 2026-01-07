// lib/src/presentation/pages/order/detail/order_detail_cubit.dart
import 'package:edufy_mobile/src/data/repositories/remote/order/i_order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_detail_state.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  final IOrderRepository repository;

  OrderDetailCubit({required this.repository})
      : super(const OrderDetailState());

  Future<void> load(int id) async {
    emit(state.copyWith(isLoading: true, exception: null));

    final apiResult = await repository.getDetail(id);

    apiResult.when(
      success: (response) {
        emit(
          state.copyWith(
            isLoading: false,
            order: response.data,
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

  Future<void> refresh(int id) async {
    await load(id);
  }

  Future<void> cancel(int id) async {
    emit(state.copyWith(isCancelling: true, exception: null));

    final apiResult = await repository.cancel(id);

    apiResult.when(
      success: (response) {
        emit(
          state.copyWith(
            isCancelling: false,
            order: response.data,
            exception: null,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            isCancelling: false,
            exception: error,
          ),
        );
      },
    );
  }
}
