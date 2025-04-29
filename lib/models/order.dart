import '/models/cart_item.dart';
import '/models/address.dart';
import '/models/payment_method.dart';

enum OrderStatus { pending, preparing, onTheWay, delivered, cancelled }

class Order {
  final String id;
  final String restaurantId;
  final String restaurantName;
  final List<CartItem> items;
  final OrderStatus status;
  final double total;
  final double deliveryFee;
  final String date;
  final Address address;
  final PaymentMethod paymentMethod;
  final String? estimatedDeliveryTime;

  Order({
    required this.id,
    required this.restaurantId,
    required this.restaurantName,
    required this.items,
    required this.status,
    required this.total,
    required this.deliveryFee,
    required this.date,
    required this.address,
    required this.paymentMethod,
    this.estimatedDeliveryTime,
  });

  Order copyWith({
    String? id,
    String? restaurantId,
    String? restaurantName,
    List<CartItem>? items,
    OrderStatus? status,
    double? total,
    double? deliveryFee,
    String? date,
    Address? address,
    PaymentMethod? paymentMethod,
    String? estimatedDeliveryTime,
  }) {
    return Order(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      restaurantName: restaurantName ?? this.restaurantName,
      items: items ?? this.items,
      status: status ?? this.status,
      total: total ?? this.total,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      date: date ?? this.date,
      address: address ?? this.address,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      estimatedDeliveryTime:
          estimatedDeliveryTime ?? this.estimatedDeliveryTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'items': items.map((item) => item.toJson()).toList(),
      'status': status.toString().split('.').last,
      'total': total,
      'deliveryFee': deliveryFee,
      'date': date,
      'address': address.toJson(),
      'paymentMethod': paymentMethod.toJson(),
      'estimatedDeliveryTime': estimatedDeliveryTime,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      restaurantId: json['restaurantId'],
      restaurantName: json['restaurantName'],
      items:
          (json['items'] as List)
              .map((item) => CartItem.fromJson(item))
              .toList(),
      status: OrderStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => OrderStatus.pending,
      ),
      total: json['total'].toDouble(),
      deliveryFee: json['deliveryFee'].toDouble(),
      date: json['date'],
      address: Address.fromJson(json['address']),
      paymentMethod: PaymentMethod.fromJson(json['paymentMethod']),
      estimatedDeliveryTime: json['estimatedDeliveryTime'],
    );
  }
}
