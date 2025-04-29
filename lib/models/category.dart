class Category {
  final String id;
  final String name;
  final String icon;
  final String image;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.image,
  });

  Category copyWith({String? id, String? name, String? icon, String? image}) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'icon': icon, 'image': image};
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      image: json['image'],
    );
  }
}
