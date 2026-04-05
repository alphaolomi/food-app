import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../core/api/api_exception.dart';
import '../../core/config/api_config.dart';
import '../../core/format/money_format.dart';
import '../../data/repositories/order_repository.dart';
import '../../providers/cart_provider.dart';
import '../orders/order_detail_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _submitting = false;
  String _fulfillment = 'pickup';

  Future<void> _checkout() async {
    final cart = context.read<CartProvider>();
    final slug = cart.storeSlug;
    if (slug == null || cart.isEmpty) return;

    setState(() => _submitting = true);
    try {
      final idem = Uuid().v4();
      final result = await context.read<OrderRepository>().checkout(
            storeSlug: slug,
            lines: cart.toCheckoutPayload(),
            fulfillmentType: _fulfillment,
            paymentProvider: ApiConfig.paymentProviderStub,
            idempotencyKey: idem,
          );
      if (!mounted) return;
      cart.clear();
      await Navigator.of(context).pushReplacement<void, void>(
        MaterialPageRoute<void>(
          builder: (_) => OrderDetailScreen(orderId: result.order.id, initialOrder: result.order),
        ),
      );
    } on ApiException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: cart.isEmpty
          ? const Center(child: Text('Your cart is empty.'))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Fulfillment', style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 8),
                      SegmentedButton<String>(
                        segments: const [
                          ButtonSegment(value: 'pickup', label: Text('Pickup'), icon: Icon(Icons.storefront)),
                          ButtonSegment(value: 'delivery', label: Text('Delivery'), icon: Icon(Icons.delivery_dining)),
                        ],
                        selected: {_fulfillment},
                        onSelectionChanged: (s) => setState(() => _fulfillment = s.first),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.lines.length,
                    itemBuilder: (context, i) {
                      final line = cart.lines[i];
                      return ListTile(
                        title: Text(line.item.name),
                        subtitle: Text('${formatMoneyCents(line.item.priceCents)} × ${line.quantity}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                context.read<CartProvider>().setQuantity(line.item.id, line.quantity - 1);
                              },
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text('${line.quantity}'),
                            IconButton(
                              onPressed: () {
                                context.read<CartProvider>().setQuantity(line.item.id, line.quantity + 1);
                              },
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Total ${formatMoneyCents(cart.totalCents)}',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed: _submitting ? null : _checkout,
                          child: _submitting
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Text('Place order'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
