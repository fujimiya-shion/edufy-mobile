import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/shared/utils/app_formatters.dart';
import 'package:equatable/equatable.dart';

part 'course_checkout_state.g.dart';

/// Payment methods hiện support: Stripe + Visa
/// + Gợi ý thêm payOS (QR/chuyển khoản) cho đồ án: free + dễ tích hợp.
/// Docs/payOS: :contentReference[oaicite:2]{index=2}
enum CoursePaymentMethod {
  stripe,
  visa,
  payos,
}

extension CoursePaymentMethodX on CoursePaymentMethod {
  String get label {
    switch (this) {
      case CoursePaymentMethod.stripe:
        return 'Stripe';
      case CoursePaymentMethod.visa:
        return 'Visa';
      case CoursePaymentMethod.payos:
        return 'payOS (QR/Chuyển khoản)';
    }
  }

  String get desc {
    switch (this) {
      case CoursePaymentMethod.stripe:
        return 'Thanh toán qua Stripe (test/prod tuỳ cấu hình)';
      case CoursePaymentMethod.visa:
        return 'Thanh toán bằng thẻ Visa';
      case CoursePaymentMethod.payos:
        return 'Thanh toán QR/chuyển khoản (phù hợp đồ án sinh viên)';
    }
  }

  /// Map đúng theo BE: payment_method
  ///
  /// Nếu BE đang nhận "stripe" và "visa" thì OK.
  /// Với payOS: tuỳ BE, có thể là "payos" hoặc "bank_transfer".
  String get apiValue {
    switch (this) {
      case CoursePaymentMethod.stripe:
        return 'stripe';
      case CoursePaymentMethod.visa:
        return 'visa';
      case CoursePaymentMethod.payos:
        return 'payos'; // <- đổi sang 'bank_transfer' nếu BE map vậy
    }
  }
}

@CopyWith()
class CourseCheckoutState extends Equatable {
  final bool isLoading;
  final bool isSubmitting;
  final bool checkoutSuccess;

  final CourseModel? course;
  final String? couponCode;
  final CoursePaymentMethod paymentMethod;

  /// Vì BE chưa có preview/calc endpoint, FE tạm tính local.
  final double subtotalAmount;
  final double discountAmount;
  final double platformFeeAmount;
  final double totalAmount;

  /// Order tạo được sau checkout
  final OrderModel? createdOrder;

  final ApiException? exception;

  const CourseCheckoutState({
    this.isLoading = false,
    this.isSubmitting = false,
    this.checkoutSuccess = false,
    this.course,
    this.couponCode,
    this.paymentMethod = CoursePaymentMethod.stripe,
    this.subtotalAmount = 0,
    this.discountAmount = 0,
    this.platformFeeAmount = 0,
    this.totalAmount = 0,
    this.createdOrder,
    this.exception,
  });

  String get subtotalText => formatCurrency(subtotalAmount);
  String get discountText =>
      discountAmount <= 0 ? '' : '-${formatCurrency(discountAmount)}';
  String get platformFeeText => formatCurrency(platformFeeAmount);
  String get totalText => formatCurrency(totalAmount);

  @override
  List<Object?> get props => [
        isLoading,
        isSubmitting,
        checkoutSuccess,
        course,
        couponCode,
        paymentMethod,
        subtotalAmount,
        discountAmount,
        platformFeeAmount,
        totalAmount,
        createdOrder,
        exception,
      ];
}
