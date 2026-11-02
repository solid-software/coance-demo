import '../common/money.dart';
import 'stripe_client.dart';

/// The result of charging a patient for a visit.
sealed class ChargeResult {}

class Charged extends ChargeResult {
  final String paymentIntentId;
  Charged(this.paymentIntentId);
}

class Declined extends ChargeResult {
  final String reason;
  Declined(this.reason);
}

/// Charges a patient's saved card for a completed visit.
class ChargeService {
  final StripeClient _stripe;

  ChargeService(this._stripe);

  /// Charges [amount] for [visitId]. The visit id is the idempotency key, so
  /// a retried request never charges the patient twice.
  Future<ChargeResult> chargeVisit({
    required String visitId,
    required String customerId,
    required String paymentMethodId,
    required Money amount,
  }) async {
    if (!amount.isPositive) {
      throw ArgumentError.value(amount, 'amount', 'must be positive');
    }
    try {
      final intent = await _stripe.post('payment_intents', {
        'amount': '${amount.minorUnits}',
        'currency': amount.currency,
        'customer': customerId,
        'payment_method': paymentMethodId,
        'confirm': 'true',
        'off_session': 'true',
        'metadata[visit_id]': visitId,
      }, idempotencyKey: 'visit-$visitId');

      return Charged(intent['id']! as String);
    } on StripeError catch (error) {
      if (error.isDecline) return Declined(error.code);
      rethrow;
    }
  }
}
