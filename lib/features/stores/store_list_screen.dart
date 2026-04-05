import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/store_models.dart';
import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/stores_provider.dart';
import '../../widgets/app_svg_icon.dart';
import '../../widgets/food_icons.dart';
import '../cart/cart_screen.dart';
import '../catalog/catalog_screen.dart';

class StoreListScreen extends StatefulWidget {
  const StoreListScreen({super.key});

  @override
  State<StoreListScreen> createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StoresProvider>().load();
    });
  }

  Future<void> _openCart() async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(builder: (_) => const CartScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final stores = context.watch<StoresProvider>();
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const AppSvgIcon(FoodIcons.store, size: 28),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                onPressed: cart.isEmpty ? null : _openCart,
                icon: const AppSvgIcon(FoodIcons.cart, size: 26),
              ),
              if (cart.totalQuantity > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: IgnorePointer(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.error,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                      child: Text(
                        '${cart.totalQuantity}',
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          PopupMenuButton<String>(
            onSelected: (v) async {
              if (v == 'logout') {
                await context.read<AuthProvider>().logout();
                if (context.mounted) {
                  context.read<CartProvider>().clear();
                }
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'profile',
                enabled: false,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const AppSvgIcon(FoodIcons.person, size: 22),
                  title: Text(auth.user?.name ?? ''),
                  subtitle: Text(auth.user?.email ?? ''),
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'logout',
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.logout),
                  title: Text('Log out'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<StoresProvider>().refresh(),
        child: _StoreBody(stores: stores, onSelect: _openStore),
      ),
    );
  }

  void _openStore(StoreSummary store) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => CatalogScreen(store: store),
      ),
    );
  }
}

class _StoreBody extends StatelessWidget {
  const _StoreBody({required this.stores, required this.onSelect});

  final StoresProvider stores;
  final void Function(StoreSummary) onSelect;

  @override
  Widget build(BuildContext context) {
    if (stores.loading && stores.stores.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (stores.error != null && stores.stores.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.5,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cloud_off, size: 48),
                    const SizedBox(height: 12),
                    Text(stores.error!, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
    if (stores.stores.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(height: 120),
          Center(child: Text('No stores yet.')),
        ],
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: stores.stores.length,
      itemBuilder: (context, i) {
        final s = stores.stores[i];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: AppSvgIcon(
                FoodIcons.forkKnife,
                size: 22,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            title: Text(s.name),
            subtitle: Text(s.organization?.name ?? s.slug),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => onSelect(s),
          ),
        );
      },
    );
  }
}
