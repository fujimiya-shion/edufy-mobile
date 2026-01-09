// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaymentPayloadRequestCWProxy {
  PaymentPayloadRequest orderId(int orderId);

  PaymentPayloadRequest amount(int amount);

  PaymentPayloadRequest currency(String currency);

  PaymentPayloadRequest customer(UserModel customer);

  PaymentPayloadRequest description(String? description);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PaymentPayloadRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaymentPayloadRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  PaymentPayloadRequest call({
    int orderId,
    int amount,
    String currency,
    UserModel customer,
    String? description,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPaymentPayloadRequest.copyWith(...)` or call `instanceOfPaymentPayloadRequest.copyWith.fieldName(value)` for a single field.
class _$PaymentPayloadRequestCWProxyImpl
    implements _$PaymentPayloadRequestCWProxy {
  const _$PaymentPayloadRequestCWProxyImpl(this._value);

  final PaymentPayloadRequest _value;

  @override
  PaymentPayloadRequest orderId(int orderId) => call(orderId: orderId);

  @override
  PaymentPayloadRequest amount(int amount) => call(amount: amount);

  @override
  PaymentPayloadRequest currency(String currency) => call(currency: currency);

  @override
  PaymentPayloadRequest customer(UserModel customer) =>
      call(customer: customer);

  @override
  PaymentPayloadRequest description(String? description) =>
      call(description: description);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PaymentPayloadRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaymentPayloadRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  PaymentPayloadRequest call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? currency = const $CopyWithPlaceholder(),
    Object? customer = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
  }) {
    return PaymentPayloadRequest(
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as int,
      amount: amount == const $CopyWithPlaceholder() || amount == null
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as int,
      currency: currency == const $CopyWithPlaceholder() || currency == null
          ? _value.currency
          // ignore: cast_nullable_to_non_nullable
          : currency as String,
      customer: customer == const $CopyWithPlaceholder() || customer == null
          ? _value.customer
          // ignore: cast_nullable_to_non_nullable
          : customer as UserModel,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
    );
  }
}

extension $PaymentPayloadRequestCopyWith on PaymentPayloadRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPaymentPayloadRequest.copyWith(...)` or `instanceOfPaymentPayloadRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaymentPayloadRequestCWProxy get copyWith =>
      _$PaymentPayloadRequestCWProxyImpl(this);
}

abstract class _$PaymentCreateIntentResponseCWProxy {
  PaymentCreateIntentResponse clientSecret(String clientSecret);

  PaymentCreateIntentResponse customerId(String customerId);

  PaymentCreateIntentResponse ephemeralKey(String ephemeralKey);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PaymentCreateIntentResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaymentCreateIntentResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  PaymentCreateIntentResponse call({
    String clientSecret,
    String customerId,
    String ephemeralKey,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPaymentCreateIntentResponse.copyWith(...)` or call `instanceOfPaymentCreateIntentResponse.copyWith.fieldName(value)` for a single field.
class _$PaymentCreateIntentResponseCWProxyImpl
    implements _$PaymentCreateIntentResponseCWProxy {
  const _$PaymentCreateIntentResponseCWProxyImpl(this._value);

  final PaymentCreateIntentResponse _value;

  @override
  PaymentCreateIntentResponse clientSecret(String clientSecret) =>
      call(clientSecret: clientSecret);

  @override
  PaymentCreateIntentResponse customerId(String customerId) =>
      call(customerId: customerId);

  @override
  PaymentCreateIntentResponse ephemeralKey(String ephemeralKey) =>
      call(ephemeralKey: ephemeralKey);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PaymentCreateIntentResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaymentCreateIntentResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  PaymentCreateIntentResponse call({
    Object? clientSecret = const $CopyWithPlaceholder(),
    Object? customerId = const $CopyWithPlaceholder(),
    Object? ephemeralKey = const $CopyWithPlaceholder(),
  }) {
    return PaymentCreateIntentResponse(
      clientSecret:
          clientSecret == const $CopyWithPlaceholder() || clientSecret == null
          ? _value.clientSecret
          // ignore: cast_nullable_to_non_nullable
          : clientSecret as String,
      customerId:
          customerId == const $CopyWithPlaceholder() || customerId == null
          ? _value.customerId
          // ignore: cast_nullable_to_non_nullable
          : customerId as String,
      ephemeralKey:
          ephemeralKey == const $CopyWithPlaceholder() || ephemeralKey == null
          ? _value.ephemeralKey
          // ignore: cast_nullable_to_non_nullable
          : ephemeralKey as String,
    );
  }
}

extension $PaymentCreateIntentResponseCopyWith on PaymentCreateIntentResponse {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPaymentCreateIntentResponse.copyWith(...)` or `instanceOfPaymentCreateIntentResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaymentCreateIntentResponseCWProxy get copyWith =>
      _$PaymentCreateIntentResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentPayloadRequest _$PaymentPayloadRequestFromJson(
  Map<String, dynamic> json,
) => PaymentPayloadRequest(
  orderId: (json['order_id'] as num).toInt(),
  amount: (json['amount'] as num).toInt(),
  currency: json['currency'] as String? ?? 'VND',
  customer: UserModel.fromJson(json['customer'] as Map<String, dynamic>),
  description: json['description'] as String?,
);

Map<String, dynamic> _$PaymentPayloadRequestToJson(
  PaymentPayloadRequest instance,
) => <String, dynamic>{
  'order_id': instance.orderId,
  'amount': instance.amount,
  'currency': instance.currency,
  'customer': instance.customer,
  'description': instance.description,
};

PaymentCreateIntentResponse _$PaymentCreateIntentResponseFromJson(
  Map<String, dynamic> json,
) => PaymentCreateIntentResponse(
  clientSecret: json['client_secret'] as String,
  customerId: json['customer_id'] as String,
  ephemeralKey: json['ephemeral_key'] as String,
);

Map<String, dynamic> _$PaymentCreateIntentResponseToJson(
  PaymentCreateIntentResponse instance,
) => <String, dynamic>{
  'client_secret': instance.clientSecret,
  'customer_id': instance.customerId,
  'ephemeral_key': instance.ephemeralKey,
};
