import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/api/api_client.dart';
import '../core/api/token_storage.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/order_repository.dart';
import '../data/repositories/store_repository.dart';
import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/stores_provider.dart';
import 'food_material_app.dart';
import 'session_binder.dart';

class FoodAppRoot extends StatelessWidget {
  const FoodAppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = TokenStorage();
    final api = ApiClient(tokenStorage: storage);
    final authRepo = AuthRepository(client: api, storage: storage);
    final storeRepo = StoreRepository(client: api);
    final orderRepo = OrderRepository(client: api);

    return MultiProvider(
      providers: [
        Provider<TokenStorage>.value(value: storage),
        Provider<ApiClient>.value(value: api),
        Provider<AuthRepository>.value(value: authRepo),
        Provider<StoreRepository>.value(value: storeRepo),
        Provider<OrderRepository>.value(value: orderRepo),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(repository: authRepo)..bootstrap(),
        ),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(
          create: (_) => StoresProvider(repository: storeRepo),
        ),
      ],
      child: const SessionBinder(
        child: FoodMaterialApp(),
      ),
    );
  }
}
