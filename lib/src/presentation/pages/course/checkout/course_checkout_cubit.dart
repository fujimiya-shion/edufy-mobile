import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/transaction/transaction_dto.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/data/repositories/remote/export.dart';
import 'package:edufy_mobile/src/presentation/pages/course/checkout/course_checkout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseCheckoutCubit extends Cubit<CourseCheckoutState> {
  final IOrderRepository orderRepository;

  CourseCheckoutCubit({
    required this.orderRepository,
  }) : super(const CourseCheckoutState());

  Future<void> initial({required CourseModel course}) async {
    if (state.isLoading) return;

    emit(
      state.copyWith(
        course: course,
        isLoading: true,
        exception: null,
        checkoutSuccess: false,
        createdOrder: null,
      ),
    );

    _recalculateLocal();
    emit(state.copyWith(isLoading: false));
  }

  Future<void> refresh() async {
    _recalculateLocal();
  }

  Future<void> applyCoupon(String? code) async {
    final trimmed = code?.trim();
    final normalized = (trimmed == null || trimmed.isEmpty) ? null : trimmed;

    if (normalized == state.couponCode) return;

    emit(state.copyWith(couponCode: normalized, exception: null));
    _recalculateLocal();
  }

  void selectPaymentMethod(CoursePaymentMethod method) {
    if (method == state.paymentMethod) return;
    emit(state.copyWith(paymentMethod: method, exception: null));
    _recalculateLocal();
  }

  void _recalculateLocal() {
    final course = state.course;
    if (course == null) return;

    final subtotal = (course.tuitionFee ?? 0).toDouble();

    // BE chưa có preview/calc => FE chỉ tạm hiển thị.
    final discount = 0.0;
    final platformFee = 0.0;
    final total = (subtotal - discount + platformFee);

    emit(
      state.copyWith(
        subtotalAmount: subtotal,
        discountAmount: discount,
        platformFeeAmount: platformFee,
        totalAmount: total,
      ),
    );
  }

  Future<void> submit() async {
    final course = state.course;
    if (course == null) return;
    if (state.isSubmitting) return;

    emit(
      state.copyWith(
        isSubmitting: true,
        exception: null,
        checkoutSuccess: false,
        createdOrder: null,
      ),
    );

    final req = OrderCheckoutRequest(
      // Flow đơn giản: checkout trực tiếp 1 item (không qua cart)
      items: [
        OrderCheckoutItem(
          courseId: course.id!,
          quantity: 1,
          // Nếu m có schedule/teacher/center ở UI thì set vào đây.
          // courseScheduleId: ...
          // teacherId: ...
          // trainingCenterId: ...
        ),
      ],
      paymentMethod: state.paymentMethod.apiValue,
      couponCode: state.couponCode,
      // note: ...
      // meta: ...
    );

    final result = await orderRepository.checkout(request: req);

    final ApiException? ex = result.exception;
    final order = result.response?.data;

    if (ex != null) {
      emit(state.copyWith(isSubmitting: false, exception: ex, checkoutSuccess: false));
      return;
    }

    emit(
      state.copyWith(
        isSubmitting: false,
        exception: null,
        checkoutSuccess: true,
        createdOrder: order,
      ),
    );

    // Nếu BE trả về payment_url / deep link nằm trong order.meta hoặc field riêng
    // thì navigate WebView ở layer UI (listener) dựa trên createdOrder.
  }
}
