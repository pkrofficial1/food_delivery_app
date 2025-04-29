class Address {
  final String id;
  final String title;
  final String address;
  final bool isDefault;

  Address({
    required this.id,
    required this.title,
    required this.address,
    required this.isDefault,
  });

  Address copyWith({
    String? id,
    String? title,
    String? address,
    bool? isDefault,
  }) {
    return Address(
      id: id ?? this.id,
      title: title ?? this.title,
      address: address ?? this.address,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'address': address,
      'isDefault': isDefault,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      title: json['title'],
      address: json['address'],
      isDefault: json['isDefault'],
    );
  }
}
