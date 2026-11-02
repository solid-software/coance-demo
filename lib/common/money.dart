/// An amount in the smallest unit of its currency, such as cents.
class Money {
  final int minorUnits;
  final String currency;

  const Money(this.minorUnits, this.currency);

  bool get isPositive => minorUnits > 0;

  Money operator -(Money other) {
    _checkCurrency(other);
    return Money(minorUnits - other.minorUnits, currency);
  }

  bool operator >(Money other) {
    _checkCurrency(other);
    return minorUnits > other.minorUnits;
  }

  void _checkCurrency(Money other) {
    if (other.currency != currency) {
      throw ArgumentError('Cannot combine $currency and ${other.currency}');
    }
  }

  @override
  String toString() =>
      '${(minorUnits / 100).toStringAsFixed(2)} ${currency.toUpperCase()}';
}
