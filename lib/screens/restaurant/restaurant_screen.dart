import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '/data/mock_data.dart';
import '/models/restaurant.dart';
import '/models/menu_item.dart';
import '/providers/cart_provider.dart';
import '/widgets/menu_item_card.dart';
import '/screens/home/tabs/cart_tab.dart';
import 'package:badges/badges.dart' as badges;

class RestaurantScreen extends StatefulWidget {
  final String restaurantId;

  const RestaurantScreen({super.key, required this.restaurantId});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  late Restaurant? restaurant;
  late List<MenuItem> menuItems;

  @override
  void initState() {
    super.initState();
    restaurant = MockData.restaurants.firstWhere(
      (r) => r.id == widget.restaurantId,
      orElse: () => throw Exception('Restaurant not found'),
    );

    menuItems =
        MockData.menuItems
            .where((item) => item.restaurantId == widget.restaurantId)
            .toList();

    // Set restaurant in cart provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (restaurant != null) {
        Provider.of<CartProvider>(
          context,
          listen: false,
        ).setRestaurant(restaurant!.id, restaurant!.name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (restaurant == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Restaurant not found')),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: restaurant!.image,
                        fit: BoxFit.cover,
                        placeholder:
                            (context, url) =>
                                Container(color: Colors.grey[300]),
                        errorWidget:
                            (context, url, error) => Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.error),
                            ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                            stops: const [0.7, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant!.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            restaurant!.rating.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(width: 16),
                          const Icon(Icons.access_time, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            restaurant!.deliveryTime,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(width: 16),
                          const Icon(Icons.monetization_on_outlined, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            restaurant!.deliveryFee,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Menu',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final menuItem = menuItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: MenuItemCard(
                      menuItem: menuItem,
                      onTap: () {
                        // Show menu item details
                      },
                      onAddToCart: () {
                        Provider.of<CartProvider>(
                          context,
                          listen: false,
                        ).addItem(menuItem, 1);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${menuItem.name} added to cart'),
                            duration: const Duration(seconds: 2),
                            action: SnackBarAction(
                              label: 'View Cart',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CartTab(),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }, childCount: menuItems.length),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                final totalItems = cartProvider.getTotalItems();

                if (totalItems == 0) {
                  return const SizedBox.shrink();
                }

                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartTab()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          badges.Badge(
                            badgeContent: Text(
                              totalItems.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            badgeStyle: const badges.BadgeStyle(
                              badgeColor: Colors.white,
                              padding: EdgeInsets.all(6),
                            ),
                            child: const Icon(Icons.shopping_bag),
                          ),
                        ],
                      ),
                      const Text(
                        'View Cart',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.arrow_forward),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
