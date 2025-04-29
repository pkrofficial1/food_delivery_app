class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String restaurantId;
  final String categoryId;
  final bool popular;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.restaurantId,
    required this.categoryId,
    this.popular = false,
  });

  MenuItem copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? image,
    String? restaurantId,
    String? categoryId,
    bool? popular,
  }) {
    return MenuItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      restaurantId: restaurantId ?? this.restaurantId,
      categoryId: categoryId ?? this.categoryId,
      popular: popular ?? this.popular,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'restaurantId': restaurantId,
      'categoryId': categoryId,
      'popular': popular,
    };
  }

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      image: json['image'],
      restaurantId: json['restaurantId'],
      categoryId: json['categoryId'],
      popular: json['popular'] ?? false,
    );
  }
}
