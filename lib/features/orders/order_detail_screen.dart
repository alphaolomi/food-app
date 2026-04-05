import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/api/api_exception.dart';
import '../../core/format/money_format.dart';
import '../../data/models/order_models.dart';
import '../../data/repositories/order_repository.dart';
import '../../widgets/app_svg_icon.dart';
import '../../widgets/food_icons.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({
    super.key,
    required this.orderId,
    this.initialOrder,
  });

  final int orderId;
  final Order? initialOrder;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late Future<Order> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.initialOrder != null
        ? Future.value(widget.initialOrder!)
        : context.read<OrderRepository>().getOrder(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppSvgIcon(FoodIcons.receipt, size: 26),
      ),
      body: FutureBuilder<Order>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            final msg = snap.error is ApiException
                ? (snap.error! as ApiException).message
                : snap.error.toString();
            return Center(child: Text(msg));
          }
          final order = snap.data!;
          final created = order.createdAt != null
              ? DateFormat.yMMMd().add_jm().format(order.createdAt!.toLocal())
              : null;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Order #${order.id}', style: Theme.of(context).textTheme.headlineSmall),
              if (created != null) Text(created, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 8),
              Chip(label: Text(order.status)),
              Chip(label: Text(order.fulfillmentType)),
              const SizedBox(height: 16),
              Text('Items', style: Theme.of(context).textTheme.titleMedium),
              ...order.lines.map(
                (l) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l.item?.name ?? 'Item #${l.catalogItemId}'),
                  subtitle: Text('${l.quantity} × ${formatMoneyCents(l.unitPriceCents)}'),
                  trailing: Text(formatMoneyCents(l.lineTotalCents)),
                ),
              ),
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Total'),
                trailing: Text(
                  formatMoneyCents(order.totalCents),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              if (order.payments.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text('Payment', style: Theme.of(context).textTheme.titleMedium),
                ...order.payments.map(
                  (p) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(p.provider),
                    subtitle: Text(p.status),
                    trailing: Text(formatMoneyCents(p.amountCents)),
                  ),
                ),
              ],
              if (order.tickets.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text('Kitchen tickets', style: Theme.of(context).textTheme.titleMedium),
                ...order.tickets.map(
                  (t) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.receipt_long),
                    title: Text('Ticket #${t.id}'),
                    subtitle: Text(t.status),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
