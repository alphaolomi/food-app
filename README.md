# foodapp

Customer **Flutter** app (**Android** + **iOS** only) — `dev.alphaolomi.foodapp`.

Connects to **`food-server`** Sanctum API under `/api/v1`: auth, store directory, catalog, cart, checkout with **`Idempotency-Key`** ([`uuid`](https://pub.dev/packages/uuid)), and order details.

## Stack

| Package | Role |
|--------|------|
| [`provider`](https://pub.dev/packages/provider) | `AuthProvider`, `CartProvider`, `StoresProvider` |
| [`dio`](https://pub.dev/packages/dio) | HTTP + JSON |
| [`flutter_secure_storage`](https://pub.dev/packages/flutter_secure_storage) | Bearer token |
| [`flutter_svg`](https://pub.dev/packages/flutter_svg) | In-app icons in `assets/icons/` |
| [`intl`](https://pub.dev/packages/intl) | Money + order timestamps |
| [`uuid`](https://pub.dev/packages/uuid) | Checkout idempotency keys |

Not used (by request): Riverpod, go_router, GetX, Bloc.

## Configure API URL

```bash
# Android emulator → machine localhost
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000/api

# iOS simulator
flutter run --dart-define=API_BASE_URL=http://127.0.0.1:8000/api
```

Debug builds allow **cleartext HTTP** on Android (`debug/AndroidManifest`) and **local networking** on iOS (`Info.plist`).

## CLI: launcher icon

```bash
dart run tool/generate_app_icon.dart   # writes assets/branding/app_icon.png
dart run flutter_launcher_icons        # applies to Android + iOS
```

## Run / test

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

## Flow

1. **Login** / **Register** → token stored securely.  
2. **Stores** → open **Catalog** (cart is scoped per store).  
3. **Cart** → pickup/delivery → **Place order** (stub payment provider).  
4. **Order** summary with lines, payments, tickets.
