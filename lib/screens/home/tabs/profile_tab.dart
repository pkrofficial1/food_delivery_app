import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/user_provider.dart';
import '/providers/auth_provider.dart';
import '/screens/auth/login_screen.dart';
import '/screens/order/order_details_screen.dart';
import '/widgets/order_card.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          final user = userProvider.user;

          if (user == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () => userProvider.fetchUser(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Text(
                              user.name
                                  .split(' ')
                                  .map((name) => name[0])
                                  .join(''),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  user.email,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color
                                        ?.withOpacity(0.7),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  user.phone,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color
                                        ?.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Recent Orders',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    if (user.orders.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            "You haven't placed any orders yet.",
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color?.withOpacity(0.7),
                            ),
                          ),
                        ),
                      )
                    else
                      Column(
                        children: [
                          ...user.orders
                              .take(2)
                              .map(
                                (order) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: OrderCard(
                                    order: order,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => OrderDetailsScreen(
                                                orderId: order.id,
                                              ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                          if (user.orders.length > 2)
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: OutlinedButton(
                                onPressed: () {
                                  // Navigate to all orders screen
                                },
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 48),
                                ),
                                child: const Text('View All Orders'),
                              ),
                            ),
                        ],
                      ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Account Settings',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.location_on_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: const Text('Saved Addresses'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              // Navigate to addresses screen
                            },
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: Icon(
                              Icons.credit_card_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: const Text('Payment Methods'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              // Navigate to payment methods screen
                            },
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: Icon(
                              Icons.favorite_outline,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: const Text('Favorites'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              // Navigate to favorites screen
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'More Options',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.help_outline,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: const Text('Help & Support'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              // Navigate to help screen
                            },
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: Icon(
                              Icons.settings_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: const Text('Settings'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              // Navigate to settings screen
                            },
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: Icon(
                              Icons.logout,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            title: Text(
                              'Logout',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                            onTap: () {
                              // Show logout confirmation dialog
                              showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      title: const Text('Logout'),
                                      content: const Text(
                                        'Are you sure you want to logout?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed:
                                              () => Navigator.pop(context),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Provider.of<AuthProvider>(
                                              context,
                                              listen: false,
                                            ).logout();
                                            Navigator.of(
                                              context,
                                            ).pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                builder:
                                                    (_) => const LoginScreen(),
                                              ),
                                              (route) => false,
                                            );
                                          },
                                          child: Text(
                                            'Logout',
                                            style: TextStyle(
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.error,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
