class Restaurant {
  final String name;
  final String phone;
  final String openTime;
  final String closeTime;
  final String category;

  Restaurant({
    required this.name,
    required this.phone,
    required this.openTime,
    required this.closeTime,
    required this.category,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['Name'] as String,
      phone: json['Phone'] as String,
      openTime: json['Open'] as String,
      closeTime: json['Close'] as String,
      category: json['Category'] as String,
    );
  }
}
