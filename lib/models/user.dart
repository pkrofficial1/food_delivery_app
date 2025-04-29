import '/models/address.dart';
import '/models/payment_method.dart';
import '/models/order.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final List<Address> addresses;
  final List<PaymentMethod> paymentMethods;
  final List<Order> orders;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.addresses,
    required this.paymentMethods,
    required this.orders,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    List<Address>? addresses,
    List<PaymentMethod>? paymentMethods,
    List<Order>? orders,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      addresses: addresses ?? this.addresses,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      orders: orders ?? this.orders,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'addresses': addresses.map((address) => address.toJson()).toList(),
      'paymentMethods':
          paymentMethods.map((method) => method.toJson()).toList(),
      'orders': orders.map((order) => order.toJson()).toList(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      addresses:
          (json['addresses'] as List)
              .map((address) => Address.fromJson(address))
              .toList(),
      paymentMethods:
          (json['paymentMethods'] as List)
              .map((method) => PaymentMethod.fromJson(method))
              .toList(),
      orders:
          (json['orders'] as List)
              .map((order) => Order.fromJson(order))
              .toList(),
    );
  }
}
