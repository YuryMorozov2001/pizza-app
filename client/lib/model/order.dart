import '../const/enums.dart';
import '../extension/extensions.dart';

class Order {
  String id;
  Map items;
  OrderStatus status;

  Order({
    required this.id,
    required this.items,
    this.status = OrderStatus.creationInProggress,
  });

  factory Order.fromJson(json) {
    return Order(
      id: json['_id'],
      items: json['order'].toString().toMap(),
      status: json['status'].toString().toOrderStatus(),
    );
  }
}

