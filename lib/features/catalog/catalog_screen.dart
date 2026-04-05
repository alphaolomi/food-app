import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/api/api_exception.dart';
import '../../core/format/money_format.dart';
import '../../data/models/catalog_models.dart';
import '../../data/models/store_models.dart';
import '../../data/repositories/store_repository.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/app_svg_icon.dart';
import '../../widgets/food_icons.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key, required this.store});

  final StoreSummary store;

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late Future<StoreCatalog> _future;

  @override
  void initState() {
    super.initState();
    context.read<CartProvider>().bindStore(widget.store.slug);
    _future = context.read<StoreRepository>().fetchCatalog(widget.store.slug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.store.name),
      ),
      body: FutureBuilder<StoreCatalog>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            final msg = snap.error is ApiException
                ? (snap.error! as ApiException).message
                : snap.error.toString();
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 12),
                    Text(msg, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {
                        setState(() {
                          _future = context.read<StoreRepository>().fetchCatalog(widget.store.slug);
                        });
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }
          final catalog = snap.data!;
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 24),
            itemCount: catalog.categories.length,
            itemBuilder: (context, i) {
              final cat = catalog.categories[i];
              return _CategorySection(category: cat);
            },
          );
        },
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({required this.category});

  final CatalogCategory category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              const AppSvgIcon(FoodIcons.forkKnife, size: 20),
              const SizedBox(width: 8),
              Text(
                category.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        ...category.items.map((item) => _ItemTile(item: item)),
      ],
    );
  }
}

class _ItemTile extends StatelessWidget {
  const _ItemTile({required this.item});

  final CatalogItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        title: Text(item.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formatMoneyCents(item.priceCents),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            if (item.description != null && item.description!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(item.description!, maxLines: 2, overflow: TextOverflow.ellipsis),
              ),
          ],
        ),
        trailing: IconButton.filledTonal(
          onPressed: () {
            context.read<CartProvider>().addItem(item);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Added ${item.name}')),
            );
          },
          icon: const Icon(Icons.add_shopping_cart_outlined),
        ),
      ),
    );
  }
}
