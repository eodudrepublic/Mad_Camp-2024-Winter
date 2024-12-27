class Restaurant {
  final String name;
  final String phone;
  final String openTime;
  final String closeTime;

  Restaurant({
    required this.name,
    required this.phone,
    required this.openTime,
    required this.closeTime,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['Name'] as String,
      phone: json['Phone'] as String,
      openTime: json['Open'] as String,
      closeTime: json['Close'] as String,
    );
  }
}
