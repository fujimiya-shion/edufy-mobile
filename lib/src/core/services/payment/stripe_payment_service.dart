import 'package:edufy_mobile/src/data/dtos/payment/payment_dto.dart';
import 'package:edufy_mobile/src/data/repositories/remote/payment/export.dart';
import 'package:edufy_mobile/src/shared/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripePaymentService {
  final IPaymentRepository paymentRepository;

  StripePaymentService({
    required this.paymentRepository,
  });

  Future<void> init({
    required String publishableKey,
    String? merchantIdentifier,
  }) async {
    Stripe.publishableKey = publishableKey;
    if(merchantIdentifier != null) {
      Stripe.merchantIdentifier = merchantIdentifier;
    }
    await Stripe.instance.applySettings();
  }

  Future<PaymentCreateIntentResponse?> createPaymentIntent({
    required PaymentPayloadRequest payload
  }) async {
    final apiResult = await paymentRepository.createIntent(payload: payload, provider: PaymentProviders.stripe.name);
    if(apiResult.isSuccess) {
      final response = apiResult.response!.data!;
      return response;
    }
    return null;
  }

  Future<void> initPaymentSheet({
    required String clientSecret,
    String? customerId,
    String? ephemeraKey,
    String merchantName = const String.fromEnvironment("APP_NAME")
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        customerId: customerId,
        customerEphemeralKeySecret: ephemeraKey,
        merchantDisplayName: merchantName,
        style: ThemeMode.light,
        allowsDelayedPaymentMethods: true,
      )
    );
  }

  Future<bool> presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      return true;
    } on StripeException catch(e) {
      if(e.error.code == FailureCode.Canceled) {
        return false;
      }
      rethrow;
    }
  }

  Future<bool> pay({
    required PaymentPayloadRequest payload,
    String merchantName = const String.fromEnvironment("APP_NAME")
  }) async {
    final intent = await createPaymentIntent(payload: payload);
    if(intent == null) return false;

    await initPaymentSheet(
      clientSecret: intent.clientSecret,
      customerId: intent.customerId,
      ephemeraKey: intent.ephemeralKey,
      merchantName: merchantName,
    );

    final ok = await presentPaymentSheet();
    return ok;
  }
  
}