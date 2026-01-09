import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_dto.g.dart';

@JsonSerializable()
@CopyWith()
class PaymentPayloadRequest {
  @JsonKey(name: 'order_id')
  final int orderId;
  final int amount;
  final String currency;
  final UserModel customer;
  final String? description;

  PaymentPayloadRequest({
    required this.orderId,
    required this.amount,
    this.currency = 'VND',
    required this.customer,
    this.description,
  });

  factory PaymentPayloadRequest.fromJson(Map<String, dynamic> json) => _$PaymentPayloadRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentPayloadRequestToJson(this);
}

@JsonSerializable()
@CopyWith()
class PaymentCreateIntentResponse {
  @JsonKey(name: 'client_secret')
  final String clientSecret;
  @JsonKey(name: 'customer_id')
  final String customerId;
  @JsonKey(name: 'ephemeral_key')
  final String ephemeralKey;

  const PaymentCreateIntentResponse({
    required this.clientSecret,
    required this.customerId,
    required this.ephemeralKey,
  });

  factory PaymentCreateIntentResponse.fromJson(Map<String, dynamic> json) => _$PaymentCreateIntentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentCreateIntentResponseToJson(this);
}

class PaymentResultResponse {
  
}