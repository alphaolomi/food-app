import 'store_models.dart';

class CatalogItem {
  const CatalogItem({
    required this.id,
    required this.categoryId,
    required this.name,
    this.description,
    required this.priceCents,
    required this.isAvailable,
  });

  final int id;
  final int categoryId;
  final String name;
  final String? description;
  final int priceCents;
  final bool isAvailable;

  factory CatalogItem.fromJson(Map<String, dynamic> json) {
    return CatalogItem(
      id: json['id'] as int,
      categoryId: json['category_id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      priceCents: json['price_cents'] as int,
      isAvailable: json['is_available'] as bool? ?? true,
    );
  }
}

class CatalogCategory {
  const CatalogCategory({
    required this.id,
    required this.name,
    required this.position,
    required this.items,
  });

  final int id;
  final String name;
  final int position;
  final List<CatalogItem> items;

  factory CatalogCategory.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'];
    final items = <CatalogItem>[];
    if (rawItems is List) {
      for (final e in rawItems) {
        if (e is Map<String, dynamic>) {
          items.add(CatalogItem.fromJson(e));
        }
      }
    }
    return CatalogCategory(
      id: json['id'] as int,
      name: json['name'] as String,
      position: json['position'] as int? ?? 0,
      items: items,
    );
  }
}

class StoreCatalog {
  const StoreCatalog({required this.store, required this.categories});

  final StoreSummary store;
  final List<CatalogCategory> categories;

  factory StoreCatalog.fromJson(Map<String, dynamic> json) {
    final storeJson = json['store'] as Map<String, dynamic>?;
    final store = storeJson != null
        ? StoreSummary.fromJson(storeJson)
        : throw const FormatException('Missing store');

    final rawCats = json['categories'];
    final categories = <CatalogCategory>[];
    if (rawCats is List) {
      for (final e in rawCats) {
        if (e is Map<String, dynamic>) {
          categories.add(CatalogCategory.fromJson(e));
        }
      }
    }
    return StoreCatalog(store: store, categories: categories);
  }
}
