class Restaurant {
  final String id;
  final String name;
  final String image;
  final double rating;
  final String deliveryTime;
  final String deliveryFee;
  final List<String> categories;
  final bool featured;

  Restaurant({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.categories,
    this.featured = false,
  });

  Restaurant copyWith({
    String? id,
    String? name,
    String? image,
    double? rating,
    String? deliveryTime,
    String? deliveryFee,
    List<String>? categories,
    bool? featured,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      categories: categories ?? this.categories,
      featured: featured ?? this.featured,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'rating': rating,
      'deliveryTime': deliveryTime,
      'deliveryFee': deliveryFee,
      'categories': categories,
      'featured': featured,
    };
  }

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      rating: json['rating'].toDouble(),
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
      categories: List<String>.from(json['categories']),
      featured: json['featured'] ?? false,
    );
  }
}
