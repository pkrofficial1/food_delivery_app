import 'package:flutter/material.dart';
import '/models/user.dart';
import '/models/address.dart';
import '/models/payment_method.dart';
import '/models/order.dart';
import '/data/mock_data.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUser() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // In a real app, this would be an API call
      // For now, we'll use mock data
      await Future.delayed(const Duration(milliseconds: 500));
      _user = MockData.user;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = "Failed to fetch user data";
      _isLoading = false;
      notifyListeners();
    }
  }

  void addAddress(Address newAddress) {
    if (_user == null) return;

    final address = Address(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: newAddress.title,
      address: newAddress.address,
      isDefault: _user!.addresses.isEmpty ? true : newAddress.isDefault,
    );

    _user = _user!.copyWith(addresses: [..._user!.addresses, address]);
    notifyListeners();
  }

  void updateAddress(Address updatedAddress) {
    if (_user == null) return;

    final updatedAddresses =
        _user!.addresses.map((address) {
          return address.id == updatedAddress.id ? updatedAddress : address;
        }).toList();

    _user = _user!.copyWith(addresses: updatedAddresses);
    notifyListeners();
  }

  void removeAddress(String addressId) {
    if (_user == null) return;

    final updatedAddresses =
        _user!.addresses.where((address) => address.id != addressId).toList();

    // If we removed the default address and there are other addresses,
    // make the first one the default
    if (_user!.addresses.any((a) => a.id == addressId && a.isDefault) &&
        updatedAddresses.isNotEmpty) {
      updatedAddresses[0] = updatedAddresses[0].copyWith(isDefault: true);
    }

    _user = _user!.copyWith(addresses: updatedAddresses);
    notifyListeners();
  }

  void setDefaultAddress(String addressId) {
    if (_user == null) return;

    final updatedAddresses =
        _user!.addresses.map((address) {
          return address.copyWith(isDefault: address.id == addressId);
        }).toList();

    _user = _user!.copyWith(addresses: updatedAddresses);
    notifyListeners();
  }

  void addPaymentMethod(PaymentMethod newPaymentMethod) {
    if (_user == null) return;

    final paymentMethod = PaymentMethod(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: newPaymentMethod.type,
      title: newPaymentMethod.title,
      lastFour: newPaymentMethod.lastFour,
      isDefault:
          _user!.paymentMethods.isEmpty ? true : newPaymentMethod.isDefault,
    );

    _user = _user!.copyWith(
      paymentMethods: [..._user!.paymentMethods, paymentMethod],
    );
    notifyListeners();
  }

  void updatePaymentMethod(PaymentMethod updatedPaymentMethod) {
    if (_user == null) return;

    final updatedPaymentMethods =
        _user!.paymentMethods.map((paymentMethod) {
          return paymentMethod.id == updatedPaymentMethod.id
              ? updatedPaymentMethod
              : paymentMethod;
        }).toList();

    _user = _user!.copyWith(paymentMethods: updatedPaymentMethods);
    notifyListeners();
  }

  void removePaymentMethod(String paymentMethodId) {
    if (_user == null) return;

    final updatedPaymentMethods =
        _user!.paymentMethods
            .where((paymentMethod) => paymentMethod.id != paymentMethodId)
            .toList();

    // If we removed the default payment method and there are other payment methods,
    // make the first one the default
    if (_user!.paymentMethods.any(
          (p) => p.id == paymentMethodId && p.isDefault,
        ) &&
        updatedPaymentMethods.isNotEmpty) {
      updatedPaymentMethods[0] = updatedPaymentMethods[0].copyWith(
        isDefault: true,
      );
    }

    _user = _user!.copyWith(paymentMethods: updatedPaymentMethods);
    notifyListeners();
  }

  void setDefaultPaymentMethod(String paymentMethodId) {
    if (_user == null) return;

    final updatedPaymentMethods =
        _user!.paymentMethods.map((paymentMethod) {
          return paymentMethod.copyWith(
            isDefault: paymentMethod.id == paymentMethodId,
          );
        }).toList();

    _user = _user!.copyWith(paymentMethods: updatedPaymentMethods);
    notifyListeners();
  }

  void addOrder(Order newOrder) {
    if (_user == null) return;

    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      restaurantId: newOrder.restaurantId,
      restaurantName: newOrder.restaurantName,
      items: newOrder.items,
      status: newOrder.status,
      total: newOrder.total,
      deliveryFee: newOrder.deliveryFee,
      date: DateTime.now().toIso8601String(),
      address: newOrder.address,
      paymentMethod: newOrder.paymentMethod,
      estimatedDeliveryTime: newOrder.estimatedDeliveryTime,
    );

    _user = _user!.copyWith(orders: [order, ..._user!.orders]);
    notifyListeners();
  }
}
