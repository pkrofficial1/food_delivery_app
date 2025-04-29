import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/cart_provider.dart';
import '/providers/user_provider.dart';
import '/models/address.dart';
import '/models/payment_method.dart';
import '/models/order.dart';
import '/screens/order/order_tracking_screen.dart';
import '/widgets/address_card.dart';
import '/widgets/payment_method_card.dart';
import '/widgets/custom_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Address? _selectedAddress;
  PaymentMethod? _selectedPaymentMethod;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = userProvider.user;

      if (user != null) {
        setState(() {
          _selectedAddress = user.addresses.firstWhere(
            (a) => a.isDefault,
            orElse: () => user.addresses.first,
          );

          _selectedPaymentMethod = user.paymentMethods.firstWhere(
            (p) => p.isDefault,
            orElse: () => user.paymentMethods.first,
          );
        });
      }
    });
  }

  void _placeOrder() {
    if (_selectedAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a delivery address')),
      );
      return;
    }

    if (_selectedPaymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a payment method')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // Calculate totals
    final subtotal = cartProvider.getTotalPrice();
    final deliveryFee = 2.99;
    final tax = subtotal * 0.1; // 10% tax
    final total = subtotal + deliveryFee + tax;

    // Create order
    final newOrder = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      restaurantId: cartProvider.restaurantId!,
      restaurantName: cartProvider.restaurantName!,
      items: cartProvider.items,
      status: OrderStatus.pending,
      total: total,
      deliveryFee: deliveryFee,
      date: DateTime.now().toIso8601String(),
      address: _selectedAddress!,
      paymentMethod: _selectedPaymentMethod!,
      estimatedDeliveryTime: "30-45 min",
    );

    // Add order to user provider
    userProvider.addOrder(newOrder);

    // Clear cart
    cartProvider.clearCart();

    // Navigate to order tracking
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OrderTrackingScreen(orderId: newOrder.id),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Checkout')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // Calculate totals
    final subtotal = cartProvider.getTotalPrice();
    final deliveryFee = 2.99;
    final tax = subtotal * 0.1; // 10% tax
    final total = subtotal + deliveryFee + tax;

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Delivery Address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  ...user.addresses.map(
                    (address) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: AddressCard(
                        address: address,
                        isSelected: _selectedAddress?.id == address.id,
                        onTap: () {
                          setState(() {
                            _selectedAddress = address;
                          });
                        },
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      // Add new address
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add New Address'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Payment Method',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  ...user.paymentMethods.map(
                    (paymentMethod) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: PaymentMethodCard(
                        paymentMethod: paymentMethod,
                        isSelected:
                            _selectedPaymentMethod?.id == paymentMethod.id,
                        onTap: () {
                          setState(() {
                            _selectedPaymentMethod = paymentMethod;
                          });
                        },
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      // Add new payment method
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add New Payment Method'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Order Summary',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color
                                      ?.withOpacity(0.7),
                                ),
                              ),
                              Text(
                                '\$${subtotal.toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Delivery Fee',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color
                                      ?.withOpacity(0.7),
                                ),
                              ),
                              Text(
                                '\$${deliveryFee.toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tax',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color
                                      ?.withOpacity(0.7),
                                ),
                              ),
                              Text(
                                '\$${tax.toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                '\$${total.toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: CustomButton(
              text: 'Place Order',
              isLoading: _isLoading,
              onPressed: _placeOrder,
            ),
          ),
        ],
      ),
    );
  }
}
