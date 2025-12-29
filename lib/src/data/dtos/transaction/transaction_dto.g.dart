// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AddToCartRequestCWProxy {
  AddToCartRequest courseId(int courseId);

  AddToCartRequest courseScheduleId(int? courseScheduleId);

  AddToCartRequest teacherId(int? teacherId);

  AddToCartRequest trainingCenterId(int? trainingCenterId);

  AddToCartRequest quantity(int quantity);

  AddToCartRequest meta(Map<String, dynamic>? meta);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AddToCartRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AddToCartRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  AddToCartRequest call({
    int courseId,
    int? courseScheduleId,
    int? teacherId,
    int? trainingCenterId,
    int quantity,
    Map<String, dynamic>? meta,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAddToCartRequest.copyWith(...)` or call `instanceOfAddToCartRequest.copyWith.fieldName(value)` for a single field.
class _$AddToCartRequestCWProxyImpl implements _$AddToCartRequestCWProxy {
  const _$AddToCartRequestCWProxyImpl(this._value);

  final AddToCartRequest _value;

  @override
  AddToCartRequest courseId(int courseId) => call(courseId: courseId);

  @override
  AddToCartRequest courseScheduleId(int? courseScheduleId) =>
      call(courseScheduleId: courseScheduleId);

  @override
  AddToCartRequest teacherId(int? teacherId) => call(teacherId: teacherId);

  @override
  AddToCartRequest trainingCenterId(int? trainingCenterId) =>
      call(trainingCenterId: trainingCenterId);

  @override
  AddToCartRequest quantity(int quantity) => call(quantity: quantity);

  @override
  AddToCartRequest meta(Map<String, dynamic>? meta) => call(meta: meta);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AddToCartRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AddToCartRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  AddToCartRequest call({
    Object? courseId = const $CopyWithPlaceholder(),
    Object? courseScheduleId = const $CopyWithPlaceholder(),
    Object? teacherId = const $CopyWithPlaceholder(),
    Object? trainingCenterId = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
  }) {
    return AddToCartRequest(
      courseId: courseId == const $CopyWithPlaceholder() || courseId == null
          ? _value.courseId
          // ignore: cast_nullable_to_non_nullable
          : courseId as int,
      courseScheduleId: courseScheduleId == const $CopyWithPlaceholder()
          ? _value.courseScheduleId
          // ignore: cast_nullable_to_non_nullable
          : courseScheduleId as int?,
      teacherId: teacherId == const $CopyWithPlaceholder()
          ? _value.teacherId
          // ignore: cast_nullable_to_non_nullable
          : teacherId as int?,
      trainingCenterId: trainingCenterId == const $CopyWithPlaceholder()
          ? _value.trainingCenterId
          // ignore: cast_nullable_to_non_nullable
          : trainingCenterId as int?,
      quantity: quantity == const $CopyWithPlaceholder() || quantity == null
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as int,
      meta: meta == const $CopyWithPlaceholder()
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as Map<String, dynamic>?,
    );
  }
}

extension $AddToCartRequestCopyWith on AddToCartRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAddToCartRequest.copyWith(...)` or `instanceOfAddToCartRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AddToCartRequestCWProxy get copyWith => _$AddToCartRequestCWProxyImpl(this);
}

abstract class _$RemoveCartItemRequestCWProxy {
  RemoveCartItemRequest cartItemId(int? cartItemId);

  RemoveCartItemRequest courseId(int? courseId);

  RemoveCartItemRequest courseScheduleId(int? courseScheduleId);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RemoveCartItemRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RemoveCartItemRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  RemoveCartItemRequest call({
    int? cartItemId,
    int? courseId,
    int? courseScheduleId,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRemoveCartItemRequest.copyWith(...)` or call `instanceOfRemoveCartItemRequest.copyWith.fieldName(value)` for a single field.
class _$RemoveCartItemRequestCWProxyImpl
    implements _$RemoveCartItemRequestCWProxy {
  const _$RemoveCartItemRequestCWProxyImpl(this._value);

  final RemoveCartItemRequest _value;

  @override
  RemoveCartItemRequest cartItemId(int? cartItemId) =>
      call(cartItemId: cartItemId);

  @override
  RemoveCartItemRequest courseId(int? courseId) => call(courseId: courseId);

  @override
  RemoveCartItemRequest courseScheduleId(int? courseScheduleId) =>
      call(courseScheduleId: courseScheduleId);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RemoveCartItemRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RemoveCartItemRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  RemoveCartItemRequest call({
    Object? cartItemId = const $CopyWithPlaceholder(),
    Object? courseId = const $CopyWithPlaceholder(),
    Object? courseScheduleId = const $CopyWithPlaceholder(),
  }) {
    return RemoveCartItemRequest(
      cartItemId: cartItemId == const $CopyWithPlaceholder()
          ? _value.cartItemId
          // ignore: cast_nullable_to_non_nullable
          : cartItemId as int?,
      courseId: courseId == const $CopyWithPlaceholder()
          ? _value.courseId
          // ignore: cast_nullable_to_non_nullable
          : courseId as int?,
      courseScheduleId: courseScheduleId == const $CopyWithPlaceholder()
          ? _value.courseScheduleId
          // ignore: cast_nullable_to_non_nullable
          : courseScheduleId as int?,
    );
  }
}

extension $RemoveCartItemRequestCopyWith on RemoveCartItemRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRemoveCartItemRequest.copyWith(...)` or `instanceOfRemoveCartItemRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RemoveCartItemRequestCWProxy get copyWith =>
      _$RemoveCartItemRequestCWProxyImpl(this);
}

abstract class _$OrderCheckoutRequestCWProxy {
  OrderCheckoutRequest cartId(int? cartId);

  OrderCheckoutRequest items(List<OrderCheckoutItem>? items);

  OrderCheckoutRequest paymentMethod(String? paymentMethod);

  OrderCheckoutRequest note(String? note);

  OrderCheckoutRequest couponCode(String? couponCode);

  OrderCheckoutRequest meta(Map<String, dynamic>? meta);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderCheckoutRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderCheckoutRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderCheckoutRequest call({
    int? cartId,
    List<OrderCheckoutItem>? items,
    String? paymentMethod,
    String? note,
    String? couponCode,
    Map<String, dynamic>? meta,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderCheckoutRequest.copyWith(...)` or call `instanceOfOrderCheckoutRequest.copyWith.fieldName(value)` for a single field.
class _$OrderCheckoutRequestCWProxyImpl
    implements _$OrderCheckoutRequestCWProxy {
  const _$OrderCheckoutRequestCWProxyImpl(this._value);

  final OrderCheckoutRequest _value;

  @override
  OrderCheckoutRequest cartId(int? cartId) => call(cartId: cartId);

  @override
  OrderCheckoutRequest items(List<OrderCheckoutItem>? items) =>
      call(items: items);

  @override
  OrderCheckoutRequest paymentMethod(String? paymentMethod) =>
      call(paymentMethod: paymentMethod);

  @override
  OrderCheckoutRequest note(String? note) => call(note: note);

  @override
  OrderCheckoutRequest couponCode(String? couponCode) =>
      call(couponCode: couponCode);

  @override
  OrderCheckoutRequest meta(Map<String, dynamic>? meta) => call(meta: meta);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderCheckoutRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderCheckoutRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderCheckoutRequest call({
    Object? cartId = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? paymentMethod = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? couponCode = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
  }) {
    return OrderCheckoutRequest(
      cartId: cartId == const $CopyWithPlaceholder()
          ? _value.cartId
          // ignore: cast_nullable_to_non_nullable
          : cartId as int?,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<OrderCheckoutItem>?,
      paymentMethod: paymentMethod == const $CopyWithPlaceholder()
          ? _value.paymentMethod
          // ignore: cast_nullable_to_non_nullable
          : paymentMethod as String?,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
      couponCode: couponCode == const $CopyWithPlaceholder()
          ? _value.couponCode
          // ignore: cast_nullable_to_non_nullable
          : couponCode as String?,
      meta: meta == const $CopyWithPlaceholder()
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as Map<String, dynamic>?,
    );
  }
}

extension $OrderCheckoutRequestCopyWith on OrderCheckoutRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderCheckoutRequest.copyWith(...)` or `instanceOfOrderCheckoutRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderCheckoutRequestCWProxy get copyWith =>
      _$OrderCheckoutRequestCWProxyImpl(this);
}

abstract class _$OrderCheckoutItemCWProxy {
  OrderCheckoutItem courseId(int courseId);

  OrderCheckoutItem courseScheduleId(int? courseScheduleId);

  OrderCheckoutItem teacherId(int? teacherId);

  OrderCheckoutItem trainingCenterId(int? trainingCenterId);

  OrderCheckoutItem quantity(int quantity);

  OrderCheckoutItem meta(Map<String, dynamic>? meta);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderCheckoutItem(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderCheckoutItem(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderCheckoutItem call({
    int courseId,
    int? courseScheduleId,
    int? teacherId,
    int? trainingCenterId,
    int quantity,
    Map<String, dynamic>? meta,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderCheckoutItem.copyWith(...)` or call `instanceOfOrderCheckoutItem.copyWith.fieldName(value)` for a single field.
class _$OrderCheckoutItemCWProxyImpl implements _$OrderCheckoutItemCWProxy {
  const _$OrderCheckoutItemCWProxyImpl(this._value);

  final OrderCheckoutItem _value;

  @override
  OrderCheckoutItem courseId(int courseId) => call(courseId: courseId);

  @override
  OrderCheckoutItem courseScheduleId(int? courseScheduleId) =>
      call(courseScheduleId: courseScheduleId);

  @override
  OrderCheckoutItem teacherId(int? teacherId) => call(teacherId: teacherId);

  @override
  OrderCheckoutItem trainingCenterId(int? trainingCenterId) =>
      call(trainingCenterId: trainingCenterId);

  @override
  OrderCheckoutItem quantity(int quantity) => call(quantity: quantity);

  @override
  OrderCheckoutItem meta(Map<String, dynamic>? meta) => call(meta: meta);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderCheckoutItem(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderCheckoutItem(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderCheckoutItem call({
    Object? courseId = const $CopyWithPlaceholder(),
    Object? courseScheduleId = const $CopyWithPlaceholder(),
    Object? teacherId = const $CopyWithPlaceholder(),
    Object? trainingCenterId = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
  }) {
    return OrderCheckoutItem(
      courseId: courseId == const $CopyWithPlaceholder() || courseId == null
          ? _value.courseId
          // ignore: cast_nullable_to_non_nullable
          : courseId as int,
      courseScheduleId: courseScheduleId == const $CopyWithPlaceholder()
          ? _value.courseScheduleId
          // ignore: cast_nullable_to_non_nullable
          : courseScheduleId as int?,
      teacherId: teacherId == const $CopyWithPlaceholder()
          ? _value.teacherId
          // ignore: cast_nullable_to_non_nullable
          : teacherId as int?,
      trainingCenterId: trainingCenterId == const $CopyWithPlaceholder()
          ? _value.trainingCenterId
          // ignore: cast_nullable_to_non_nullable
          : trainingCenterId as int?,
      quantity: quantity == const $CopyWithPlaceholder() || quantity == null
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as int,
      meta: meta == const $CopyWithPlaceholder()
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as Map<String, dynamic>?,
    );
  }
}

extension $OrderCheckoutItemCopyWith on OrderCheckoutItem {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderCheckoutItem.copyWith(...)` or `instanceOfOrderCheckoutItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderCheckoutItemCWProxy get copyWith =>
      _$OrderCheckoutItemCWProxyImpl(this);
}

abstract class _$MyOrderQueryCWProxy {
  MyOrderQuery status(String? status);

  MyOrderQuery sort(String? sort);

  MyOrderQuery page(int page);

  MyOrderQuery perPage(int perPage);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MyOrderQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MyOrderQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  MyOrderQuery call({String? status, String? sort, int page, int perPage});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMyOrderQuery.copyWith(...)` or call `instanceOfMyOrderQuery.copyWith.fieldName(value)` for a single field.
class _$MyOrderQueryCWProxyImpl implements _$MyOrderQueryCWProxy {
  const _$MyOrderQueryCWProxyImpl(this._value);

  final MyOrderQuery _value;

  @override
  MyOrderQuery status(String? status) => call(status: status);

  @override
  MyOrderQuery sort(String? sort) => call(sort: sort);

  @override
  MyOrderQuery page(int page) => call(page: page);

  @override
  MyOrderQuery perPage(int perPage) => call(perPage: perPage);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MyOrderQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MyOrderQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  MyOrderQuery call({
    Object? status = const $CopyWithPlaceholder(),
    Object? sort = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? perPage = const $CopyWithPlaceholder(),
  }) {
    return MyOrderQuery(
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String?,
      sort: sort == const $CopyWithPlaceholder()
          ? _value.sort
          // ignore: cast_nullable_to_non_nullable
          : sort as String?,
      page: page == const $CopyWithPlaceholder() || page == null
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int,
      perPage: perPage == const $CopyWithPlaceholder() || perPage == null
          ? _value.perPage
          // ignore: cast_nullable_to_non_nullable
          : perPage as int,
    );
  }
}

extension $MyOrderQueryCopyWith on MyOrderQuery {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMyOrderQuery.copyWith(...)` or `instanceOfMyOrderQuery.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MyOrderQueryCWProxy get copyWith => _$MyOrderQueryCWProxyImpl(this);
}

abstract class _$CancelOrderRequestCWProxy {
  CancelOrderRequest reason(String? reason);

  CancelOrderRequest meta(Map<String, dynamic>? meta);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CancelOrderRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CancelOrderRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  CancelOrderRequest call({String? reason, Map<String, dynamic>? meta});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCancelOrderRequest.copyWith(...)` or call `instanceOfCancelOrderRequest.copyWith.fieldName(value)` for a single field.
class _$CancelOrderRequestCWProxyImpl implements _$CancelOrderRequestCWProxy {
  const _$CancelOrderRequestCWProxyImpl(this._value);

  final CancelOrderRequest _value;

  @override
  CancelOrderRequest reason(String? reason) => call(reason: reason);

  @override
  CancelOrderRequest meta(Map<String, dynamic>? meta) => call(meta: meta);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CancelOrderRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CancelOrderRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  CancelOrderRequest call({
    Object? reason = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
  }) {
    return CancelOrderRequest(
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String?,
      meta: meta == const $CopyWithPlaceholder()
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as Map<String, dynamic>?,
    );
  }
}

extension $CancelOrderRequestCopyWith on CancelOrderRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCancelOrderRequest.copyWith(...)` or `instanceOfCancelOrderRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CancelOrderRequestCWProxy get copyWith =>
      _$CancelOrderRequestCWProxyImpl(this);
}

abstract class _$CreatePaymentIntentRequestCWProxy {
  CreatePaymentIntentRequest orderId(int orderId);

  CreatePaymentIntentRequest provider(String provider);

  CreatePaymentIntentRequest method(String? method);

  CreatePaymentIntentRequest returnUrl(String? returnUrl);

  CreatePaymentIntentRequest cancelUrl(String? cancelUrl);

  CreatePaymentIntentRequest meta(Map<String, dynamic>? meta);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CreatePaymentIntentRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CreatePaymentIntentRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  CreatePaymentIntentRequest call({
    int orderId,
    String provider,
    String? method,
    String? returnUrl,
    String? cancelUrl,
    Map<String, dynamic>? meta,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCreatePaymentIntentRequest.copyWith(...)` or call `instanceOfCreatePaymentIntentRequest.copyWith.fieldName(value)` for a single field.
class _$CreatePaymentIntentRequestCWProxyImpl
    implements _$CreatePaymentIntentRequestCWProxy {
  const _$CreatePaymentIntentRequestCWProxyImpl(this._value);

  final CreatePaymentIntentRequest _value;

  @override
  CreatePaymentIntentRequest orderId(int orderId) => call(orderId: orderId);

  @override
  CreatePaymentIntentRequest provider(String provider) =>
      call(provider: provider);

  @override
  CreatePaymentIntentRequest method(String? method) => call(method: method);

  @override
  CreatePaymentIntentRequest returnUrl(String? returnUrl) =>
      call(returnUrl: returnUrl);

  @override
  CreatePaymentIntentRequest cancelUrl(String? cancelUrl) =>
      call(cancelUrl: cancelUrl);

  @override
  CreatePaymentIntentRequest meta(Map<String, dynamic>? meta) =>
      call(meta: meta);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CreatePaymentIntentRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CreatePaymentIntentRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  CreatePaymentIntentRequest call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? provider = const $CopyWithPlaceholder(),
    Object? method = const $CopyWithPlaceholder(),
    Object? returnUrl = const $CopyWithPlaceholder(),
    Object? cancelUrl = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
  }) {
    return CreatePaymentIntentRequest(
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as int,
      provider: provider == const $CopyWithPlaceholder() || provider == null
          ? _value.provider
          // ignore: cast_nullable_to_non_nullable
          : provider as String,
      method: method == const $CopyWithPlaceholder()
          ? _value.method
          // ignore: cast_nullable_to_non_nullable
          : method as String?,
      returnUrl: returnUrl == const $CopyWithPlaceholder()
          ? _value.returnUrl
          // ignore: cast_nullable_to_non_nullable
          : returnUrl as String?,
      cancelUrl: cancelUrl == const $CopyWithPlaceholder()
          ? _value.cancelUrl
          // ignore: cast_nullable_to_non_nullable
          : cancelUrl as String?,
      meta: meta == const $CopyWithPlaceholder()
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as Map<String, dynamic>?,
    );
  }
}

extension $CreatePaymentIntentRequestCopyWith on CreatePaymentIntentRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCreatePaymentIntentRequest.copyWith(...)` or `instanceOfCreatePaymentIntentRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreatePaymentIntentRequestCWProxy get copyWith =>
      _$CreatePaymentIntentRequestCWProxyImpl(this);
}

abstract class _$ConfirmPaymentRequestCWProxy {
  ConfirmPaymentRequest orderId(int? orderId);

  ConfirmPaymentRequest paymentRef(String? paymentRef);

  ConfirmPaymentRequest payload(Map<String, dynamic>? payload);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ConfirmPaymentRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ConfirmPaymentRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  ConfirmPaymentRequest call({
    int? orderId,
    String? paymentRef,
    Map<String, dynamic>? payload,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfConfirmPaymentRequest.copyWith(...)` or call `instanceOfConfirmPaymentRequest.copyWith.fieldName(value)` for a single field.
class _$ConfirmPaymentRequestCWProxyImpl
    implements _$ConfirmPaymentRequestCWProxy {
  const _$ConfirmPaymentRequestCWProxyImpl(this._value);

  final ConfirmPaymentRequest _value;

  @override
  ConfirmPaymentRequest orderId(int? orderId) => call(orderId: orderId);

  @override
  ConfirmPaymentRequest paymentRef(String? paymentRef) =>
      call(paymentRef: paymentRef);

  @override
  ConfirmPaymentRequest payload(Map<String, dynamic>? payload) =>
      call(payload: payload);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ConfirmPaymentRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ConfirmPaymentRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  ConfirmPaymentRequest call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? paymentRef = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return ConfirmPaymentRequest(
      orderId: orderId == const $CopyWithPlaceholder()
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as int?,
      paymentRef: paymentRef == const $CopyWithPlaceholder()
          ? _value.paymentRef
          // ignore: cast_nullable_to_non_nullable
          : paymentRef as String?,
      payload: payload == const $CopyWithPlaceholder()
          ? _value.payload
          // ignore: cast_nullable_to_non_nullable
          : payload as Map<String, dynamic>?,
    );
  }
}

extension $ConfirmPaymentRequestCopyWith on ConfirmPaymentRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfConfirmPaymentRequest.copyWith(...)` or `instanceOfConfirmPaymentRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ConfirmPaymentRequestCWProxy get copyWith =>
      _$ConfirmPaymentRequestCWProxyImpl(this);
}
