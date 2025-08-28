import '../utils/api_endpoint.dart';

class ServiceDetailModel {
  String id = '';
  String name = '';
  OperatingHours operatingHours = OperatingHours();
  String categoryName = '';
  String cityName = '';
  String categorySlug = '';
  String description = '';
  String price = '';
  List<String> tags = [];
  String businessName = '';
  String contactPerson = '';
  String contactNumber = '';
  String branchPhone = '';
  String branchEmail = '';
  String branchName = '';
  String branchStreetAddress = '';
  String branchLatitude = '';
  String branchLongitude = '';
  String mainImageUrl = '';
  bool isFeatured = false;
  String createdAt = '';

  ServiceDetailModel();

  ServiceDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    name = json['name']?.toString() ?? '';
    if (json['operatingHours'] is Map) {
      operatingHours = OperatingHours.fromJson(json['operatingHours']);
    }
    categoryName = json['categoryName']?.toString() ?? '';
    cityName = json['cityName']?.toString() ?? '';
    categorySlug = json['categorySlug']?.toString() ?? '';
    description = json['description']?.toString() ?? '';
    price = json['price']?.toString() ?? '';
    if (json['tags'] is List) {
      tags = List<String>.from(json['tags']);
    }
    businessName = json['businessName']?.toString() ?? '';
    contactPerson = json['contactPerson']?.toString() ?? '';
    contactNumber = json['contactNumber']?.toString() ?? '';
    branchPhone = json['branchPhone']?.toString() ?? '';
    branchEmail = json['branchEmail']?.toString() ?? '';
    branchName = json['branchName']?.toString() ?? '';
    branchStreetAddress = json['branchStreetAddress']?.toString() ?? '';
    branchLatitude = json['branchLatitude']?.toString() ?? '';
    branchLongitude = json['branchLongitude']?.toString() ?? '';
    mainImageUrl = json['mainImageUrl']?.toString() ?? '';
    if(mainImageUrl.isNotEmpty){
      mainImageUrl = "${ApiEndpoint.imageBaseUrl}$mainImageUrl";
    }
    if (json['isFeatured'] is bool) {
      isFeatured = json['isFeatured'];
    }
    createdAt = json['createdAt']?.toString() ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'operatingHours': operatingHours.toJson(),
      'categoryName': categoryName,
      'cityName': cityName,
      'categorySlug': categorySlug,
      'description': description,
      'price': price,
      'tags': tags,
      'businessName': businessName,
      'contactPerson': contactPerson,
      'contactNumber': contactNumber,
      'branchPhone': branchPhone,
      'branchEmail': branchEmail,
      'branchName': branchName,
      'branchStreetAddress': branchStreetAddress,
      'branchLatitude': branchLatitude,
      'branchLongitude': branchLongitude,
      'mainImageUrl': mainImageUrl,
      'isFeatured': isFeatured,
      'createdAt': createdAt,
    };
  }
}

class OperatingHours {
  DayHours monday = DayHours();
  DayHours tuesday = DayHours();
  DayHours wednesday = DayHours();
  DayHours thursday = DayHours();
  DayHours friday = DayHours();
  DayHours saturday = DayHours();
  DayHours sunday = DayHours();

  OperatingHours();

  OperatingHours.fromJson(Map<String, dynamic> json) {
    if (json['monday'] is Map) {
      monday = DayHours.fromJson(json['monday']);
    }
    if (json['tuesday'] is Map) {
      tuesday = DayHours.fromJson(json['tuesday']);
    }
    if (json['wednesday'] is Map) {
      wednesday = DayHours.fromJson(json['wednesday']);
    }
    if (json['thursday'] is Map) {
      thursday = DayHours.fromJson(json['thursday']);
    }
    if (json['friday'] is Map) {
      friday = DayHours.fromJson(json['friday']);
    }
    if (json['saturday'] is Map) {
      saturday = DayHours.fromJson(json['saturday']);
    }
    if (json['sunday'] is Map) {
      sunday = DayHours.fromJson(json['sunday']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'monday': monday.toJson(),
      'tuesday': tuesday.toJson(),
      'wednesday': wednesday.toJson(),
      'thursday': thursday.toJson(),
      'friday': friday.toJson(),
      'saturday': saturday.toJson(),
      'sunday': sunday.toJson(),
    };
  }
}

class DayHours {
  String open = '';
  String close = '';

  DayHours();

  DayHours.fromJson(Map<String, dynamic> json) {
    open = json['open']?.toString() ?? '';
    close = json['close']?.toString() ?? '';
  }

  Map<String, dynamic> toJson() {
    return {'open': open, 'close': close};
  }
}
