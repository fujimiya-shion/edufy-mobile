import 'package:edufy_mobile/src/core/dependencies/ioc.dart';
import 'package:edufy_mobile/src/core/services/payment/stripe_payment_service.dart';
import 'package:edufy_mobile/src/data/dtos/payment/payment_dto.dart';
import 'package:edufy_mobile/src/shared/enums/enums.dart';

class PaymentGatewayService {
  Future<bool> pay({ required PaymentPayloadRequest payload, required String provider }) async {
    // Sau này đổi lại thành strategy pattern
    if(provider == PaymentProviders.stripe.name) {
      final gateway = locator.get<StripePaymentService>();
      return await gateway.pay(payload: payload);
    }
    return false;
  }
}