import 'dart:convert';

import 'package:http/http.dart' as http;

/// A thin client for the Stripe API calls Acme Health makes.
///
/// Card numbers never reach this service: the app tokenizes cards with
/// Stripe Elements and sends us a PaymentMethod id. See
/// docs/architecture/card-data-flow.md.
class StripeClient {
  /// The API base URL, from config (`STRIPE_API_BASE`).
  final Uri baseUrl;

  final String _secretKey;
  final http.Client _http;

  StripeClient(this.baseUrl, this._secretKey, {http.Client? client})
    : _http = client ?? http.Client();

  Future<Map<String, Object?>> post(
    String path,
    Map<String, String> fields, {
    required String idempotencyKey,
  }) async {
    final response = await _http.post(
      baseUrl.resolve(path),
      headers: {
        'Authorization': 'Bearer $_secretKey',
        'Idempotency-Key': idempotencyKey,
      },
      body: fields,
    );
    final body = jsonDecode(response.body) as Map<String, Object?>;
    if (response.statusCode >= 400) throw StripeError.from(body);

    return body;
  }
}

/// An error Stripe returned, such as a declined card.
class StripeError implements Exception {
  final String code;
  final String message;

  StripeError(this.code, this.message);

  factory StripeError.from(Map<String, Object?> body) {
    final error = body['error'] as Map<String, Object?>? ?? const {};
    return StripeError(
      error['decline_code'] as String? ?? error['code'] as String? ?? 'unknown',
      error['message'] as String? ?? 'Stripe returned an error',
    );
  }

  bool get isDecline => code != 'unknown' && code != 'rate_limit';

  @override
  String toString() => 'StripeError($code): $message';
}
