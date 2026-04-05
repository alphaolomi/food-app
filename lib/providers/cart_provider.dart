import 'package:flutter/foundation.dart';

import '../data/models/catalog_models.dart';

class CartLine {
  CartLine({required this.item, required this.quantity});

  CatalogItem item;
  int quantity;
}

class CartProvider extends ChangeNotifier {
  String? _storeSlug;
  final Map<int, CartLine> _lines = {};

  String? get storeSlug => _storeSlug;

  bool get isEmpty => _lines.isEmpty;

  List<CartLine> get lines => _lines.values.toList(growable: false);

  int get totalQuantity => _lines.values.fold(0, (a, b) => a + b.quantity);

  int get totalCents => _lines.values.fold(
        0,
        (sum, line) => sum + line.item.priceCents * line.quantity,
      );

  /// Call when opening a store menu; clears cart if switching stores.
  void bindStore(String slug) {
    if (_storeSlug != slug) {
      _lines.clear();
      _storeSlug = slug;
      notifyListeners();
    }
  }

  void addItem(CatalogItem item, {int quantity = 1}) {
    if (_storeSlug == null) return;
    final existing = _lines[item.id];
    if (existing != null) {
      existing.quantity += quantity;
    } else {
      _lines[item.id] = CartLine(item: item, quantity: quantity);
    }
    notifyListeners();
  }

  void setQuantity(int catalogItemId, int quantity) {
    if (quantity <= 0) {
      _lines.remove(catalogItemId);
    } else {
      final line = _lines[catalogItemId];
      if (line != null) line.quantity = quantity;
    }
    notifyListeners();
  }

  void removeLine(int catalogItemId) {
    _lines.remove(catalogItemId);
    notifyListeners();
  }

  void clear() {
    _lines.clear();
    _storeSlug = null;
    notifyListeners();
  }

  List<Map<String, dynamic>> toCheckoutPayload() {
    return _lines.values
        .map((l) => {'catalog_item_id': l.item.id, 'quantity': l.quantity})
        .toList();
  }
}
