import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

/// Service responsible for communicating with the backend REST API.
class ApiService {
  ApiService({http.Client? client, this.baseUrl = 'https://example.com/api'})
      : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl;

  /// Transfers [amount] of money to the given [provider].
  ///
  /// Throws an [ApiException] when the request fails or times out.
  Future<Map<String, dynamic>> transferMoney({
    required String provider,
    required double amount,
  }) async {
    final uri = Uri.parse('$baseUrl/transfer');

    try {
      final response = await _client
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'provider': provider, 'amount': amount}),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.body.isNotEmpty
            ? jsonDecode(response.body) as Map<String, dynamic>
            : <String, dynamic>{};
      } else {
        throw ApiException(
          'Failed to transfer money',
          response.statusCode,
          response.body,
        );
      }
    } on TimeoutException {
      throw ApiException('Request timed out');
    } on http.ClientException catch (e) {
      throw ApiException('Network error: $e');
    }
  }

  /// Releases any resources held by the underlying HTTP client.
  void dispose() => _client.close();
}

/// A simple exception that wraps API related errors.
class ApiException implements Exception {
  ApiException(this.message, [this.statusCode, this.body]);

  final String message;
  final int? statusCode;
  final String? body;

  @override
  String toString() {
    final code = statusCode != null ? ' (status: $statusCode)' : '';
    return 'ApiException: $message$code';
  }
}

