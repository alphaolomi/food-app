class OrganizationRef {
  const OrganizationRef({required this.id, required this.name, required this.slug});

  final int id;
  final String name;
  final String slug;

  factory OrganizationRef.fromJson(Map<String, dynamic> json) {
    return OrganizationRef(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
    );
  }
}

class StoreSummary {
  const StoreSummary({
    required this.id,
    required this.name,
    required this.slug,
    required this.timezone,
    this.organization,
  });

  final int id;
  final String name;
  final String slug;
  final String timezone;
  final OrganizationRef? organization;

  factory StoreSummary.fromJson(Map<String, dynamic> json) {
    OrganizationRef? org;
    final raw = json['organization'];
    if (raw is Map<String, dynamic>) {
      org = OrganizationRef.fromJson(raw);
    }
    return StoreSummary(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      timezone: json['timezone'] as String? ?? 'UTC',
      organization: org,
    );
  }
}

class PaginatedStores {
  const PaginatedStores({required this.items, this.nextPageUrl});

  final List<StoreSummary> items;
  final String? nextPageUrl;

  factory PaginatedStores.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final list = <StoreSummary>[];
    if (data is List) {
      for (final e in data) {
        if (e is Map<String, dynamic>) {
          list.add(StoreSummary.fromJson(e));
        }
      }
    }
    final links = json['links'] as Map<String, dynamic>?;
    final next = links?['next'] as String?;
    return PaginatedStores(items: list, nextPageUrl: next);
  }
}
