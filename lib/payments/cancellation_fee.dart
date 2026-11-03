import '../appointments/cancellation.dart';
import '../common/money.dart';
import 'charge_service.dart';

/// Charges the fee for a late cancellation or a no-show.
class CancellationFeeService {
  /// The fee for a late cancellation, in the visit's currency.
  static const lateFee = Money(1500, 'usd');

  /// The fee for a no-show.
  static const noShowFee = Money(3000, 'usd');

  final ChargeService _charges;

  CancellationFeeService(this._charges);

  /// Charges the fee [kind] calls for, or nothing for an in-time
  /// cancellation. The visit id keeps a retry from charging twice.
  Future<ChargeResult?> charge({
    required CancellationKind kind,
    required String visitId,
    required String customerId,
    required String paymentMethodId,
  }) async {
    final fee = switch (kind) {
      CancellationKind.inTime => null,
      CancellationKind.late => lateFee,
      CancellationKind.noShow => noShowFee,
    };
    if (fee == null) return null;

    return _charges.chargeVisit(
      visitId: 'cancel-$visitId',
      customerId: customerId,
      paymentMethodId: paymentMethodId,
      amount: fee,
    );
  }
}
