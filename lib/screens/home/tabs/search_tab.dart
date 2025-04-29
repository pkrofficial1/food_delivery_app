import 'package:flutter/material.dart';
import '/data/mock_data.dart';
import '/models/restaurant.dart';
import '/models/category.dart';
import '/screens/restaurant/restaurant_screen.dart';
import '/widgets/restaurant_card.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedCategoryId;
  List<Restaurant> _filteredRestaurants = [];

  @override
  void initState() {
    super.initState();
    _filteredRestaurants = MockData.restaurants;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
      _filterRestaurants();
    });
  }

  void _filterRestaurants() {
    final query = _searchQuery.toLowerCase();

    _filteredRestaurants =
        MockData.restaurants.where((restaurant) {
          final matchesSearch = restaurant.name.toLowerCase().contains(query);
          final matchesCategory =
              _selectedCategoryId == null ||
              restaurant.categories.contains(_selectedCategoryId);
          return matchesSearch && matchesCategory;
        }).toList();
  }

  void _selectCategory(String categoryId) {
    setState(() {
      _selectedCategoryId =
          _selectedCategoryId == categoryId ? null : categoryId;
      _filterRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for restaurants or food',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon:
                      _searchQuery.isNotEmpty
                          ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                            },
                          )
                          : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: MockData.categories.length,
                itemBuilder: (context, index) {
                  final category = MockData.categories[index];
                  final isSelected = category.id == _selectedCategoryId;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(category.name),
                      selected: isSelected,
                      onSelected: (_) => _selectCategory(category.id),
                      backgroundColor: Theme.of(context).cardColor,
                      selectedColor: Theme.of(
                        context,
                      ).primaryColor.withOpacity(0.2),
                      checkmarkColor: Theme.of(context).primaryColor,
                      labelStyle: TextStyle(
                        color:
                            isSelected
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${_filteredRestaurants.length} ${_filteredRestaurants.length == 1 ? 'result' : 'results'} found',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            Expanded(
              child:
                  _filteredRestaurants.isEmpty
                      ? Center(
                        child: Text(
                          'No restaurants found. Try a different search.',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).textTheme.bodyLarge?.color?.withOpacity(0.7),
                          ),
                        ),
                      )
                      : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _filteredRestaurants.length,
                        itemBuilder: (context, index) {
                          final restaurant = _filteredRestaurants[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: RestaurantCard(
                              restaurant: restaurant,
                              onTap: (restaurant) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => RestaurantScreen(
                                          restaurantId: restaurant.id,
                                        ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
