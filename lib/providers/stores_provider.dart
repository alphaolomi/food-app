import 'package:flutter/foundation.dart';

import '../core/api/api_exception.dart';
import '../data/models/store_models.dart';
import '../data/repositories/store_repository.dart';

class StoresProvider extends ChangeNotifier {
  StoresProvider({required StoreRepository repository}) : _repository = repository;

  final StoreRepository _repository;

  List<StoreSummary> _stores = [];
  bool _loading = false;
  String? _error;

  List<StoreSummary> get stores => _stores;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> load() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final page = await _repository.listStores();
      _stores = page.items;
      _error = null;
    } on ApiException catch (e) {
      _error = e.message;
      _stores = [];
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> refresh() => load();
}
