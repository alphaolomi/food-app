import 'catalog_models.dart';

class OrderLine {
  const OrderLine({
    required this.catalogItemId,
    required this.quantity,
    required this.unitPriceCents,
    required this.lineTotalCents,
    this.item,
  });

  final int catalogItemId;
  final int quantity;
  final int unitPriceCents;
  final int lineTotalCents;
  final CatalogItem? item;

  factory OrderLine.fromJson(Map<String, dynamic> json) {
    CatalogItem? item;
    final raw = json['item'];
    if (raw is Map<String, dynamic>) {
      item = CatalogItem.fromJson(raw);
    }
    return OrderLine(
      catalogItemId: json['catalog_item_id'] as int,
      quantity: json['quantity'] as int,
      unitPriceCents: json['unit_price_cents'] as int,
      lineTotalCents: json['line_total_cents'] as int,
      item: item,
    );
  }
}

class OrderTicket {
  const OrderTicket({required this.id, required this.status, this.station});

  final int id;
  final String status;
  final String? station;

  factory OrderTicket.fromJson(Map<String, dynamic> json) {
    return OrderTicket(
      id: json['id'] as int,
      status: json['status'] as String,
      station: json['station'] as String?,
    );
  }
}

class OrderPayment {
  const OrderPayment({
    required this.id,
    required this.provider,
    required this.status,
    required this.amountCents,
    this.externalRef,
  });

  final int id;
  final String provider;
  final String status;
  final int amountCents;
  final String? externalRef;

  factory OrderPayment.fromJson(Map<String, dynamic> json) {
    return OrderPayment(
      id: json['id'] as int,
      provider: json['provider'] as String,
      status: json['status'] as String,
      amountCents: json['amount_cents'] as int,
      externalRef: json['external_ref'] as String?,
    );
  }
}

class Order {
  const Order({
    required this.id,
    required this.storeId,
    required this.status,
    required this.totalCents,
    required this.fulfillmentType,
    required this.lines,
    required this.tickets,
    required this.payments,
    this.createdAt,
  });

  final int id;
  final int storeId;
  final String status;
  final int totalCents;
  final String fulfillmentType;
  final List<OrderLine> lines;
  final List<OrderTicket> tickets;
  final List<OrderPayment> payments;
  final DateTime? createdAt;

  factory Order.fromJson(Map<String, dynamic> json) {
    final lines = <OrderLine>[];
    final rawLines = json['lines'];
    if (rawLines is List) {
      for (final e in rawLines) {
        if (e is Map<String, dynamic>) lines.add(OrderLine.fromJson(e));
      }
    }
    final tickets = <OrderTicket>[];
    final rawTickets = json['tickets'];
    if (rawTickets is List) {
      for (final e in rawTickets) {
        if (e is Map<String, dynamic>) tickets.add(OrderTicket.fromJson(e));
      }
    }
    final payments = <OrderPayment>[];
    final rawPayments = json['payments'];
    if (rawPayments is List) {
      for (final e in rawPayments) {
        if (e is Map<String, dynamic>) payments.add(OrderPayment.fromJson(e));
      }
    }
    DateTime? created;
    final ca = json['created_at'] as String?;
    if (ca != null) {
      created = DateTime.tryParse(ca);
    }
    return Order(
      id: json['id'] as int,
      storeId: json['store_id'] as int,
      status: json['status'] as String,
      totalCents: json['total_cents'] as int,
      fulfillmentType: json['fulfillment_type'] as String? ?? 'pickup',
      lines: lines,
      tickets: tickets,
      payments: payments,
      createdAt: created,
    );
  }
}

class CheckoutResult {
  const CheckoutResult({required this.order, required this.idempotentReplay});

  final Order order;
  final bool idempotentReplay;

  factory CheckoutResult.fromJson(Map<String, dynamic> json) {
    final orderJson = json['order'] as Map<String, dynamic>?;
    if (orderJson == null) {
      throw const FormatException('Missing order');
    }
    return CheckoutResult(
      order: Order.fromJson(orderJson),
      idempotentReplay: json['idempotent_replay'] as bool? ?? false,
    );
  }
}
