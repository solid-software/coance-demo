import '../common/money.dart';

/// The receipt line for a visit, with what can still be refunded.
String receiptText({required Money charged, required Money refundable}) {
  if (!refundable.isPositive) return 'Paid $charged.';

  return 'Paid $charged. Up to $refundable can still be refunded.';
}
