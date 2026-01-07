import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/data/repositories/remote/export.dart';
import 'package:edufy_mobile/src/presentation/pages/order/listing/order_listing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderListingCubit extends Cubit<OrderListingState> {
  final IOrderRepository orderRepository;

  OrderListingCubit({required this.orderRepository})
      : super(const OrderListingState());

  Future<void> initial() async {
    emit(state.copyWith(isLoading: true, exception: null));
    await fetchOrders(page: 1, isAppend: false);
    emit(state.copyWith(isLoading: false));
  }

  Future<void> fetchOrders({
    int page = 1,
    bool isAppend = true,
  }) async {
    final apiResult = await orderRepository.index(page: page);

    apiResult.when(
      success: (PaginationResponse<OrderModel> res) {
        final data = res.data ?? <OrderModel>[];
        emit(
          state.copyWith(
            page: page,
            pageCount: res.pageCount,
            items: isAppend ? [...state.items, ...data] : data,
            exception: null,
          ),
        );
      },
      failure: (ApiException error) =>
          emit(state.copyWith(exception: error)),
    );
  }

  Future<void> nextPage() async {
    if (state.page >= state.pageCount) return;
    await fetchOrders(page: state.page + 1);
  }
}
