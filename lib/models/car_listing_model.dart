import '../utils/api_endpoint.dart';

class CarListingModel {
  String id = '';
  String year = '';
  String rejectedReason = '';
  String mileage = '';
  String modelId = '';
  String makeId = '';
  String engineSize = '';
  String transmission = '';
  String noOfSeats = '';
  String modelName = '';
  String makeName = '';
  String color = '';
  String cityId = '';
  String listingPrice = '';
  bool isFeatured = false;
  String status = '';
  String publishedOn = '';
  String createdAt = '';
  String updatedAt = '';
  String imageUrl = '';

  CarListingModel();

  /// Factory: safely parse from dynamic JSON shapes.
  CarListingModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    year = json['year']?.toString() ?? '';
    rejectedReason = json['rejectedReason']?.toString() ?? '';
    mileage = json['mileage']?.toString() ?? '';
    modelId = json['modelId']?.toString() ?? '';
    makeId = json['makeId']?.toString() ?? '';
    engineSize = json['engineSize']?.toString() ?? '';
    transmission = json['transmission']?.toString() ?? '';
    noOfSeats = json['noOfSeats']?.toString() ?? '';
    modelName = json['modelName']?.toString() ?? '';
    makeName = json['makeName']?.toString() ?? '';
    color = json['color']?.toString() ?? '';
    cityId = json['cityId']?.toString() ?? '';
    listingPrice = json['listingPrice']?.toString() ?? '';
    imageUrl = json['mainImageUrl']?.toString() ?? '';
    if(imageUrl.isNotEmpty){
      imageUrl = "${ApiEndpoint.imageBaseUrl}$imageUrl";
    }
    if (json['isFeatured'] is bool) {
      isFeatured = json['isFeatured'];
    }
    status = json['status']?.toString() ?? '';
    publishedOn = json['publishedOn']?.toString() ?? '';
    createdAt = json['createdAt']?.toString() ?? '';
    updatedAt = json['updatedAt']?.toString() ?? '';
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'year': year,
    'rejectedReason': rejectedReason,
    'mileage': mileage,
    'modelId': modelId,
    'makeId': makeId,
    'engineSize': engineSize,
    'transmission': transmission,
    'noOfSeats': noOfSeats,
    'modelName': modelName,
    'makeName': makeName,
    'color': color,
    'cityId': cityId,
    'listingPrice': listingPrice,
    'isFeatured': isFeatured,
    'status': status,
    'publishedOn': publishedOn,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarListingModel &&
          id == other.id &&
          year == other.year &&
          rejectedReason == other.rejectedReason &&
          mileage == other.mileage &&
          modelId == other.modelId &&
          makeId == other.makeId &&
          engineSize == other.engineSize &&
          transmission == other.transmission &&
          noOfSeats == other.noOfSeats &&
          modelName == other.modelName &&
          makeName == other.makeName &&
          color == other.color &&
          cityId == other.cityId &&
          listingPrice == other.listingPrice &&
          isFeatured == other.isFeatured &&
          status == other.status &&
          publishedOn == other.publishedOn &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hashAll([
    id,
    year,
    rejectedReason,
    mileage,
    modelId,
    makeId,
    engineSize,
    transmission,
    noOfSeats,
    modelName,
    makeName,
    color,
    cityId,
    listingPrice,
    isFeatured,
    status,
    publishedOn,
    createdAt,

    updatedAt,
  ]);

  CarListingModel copyWith({
    String? id,
    String? year,
    String? rejectedReason,
    String? mileage,
    String? modelId,
    String? makeId,
    String? engineSize,
    String? transmission,
    String? noOfSeats,
    String? modelName,
    String? makeName,
    String? color,
    String? cityId,
    String? listingPrice,
    bool? isFeatured,
    String? status,
    String? publishedOn,
    String? createdAt,
    String? updatedAt,
  }) {
    final copy = CarListingModel();
    copy.id = id ?? this.id;
    copy.year = year ?? this.year;
    copy.rejectedReason = rejectedReason ?? this.rejectedReason;
    copy.mileage = mileage ?? this.mileage;
    copy.modelId = modelId ?? this.modelId;
    copy.makeId = makeId ?? this.makeId;
    copy.engineSize = engineSize ?? this.engineSize;
    copy.transmission = transmission ?? this.transmission;
    copy.noOfSeats = noOfSeats ?? this.noOfSeats;
    copy.modelName = modelName ?? this.modelName;
    copy.makeName = makeName ?? this.makeName;
    copy.color = color ?? this.color;
    copy.cityId = cityId ?? this.cityId;
    copy.listingPrice = listingPrice ?? this.listingPrice;
    copy.isFeatured = isFeatured ?? this.isFeatured;
    copy.status = status ?? this.status;
    copy.publishedOn = publishedOn ?? this.publishedOn;
    copy.createdAt = createdAt ?? this.createdAt;
    copy.updatedAt = updatedAt ?? this.updatedAt;
    return copy;
  }
}
