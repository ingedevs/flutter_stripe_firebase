import 'package:dio/dio.dart';
import 'package:fl_stripe/config/constants.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  static Future<StripeResponse> createPaymentIntent({
    required String paymentMethodId,
    required dynamic amount,
    required String currency,
  }) async {
    try {
      final dio = Dio();

      final uri = Uri.parse(stripePaymentIntentUrl);

      final res = await dio.postUri(uri, data: {
        'paymentMethodId': paymentMethodId,
        'amount': amount,
        'currency': currency,
        'useStripeSdk': true,
      });
      return StripeResponse.fromJson(res.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        throw const StripeException(
          error: LocalizedErrorMessage(
            code: FailureCode.Failed,
            message: 'Ups! Something went wrong with the payment.',
          ),
        );
      }

      throw StripeException(
        error: LocalizedErrorMessage(
          code: FailureCode.Failed,
          message: e.message,
        ),
      );
    }
  }
}

class StripeResponse {
  final String? clientSecret;
  final bool? requiresAction;
  final String? status;
  final String? error;

  StripeResponse({
    this.clientSecret,
    this.requiresAction,
    this.status,
    this.error,
  });

  factory StripeResponse.fromJson(Map<String, dynamic> json) {
    return StripeResponse(
      clientSecret: json['clientSecret'],
      requiresAction: json['requiresAction'],
      status: json['status'],
      error: json['error'],
    );
  }

  @override
  String toString() {
    return 'StripeResponse(clientSecret: $clientSecret, requiresAction: $requiresAction, status: $status, error: $error)';
  }
}
