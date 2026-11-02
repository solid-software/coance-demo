import '../common/money.dart';
import 'stripe_client.dart';

/// Refunds all or part of a visit's charge.
class RefundService {
  final StripeClient _stripe;

  RefundService(this._stripe);

  /// Refunds [amount] of the charge [paymentIntentId]. [alreadyRefunded] is
  /// what earlier refunds returned, so the total never exceeds [charged].
  Future<String> refund({
    required String paymentIntentId,
    required Money charged,
    required Money alreadyRefunded,
    required Money amount,
    required String requestId,
  }) async {
    final remaining = charged - alreadyRefunded;
    if (!amount.isPositive || amount > remaining) {
      throw ArgumentError.value(
        amount,
        'amount',
        'must be positive and at most the $remaining not yet refunded',
      );
    }
    final refund = await _stripe.post('refunds', {
      'payment_intent': paymentIntentId,
      'amount': '${amount.minorUnits}',
    }, idempotencyKey: 'refund-$requestId');

    return refund['id']! as String;
  }
}
