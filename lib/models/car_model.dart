class CarsModel {
  String id = '';
  String title = '';
  String image = '';
  double price = 0;
  bool isFavorite = false;
  bool isFeatured = false;
  int quantity = 0;
  String? selectedSize;
  String? selectedColor;
  DateTime? addedToCartAt;
  List<String>? availableSizes;
  List<String>? availableColors;
  String? description;
  double? discount;
  String? category;
  double? averageRating;
  int? reviewCount;
  String? brand;

  CarsModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    this.isFavorite = false,
    this.isFeatured = false,
    this.quantity = 1,
    this.selectedSize,
    this.selectedColor,
    this.addedToCartAt,
    this.availableSizes,
    this.availableColors,
    this.description,
    this.discount,
    this.category,
    this.averageRating,
    this.reviewCount,
    this.brand,
  });

  // CopyWith method for creating modified copies
  CarsModel copyWith({
    String? id,
    String? title,
    String? image,
    double? price,
    bool? isFavorite,
    int? quantity,
    String? selectedSize,
    String? selectedColor,
    DateTime? addedToCartAt,
    List<String>? availableSizes,
    List<String>? availableColors,
    String? description,
    double? discount,
    String? category,
    double? averageRating,
    int? reviewCount,
    String? brand,
  }) {
    return CarsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      price: price ?? this.price,
      isFavorite: isFavorite ?? this.isFavorite,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      addedToCartAt: addedToCartAt ?? this.addedToCartAt,
      availableSizes: availableSizes ?? this.availableSizes,
      availableColors: availableColors ?? this.availableColors,
      description: description ?? this.description,
      discount: discount ?? this.discount,
      category: category ?? this.category,
      averageRating: averageRating ?? this.averageRating,
      reviewCount: reviewCount ?? this.reviewCount,
      brand: brand ?? this.brand,
    );
  }

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
      'isFavorite': isFavorite,
      'quantity': quantity,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
      'addedToCartAt': addedToCartAt?.toIso8601String(),
      'availableSizes': availableSizes,
      'availableColors': availableColors,
      'description': description,
      'discount': discount,
      'category': category,
      'averageRating': averageRating,
      'reviewCount': reviewCount,
      'brand': brand,
    };
  }

  // JSON deserialization
  factory CarsModel.fromJson(Map<String, dynamic> json) {
    return CarsModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      isFavorite: json['isFavorite'] ?? false,
      quantity: json['quantity'] ?? 1,
      selectedSize: json['selectedSize'],
      selectedColor: json['selectedColor'],
      addedToCartAt: json['addedToCartAt'] != null
          ? DateTime.parse(json['addedToCartAt'])
          : null,
      availableSizes: json['availableSizes'] != null
          ? List<String>.from(json['availableSizes'])
          : null,
      availableColors: json['availableColors'] != null
          ? List<String>.from(json['availableColors'])
          : null,
      description: json['description'],
      discount: json['discount']?.toDouble(),
      category: json['category'],
      averageRating: json['averageRating']?.toDouble(),
      reviewCount: json['reviewCount'],
      brand: json['brand'],
    );
  }

  // Get discounted price
  double get discountedPrice {
    return discount != null ? price - (price * discount! / 100) : price;
  }

  // Check if product is on discount
  bool get hasDiscount => discount != null && discount! > 0;

  // Formatted price
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';

  // Formatted discounted price
  String get formattedDiscountedPrice => '\$${discountedPrice.toStringAsFixed(2)}';
}