import '../../core/api/api_client.dart';
import '../models/catalog_models.dart';
import '../models/store_models.dart';

class StoreRepository {
  StoreRepository({required ApiClient client}) : _client = client;

  final ApiClient _client;

  Future<PaginatedStores> listStores({int perPage = 50}) async {
    final res = await _client.get<Map<String, dynamic>>(
      '/v1/stores',
      queryParameters: {'per_page': perPage},
    );
    return PaginatedStores.fromJson(res.data!);
  }

  Future<StoreCatalog> fetchCatalog(String storeSlug) async {
    final res = await _client.get<Map<String, dynamic>>('/v1/stores/$storeSlug/catalog');
    return StoreCatalog.fromJson(res.data!);
  }
}
