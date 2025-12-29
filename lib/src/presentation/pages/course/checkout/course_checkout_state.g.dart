// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_checkout_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CourseCheckoutStateCWProxy {
  CourseCheckoutState isLoading(bool isLoading);

  CourseCheckoutState isSubmitting(bool isSubmitting);

  CourseCheckoutState checkoutSuccess(bool checkoutSuccess);

  CourseCheckoutState course(CourseModel? course);

  CourseCheckoutState couponCode(String? couponCode);

  CourseCheckoutState paymentMethod(CoursePaymentMethod paymentMethod);

  CourseCheckoutState subtotalAmount(double subtotalAmount);

  CourseCheckoutState discountAmount(double discountAmount);

  CourseCheckoutState platformFeeAmount(double platformFeeAmount);

  CourseCheckoutState totalAmount(double totalAmount);

  CourseCheckoutState createdOrder(OrderModel? createdOrder);

  CourseCheckoutState exception(ApiException? exception);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CourseCheckoutState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CourseCheckoutState(...).copyWith(id: 12, name: "My name")
  /// ```
  CourseCheckoutState call({
    bool isLoading,
    bool isSubmitting,
    bool checkoutSuccess,
    CourseModel? course,
    String? couponCode,
    CoursePaymentMethod paymentMethod,
    double subtotalAmount,
    double discountAmount,
    double platformFeeAmount,
    double totalAmount,
    OrderModel? createdOrder,
    ApiException? exception,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCourseCheckoutState.copyWith(...)` or call `instanceOfCourseCheckoutState.copyWith.fieldName(value)` for a single field.
class _$CourseCheckoutStateCWProxyImpl implements _$CourseCheckoutStateCWProxy {
  const _$CourseCheckoutStateCWProxyImpl(this._value);

  final CourseCheckoutState _value;

  @override
  CourseCheckoutState isLoading(bool isLoading) => call(isLoading: isLoading);

  @override
  CourseCheckoutState isSubmitting(bool isSubmitting) =>
      call(isSubmitting: isSubmitting);

  @override
  CourseCheckoutState checkoutSuccess(bool checkoutSuccess) =>
      call(checkoutSuccess: checkoutSuccess);

  @override
  CourseCheckoutState course(CourseModel? course) => call(course: course);

  @override
  CourseCheckoutState couponCode(String? couponCode) =>
      call(couponCode: couponCode);

  @override
  CourseCheckoutState paymentMethod(CoursePaymentMethod paymentMethod) =>
      call(paymentMethod: paymentMethod);

  @override
  CourseCheckoutState subtotalAmount(double subtotalAmount) =>
      call(subtotalAmount: subtotalAmount);

  @override
  CourseCheckoutState discountAmount(double discountAmount) =>
      call(discountAmount: discountAmount);

  @override
  CourseCheckoutState platformFeeAmount(double platformFeeAmount) =>
      call(platformFeeAmount: platformFeeAmount);

  @override
  CourseCheckoutState totalAmount(double totalAmount) =>
      call(totalAmount: totalAmount);

  @override
  CourseCheckoutState createdOrder(OrderModel? createdOrder) =>
      call(createdOrder: createdOrder);

  @override
  CourseCheckoutState exception(ApiException? exception) =>
      call(exception: exception);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CourseCheckoutState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CourseCheckoutState(...).copyWith(id: 12, name: "My name")
  /// ```
  CourseCheckoutState call({
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? isSubmitting = const $CopyWithPlaceholder(),
    Object? checkoutSuccess = const $CopyWithPlaceholder(),
    Object? course = const $CopyWithPlaceholder(),
    Object? couponCode = const $CopyWithPlaceholder(),
    Object? paymentMethod = const $CopyWithPlaceholder(),
    Object? subtotalAmount = const $CopyWithPlaceholder(),
    Object? discountAmount = const $CopyWithPlaceholder(),
    Object? platformFeeAmount = const $CopyWithPlaceholder(),
    Object? totalAmount = const $CopyWithPlaceholder(),
    Object? createdOrder = const $CopyWithPlaceholder(),
    Object? exception = const $CopyWithPlaceholder(),
  }) {
    return CourseCheckoutState(
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      isSubmitting:
          isSubmitting == const $CopyWithPlaceholder() || isSubmitting == null
          ? _value.isSubmitting
          // ignore: cast_nullable_to_non_nullable
          : isSubmitting as bool,
      checkoutSuccess:
          checkoutSuccess == const $CopyWithPlaceholder() ||
              checkoutSuccess == null
          ? _value.checkoutSuccess
          // ignore: cast_nullable_to_non_nullable
          : checkoutSuccess as bool,
      course: course == const $CopyWithPlaceholder()
          ? _value.course
          // ignore: cast_nullable_to_non_nullable
          : course as CourseModel?,
      couponCode: couponCode == const $CopyWithPlaceholder()
          ? _value.couponCode
          // ignore: cast_nullable_to_non_nullable
          : couponCode as String?,
      paymentMethod:
          paymentMethod == const $CopyWithPlaceholder() || paymentMethod == null
          ? _value.paymentMethod
          // ignore: cast_nullable_to_non_nullable
          : paymentMethod as CoursePaymentMethod,
      subtotalAmount:
          subtotalAmount == const $CopyWithPlaceholder() ||
              subtotalAmount == null
          ? _value.subtotalAmount
          // ignore: cast_nullable_to_non_nullable
          : subtotalAmount as double,
      discountAmount:
          discountAmount == const $CopyWithPlaceholder() ||
              discountAmount == null
          ? _value.discountAmount
          // ignore: cast_nullable_to_non_nullable
          : discountAmount as double,
      platformFeeAmount:
          platformFeeAmount == const $CopyWithPlaceholder() ||
              platformFeeAmount == null
          ? _value.platformFeeAmount
          // ignore: cast_nullable_to_non_nullable
          : platformFeeAmount as double,
      totalAmount:
          totalAmount == const $CopyWithPlaceholder() || totalAmount == null
          ? _value.totalAmount
          // ignore: cast_nullable_to_non_nullable
          : totalAmount as double,
      createdOrder: createdOrder == const $CopyWithPlaceholder()
          ? _value.createdOrder
          // ignore: cast_nullable_to_non_nullable
          : createdOrder as OrderModel?,
      exception: exception == const $CopyWithPlaceholder()
          ? _value.exception
          // ignore: cast_nullable_to_non_nullable
          : exception as ApiException?,
    );
  }
}

extension $CourseCheckoutStateCopyWith on CourseCheckoutState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCourseCheckoutState.copyWith(...)` or `instanceOfCourseCheckoutState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CourseCheckoutStateCWProxy get copyWith =>
      _$CourseCheckoutStateCWProxyImpl(this);
}
