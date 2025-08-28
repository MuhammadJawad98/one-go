import '../utils/api_endpoint.dart';

class ServiceModel {
  String id = '';
  String name = '';
  String price = '';
  String categoryName = '';
  String categorySlug = '';
  String categoryPath = '';
  String mainImageUrl = '';
  bool isFeatured = false;
  String cityName = '';
  String citySlug = '';

  ServiceModel();

  ServiceModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] is String || json['id'] is num) {
      id = json['id'].toString();
    }
    name = json['name']?.toString() ?? '';
    price = json['price']?.toString() ?? '';
    categoryName = json['categoryName']?.toString() ?? '';
    categorySlug = json['categorySlug']?.toString() ?? '';
    categoryPath = json['categoryPath']?.toString() ?? '';
    if(json['mainImageUrl'] is String){
      mainImageUrl = json['mainImageUrl']?.toString() ?? '';
      if(mainImageUrl.isNotEmpty){
        mainImageUrl = "${ApiEndpoint.imageBaseUrl}$mainImageUrl";
      }
    }
    if (json['isFeatured'] is bool) {
      isFeatured = json['isFeatured'];
    }
    cityName = json['cityName']?.toString() ?? '';
    citySlug = json['citySlug']?.toString() ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "categoryName": categoryName,
      "categorySlug": categorySlug,
      "categoryPath": categoryPath,
      "mainImageUrl": mainImageUrl,
      "isFeatured": isFeatured,
      "cityName": cityName,
      "citySlug": citySlug,
    };
  }

  @override
  String toString() {
    return 'ServiceModel{id: $id, name: $name, price: $price, categoryName: $categoryName, city: $cityName}';
  }
}
