import 'package:copy_with_extension/copy_with_extension.dart';

part 'transaction_dto.g.dart';

@CopyWith()
class AddToCartRequest {
  /// BE nên ưu tiên nhận course_id (core)
  final int courseId;

  /// Nếu booking theo lịch học cụ thể
  final int? courseScheduleId;

  /// Nếu course có nhiều teacher (tuỳ domain)
  final int? teacherId;

  /// Nếu course thuộc 1 center cụ thể (hoặc FE muốn “chốt” theo center)
  final int? trainingCenterId;

  /// Mặc định 1 khoá học = 1 item
  final int quantity;

  /// Extra data để BE lưu tuỳ ý (note, selected_slot, device, v.v.)
  final Map<String, dynamic>? meta;

  const AddToCartRequest({
    required this.courseId,
    this.courseScheduleId,
    this.teacherId,
    this.trainingCenterId,
    this.quantity = 1,
    this.meta,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = {
      'course_id': courseId,
      'quantity': quantity,
    };

    if (courseScheduleId != null) body['course_schedule_id'] = courseScheduleId;
    if (teacherId != null) body['teacher_id'] = teacherId;
    if (trainingCenterId != null) body['training_center_id'] = trainingCenterId;
    if (meta != null && meta!.isNotEmpty) body['meta'] = meta;

    return body;
  }
}

/// DELETE /api/v1/cart/remove-item/{id}
/// -> không cần DTO body, chỉ cần id param.
/// Nhưng nếu BE thiết kế remove theo course_id/schedule_id thì dùng cái này.
@CopyWith()
class RemoveCartItemRequest {
  final int? cartItemId;
  final int? courseId;
  final int? courseScheduleId;

  const RemoveCartItemRequest({
    this.cartItemId,
    this.courseId,
    this.courseScheduleId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = {};
    if (cartItemId != null) body['cart_item_id'] = cartItemId;
    if (courseId != null) body['course_id'] = courseId;
    if (courseScheduleId != null) body['course_schedule_id'] = courseScheduleId;
    return body;
  }
}

/// POST /api/v1/orders/checkout
/// Khuyến nghị: checkout từ cart_id (ổn định nhất).
@CopyWith()
class OrderCheckoutRequest {
  final int? cartId;

  /// Nếu BE cho phép checkout trực tiếp không qua cart:
  final List<OrderCheckoutItem>? items;

  /// vd: "vnpay", "momo", "bank_transfer", "cash"
  final String? paymentMethod;

  /// Ghi chú hiển thị cho admin/center
  final String? note;

  /// Voucher/coupon code nếu có
  final String? couponCode;

  /// Extra
  final Map<String, dynamic>? meta;

  const OrderCheckoutRequest({
    this.cartId,
    this.items,
    this.paymentMethod,
    this.note,
    this.couponCode,
    this.meta,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = {};

    if (cartId != null) body['cart_id'] = cartId;
    if (items != null && items!.isNotEmpty) {
      body['items'] = items!.map((e) => e.toJson()).toList();
    }

    if (paymentMethod != null && paymentMethod!.trim().isNotEmpty) {
      body['payment_method'] = paymentMethod!.trim();
    }
    if (note != null && note!.trim().isNotEmpty) body['note'] = note!.trim();
    if (couponCode != null && couponCode!.trim().isNotEmpty) {
      body['coupon_code'] = couponCode!.trim();
    }
    if (meta != null && meta!.isNotEmpty) body['meta'] = meta;

    return body;
  }
}

@CopyWith()
class OrderCheckoutItem {
  final int courseId;
  final int? courseScheduleId;
  final int? teacherId;
  final int? trainingCenterId;
  final int quantity;

  /// Nếu BE cho phép price override theo campaign (thường không nên),
  /// hoặc FE muốn gửi “display price” để log: put in meta instead.
  final Map<String, dynamic>? meta;

  const OrderCheckoutItem({
    required this.courseId,
    this.courseScheduleId,
    this.teacherId,
    this.trainingCenterId,
    this.quantity = 1,
    this.meta,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = {
      'course_id': courseId,
      'quantity': quantity,
    };
    if (courseScheduleId != null) body['course_schedule_id'] = courseScheduleId;
    if (teacherId != null) body['teacher_id'] = teacherId;
    if (trainingCenterId != null) body['training_center_id'] = trainingCenterId;
    if (meta != null && meta!.isNotEmpty) body['meta'] = meta;
    return body;
  }
}

/// GET /api/v1/orders/my
@CopyWith()
class MyOrderQuery {
  final String? status; // e.g. pending/paid/cancelled
  final String? sort;   // e.g. newest, total_desc...
  final int page;
  final int perPage;

  const MyOrderQuery({
    this.status,
    this.sort,
    this.page = 1,
    this.perPage = 10,
  });

  MyOrderQuery resetPage() => copyWith(page: 1);

  Map<String, dynamic> toQuery() {
    final Map<String, dynamic> q = {
      'page': page,
      'perpage': perPage,
    };
    if (status != null && status!.trim().isNotEmpty) q['status'] = status!.trim();
    if (sort != null && sort!.trim().isNotEmpty) q['sort'] = sort!.trim();
    return q;
  }
}

/// POST /api/v1/orders/{order}/cancel
@CopyWith()
class CancelOrderRequest {
  final String? reason;
  final Map<String, dynamic>? meta;

  const CancelOrderRequest({
    this.reason,
    this.meta,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = {};
    if (reason != null && reason!.trim().isNotEmpty) body['reason'] = reason!.trim();
    if (meta != null && meta!.isNotEmpty) body['meta'] = meta;
    return body;
  }
}

/// =======================
/// PAYMENT
/// =======================

/// POST /api/v1/payments/create-intent
@CopyWith()
class CreatePaymentIntentRequest {
  final int orderId;

  /// vd: "vnpay", "momo", "stripe"...
  final String provider;

  /// Nếu BE dùng method riêng (card/qr/bank_transfer)
  final String? method;

  /// Return URLs (mobile deep link / web)
  final String? returnUrl;
  final String? cancelUrl;

  final Map<String, dynamic>? meta;

  const CreatePaymentIntentRequest({
    required this.orderId,
    required this.provider,
    this.method,
    this.returnUrl,
    this.cancelUrl,
    this.meta,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = {
      'order_id': orderId,
      'provider': provider.trim(),
    };
    if (method != null && method!.trim().isNotEmpty) body['method'] = method!.trim();
    if (returnUrl != null && returnUrl!.trim().isNotEmpty) body['return_url'] = returnUrl!.trim();
    if (cancelUrl != null && cancelUrl!.trim().isNotEmpty) body['cancel_url'] = cancelUrl!.trim();
    if (meta != null && meta!.isNotEmpty) body['meta'] = meta;
    return body;
  }
}

/// POST /api/v1/payments/confirm
@CopyWith()
class ConfirmPaymentRequest {
  final int? orderId;

  /// tuỳ provider: intent_id / transaction_id / payment_ref...
  final String? paymentRef;

  /// callback payload verify (nếu provider bắn về)
  final Map<String, dynamic>? payload;

  const ConfirmPaymentRequest({
    this.orderId,
    this.paymentRef,
    this.payload,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = {};
    if (orderId != null) body['order_id'] = orderId;
    if (paymentRef != null && paymentRef!.trim().isNotEmpty) body['payment_ref'] = paymentRef!.trim();
    if (payload != null && payload!.isNotEmpty) body['payload'] = payload;
    return body;
  }
}