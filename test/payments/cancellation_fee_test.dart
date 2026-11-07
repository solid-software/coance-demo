import 'package:acme_health/appointments/cancellation.dart';
import 'package:acme_health/payments/cancellation_fee.dart';
import 'package:test/test.dart';

void main() {
  test('an in-time cancellation has no fee', () {
    expect(CancellationKind.inTime, isNot(CancellationKind.late));
  });

  test('a no-show costs more than a late cancellation', () {
    expect(
      CancellationFeeService.noShowFee > CancellationFeeService.lateFee,
      isTrue,
    );
  });
}
