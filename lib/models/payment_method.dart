enum PaymentType { card, cash, wallet }

class PaymentMethod {
  final String id;
  final PaymentType type;
  final String title;
  final String? lastFour;
  final bool isDefault;

  PaymentMethod({
    required this.id,
    required this.type,
    required this.title,
    this.lastFour,
    required this.isDefault,
  });

  PaymentMethod copyWith({
    String? id,
    PaymentType? type,
    String? title,
    String? lastFour,
    bool? isDefault,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      lastFour: lastFour ?? this.lastFour,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString().split('.').last,
      'title': title,
      'lastFour': lastFour,
      'isDefault': isDefault,
    };
  }

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'],
      type: PaymentType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => PaymentType.card,
      ),
      title: json['title'],
      lastFour: json['lastFour'],
      isDefault: json['isDefault'],
    );
  }
}
