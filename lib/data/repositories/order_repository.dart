import 'package:dio/dio.dart';

import '../../core/api/api_client.dart';
import '../../core/config/api_config.dart';
import '../models/order_models.dart';

class OrderRepository {
  OrderRepository({required ApiClient client}) : _client = client;

  final ApiClient _client;

  Future<Order> getOrder(int id) async {
    final res = await _client.get<Map<String, dynamic>>('/v1/orders/$id');
    return Order.fromJson(res.data!);
  }

  Future<CheckoutResult> checkout({
    required String storeSlug,
    required List<Map<String, dynamic>> lines,
    String fulfillmentType = 'pickup',
    String paymentProvider = ApiConfig.paymentProviderStub,
    required String idempotencyKey,
  }) async {
    final res = await _client.post<Map<String, dynamic>>(
      '/v1/stores/$storeSlug/checkout',
      data: {
        'lines': lines,
        'fulfillment_type': fulfillmentType,
        'payment_provider': paymentProvider,
      },
      options: Options(
        headers: {'Idempotency-Key': idempotencyKey},
      ),
    );
    return CheckoutResult.fromJson(res.data!);
  }
}
