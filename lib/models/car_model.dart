import 'package:car_wash_app/utils/api_endpoint.dart';

class CarsModel {
  String id = '';
  String year = '';
  String mileage = '';
  String makeName = '';
  String makeSlug = '';
  String modelName = '';
  String modelSlug = '';
  String variant = '';
  String color = '';
  String cityName = '';
  String citySlug = '';
  String conditionType = '';
  String listingPrice = '';
  String publishedOn = '';
  String viewCount = '';
  String mainImageUrl = '';
  String bodyType = '';
  String transmission = '';
  String fuelType = '';
  String engineSize = '';
  String noOfSeats = '';
  bool isFeatured = false;

  CarsModel();

  /// From JSON
  CarsModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    year = json['year']?.toString() ?? '';
    mileage = json['mileage']?.toString() ?? '';
    makeName = json['makeName']?.toString() ?? '';
    makeSlug = json['makeSlug']?.toString() ?? '';
    modelName = json['modelName']?.toString() ?? '';
    modelSlug = json['modelSlug']?.toString() ?? '';
    variant = json['variant']?.toString() ?? '';
    color = json['color']?.toString() ?? '';
    cityName = json['cityName']?.toString() ?? '';
    citySlug = json['citySlug']?.toString() ?? '';
    conditionType = json['conditionType']?.toString() ?? '';
    listingPrice = json['listingPrice']?.toString() ?? '';
    publishedOn = json['publishedOn']?.toString() ?? '';
    viewCount = json['viewCount']?.toString() ?? '';
    mainImageUrl = json['mainImageUrl']?.toString() ?? '';
    if(mainImageUrl.isNotEmpty){
      mainImageUrl = "${ApiEndpoint.imageBaseUrl}$mainImageUrl";
    }
    bodyType = json['bodyType']?.toString() ?? '';
    transmission = json['transmission']?.toString() ?? '';
    fuelType = json['fuelType']?.toString() ?? '';
    engineSize = json['engineSize']?.toString() ?? '';
    noOfSeats = json['noOfSeats']?.toString() ?? '';
    if (json['isFeatured'] is bool) {
      isFeatured = json['isFeatured'];
    }
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'year': year,
      'mileage': mileage,
      'makeName': makeName,
      'makeSlug': makeSlug,
      'modelName': modelName,
      'modelSlug': modelSlug,
      'variant': variant,
      'color': color,
      'cityName': cityName,
      'citySlug': citySlug,
      'conditionType': conditionType,
      'listingPrice': listingPrice,
      'isFeatured': isFeatured,
      'publishedOn': publishedOn,
      'viewCount': viewCount,
      'mainImageUrl': mainImageUrl,
      'bodyType': bodyType,
      'transmission': transmission,
      'fuelType': fuelType,
      'engineSize': engineSize,
      'noOfSeats': noOfSeats,
    };
  }

  /// CopyWith
  CarsModel copyWith({
    String? id,
    String? year,
    String? mileage,
    String? makeName,
    String? makeSlug,
    String? modelName,
    String? modelSlug,
    String? variant,
    String? color,
    String? cityName,
    String? citySlug,
    String? conditionType,
    String? listingPrice,
    String? publishedOn,
    String? viewCount,
    String? mainImageUrl,
    String? bodyType,
    String? transmission,
    String? fuelType,
    String? engineSize,
    String? noOfSeats,
    bool? isFeatured,
  }) {
    return CarsModel()
      ..id = id ?? this.id
      ..year = year ?? this.year
      ..mileage = mileage ?? this.mileage
      ..makeName = makeName ?? this.makeName
      ..makeSlug = makeSlug ?? this.makeSlug
      ..modelName = modelName ?? this.modelName
      ..modelSlug = modelSlug ?? this.modelSlug
      ..variant = variant ?? this.variant
      ..color = color ?? this.color
      ..cityName = cityName ?? this.cityName
      ..citySlug = citySlug ?? this.citySlug
      ..conditionType = conditionType ?? this.conditionType
      ..listingPrice = listingPrice ?? this.listingPrice
      ..publishedOn = publishedOn ?? this.publishedOn
      ..viewCount = viewCount ?? this.viewCount
      ..mainImageUrl = mainImageUrl ?? this.mainImageUrl
      ..bodyType = bodyType ?? this.bodyType
      ..transmission = transmission ?? this.transmission
      ..fuelType = fuelType ?? this.fuelType
      ..engineSize = engineSize ?? this.engineSize
      ..noOfSeats = noOfSeats ?? this.noOfSeats
      ..isFeatured = isFeatured ?? this.isFeatured;
  }
}
