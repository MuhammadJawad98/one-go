import 'package:car_wash_app/utils/api_endpoint.dart';

class CarDetailsModel {
  String id = '';
  String year = '';
  String mileage = '';
  String conditionType = '';
  String regionalSpecs = '';
  String engineSize = '';
  String optionLevel = '';
  String bodyType = '';
  String transmission = '';
  String driveType = '';
  String noOfSeats = '';
  String fuelType = '';
  String variant = '';
  String color = '';
  String cityName = '';
  String businessName = '';
  String contactPerson = '';
  String contactNumber = '';
  String cityLatitude = '';
  String cityLongitude = '';
  String makeName = '';
  String modelName = '';
  String listingPrice = '';
  String publishedOn = '';
  bool isFeatured = false;
  String featureExpiry = '';
  String adExpiry = '';
  String cylinders = '';
  String viewCount = '';

  CarDetailInfo details = CarDetailInfo();
  CarFeatures features = CarFeatures();
  List<CarDocument> documents = [];
  List<String> images = [];

  CarDetailsModel();

  /// From JSON
  CarDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    year = json['year']?.toString() ?? '';
    mileage = json['mileage']?.toString() ?? '';
    conditionType = json['conditionType']?.toString() ?? '';
    regionalSpecs = json['regionalSpecs']?.toString() ?? '';
    engineSize = json['engineSize']?.toString() ?? '';
    optionLevel = json['optionLevel']?.toString() ?? '';
    bodyType = json['bodyType']?.toString() ?? '';
    transmission = json['transmission']?.toString() ?? '';
    driveType = json['driveType']?.toString() ?? '';
    noOfSeats = json['noOfSeats']?.toString() ?? '';
    fuelType = json['fuelType']?.toString() ?? '';
    variant = json['variant']?.toString() ?? '';
    color = json['color']?.toString() ?? '';
    cityName = json['cityName']?.toString() ?? '';
    businessName = json['businessName']?.toString() ?? '';
    contactPerson = json['contactPerson']?.toString() ?? '';
    contactNumber = json['contactNumber']?.toString() ?? '';
    cityLatitude = json['cityLatitude']?.toString() ?? '';
    cityLongitude = json['cityLongitude']?.toString() ?? '';
    makeName = json['makeName']?.toString() ?? '';
    modelName = json['modelName']?.toString() ?? '';
    listingPrice = json['listingPrice']?.toString() ?? '';
    publishedOn = json['publishedOn']?.toString() ?? '';
    featureExpiry = json['featureExpiry']?.toString() ?? '';
    adExpiry = json['adExpiry']?.toString() ?? '';
    cylinders = json['cylinders']?.toString() ?? '';
    viewCount = json['viewCount']?.toString() ?? '';

    if (json['isFeatured'] is bool) {
      isFeatured = json['isFeatured'];
    }

    if(json['details'] is Map){
      details = CarDetailInfo.fromJson(json['details']);
    }

    if(json['details'] is Map){
      features = CarFeatures.fromJson(json['features']);
    }

    if (json['documents'] is List) {
      List list = json['documents'] as List;
      for (var element in list) {
        if(element is Map){
          documents.add(CarDocument.fromJson(element));
        }
      }

    }
    if(documents.isNotEmpty){
      for (var e in documents) {
        if(e.attachment!=null && e.attachment!.mimeType.contains("image")){
          images.add(e.attachment!.imageUrl);
        }
      }
    }
    if (json['make'] is Map) {
      makeName = json['make']['name']?.toString() ?? '';
    }
    if (json['model'] is Map) {
      modelName = json['model']['name']?.toString() ?? '';
    }
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'year': year,
      'mileage': mileage,
      'conditionType': conditionType,
      'regionalSpecs': regionalSpecs,
      'engineSize': engineSize,
      'optionLevel': optionLevel,
      'bodyType': bodyType,
      'transmission': transmission,
      'driveType': driveType,
      'noOfSeats': noOfSeats,
      'fuelType': fuelType,
      'variant': variant,
      'color': color,
      'cityName': cityName,
      'businessName': businessName,
      'contactPerson': contactPerson,
      'contactNumber': contactNumber,
      'cityLatitude': cityLatitude,
      'cityLongitude': cityLongitude,
      'makeName': makeName,
      'modelName': modelName,
      'listingPrice': listingPrice,
      'publishedOn': publishedOn,
      'isFeatured': isFeatured,
      'featureExpiry': featureExpiry,
      'adExpiry': adExpiry,
      'cylinders': cylinders,
      'viewCount': viewCount,
      'details': details.toJson(),
      'features': features.toJson(),
      'documents': documents.map((d) => d.toJson()).toList(),
    };
  }
}

/// Car details (nested object)
class CarDetailInfo {
  String id = '';
  String createdAt = '';
  String updatedAt = '';
  String deletedAt = '';
  String carId = '';
  String overallCondition = '';
  String isAccidented = '';
  String accidentDetail = '';
  String airBagsCondition = '';
  String chassisCondition = '';
  String engineCondition = '';
  String gearBoxCondition = '';
  bool alloyRims = false;
  String rimSize = '';
  String roofType = '';
  bool currentlyFinanced = false;
  bool firstOwner = false;
  String specialAboutCar = '';

  CarDetailInfo();

  CarDetailInfo.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    createdAt = json['createdAt']?.toString() ?? '';
    updatedAt = json['updatedAt']?.toString() ?? '';
    deletedAt = json['deletedAt']?.toString() ?? '';
    carId = json['carId']?.toString() ?? '';
    overallCondition = json['overallCondition']?.toString() ?? '';
    isAccidented = json['isAccidented']?.toString() ?? '';
    accidentDetail = json['accidentDetail']?.toString() ?? '';
    airBagsCondition = json['airBagsCondition']?.toString() ?? '';
    chassisCondition = json['chassisCondition']?.toString() ?? '';
    engineCondition = json['engineCondition']?.toString() ?? '';
    gearBoxCondition = json['gearBoxCondition']?.toString() ?? '';
    if(json['alloyRims'] is bool){
      alloyRims = json['alloyRims'];
    }
    rimSize = json['rimSize']?.toString() ?? '';
    roofType = json['roofType']?.toString() ?? '';
    currentlyFinanced = json['currentlyFinanced'] ?? false;
    firstOwner = json['firstOwner'] ?? false;
    specialAboutCar = json['specialAboutCar']?.toString() ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'carId': carId,
      'overallCondition': overallCondition,
      'isAccidented': isAccidented,
      'accidentDetail': accidentDetail,
      'airBagsCondition': airBagsCondition,
      'chassisCondition': chassisCondition,
      'engineCondition': engineCondition,
      'gearBoxCondition': gearBoxCondition,
      'alloyRims': alloyRims,
      'rimSize': rimSize,
      'roofType': roofType,
      'currentlyFinanced': currentlyFinanced,
      'firstOwner': firstOwner,
      'specialAboutCar': specialAboutCar,
    };
  }
}

/// Car features (nested object)
class CarFeatures {
  String id = '';
  String createdAt = '';
  String updatedAt = '';
  String deletedAt = '';
  String carId = '';

  bool blindSpotMonitor = false;
  bool laneKeepAssist = false;
  bool preCollisionSystem = false;
  bool ledHeadlights = false;
  bool fogLights = false;
  bool brakeAssist = false;
  bool bluetooth = false;
  bool carplay = false;
  bool rearEntertainment = false;
  bool premiumSound = false;
  bool headsUpDisplay = false;
  bool parkingSensors = false;
  bool cruiseControl = false;
  bool navigationSystem = false;
  bool reversingCamera = false;
  bool birdsEyeCamera = false;
  bool digitalDisplayMirror = false;
  bool automatedParking = false;
  bool adaptiveCruiseControl = false;
  bool digitalDisplay = false;
  bool steeringControls = false;
  bool paddleShifters = false;
  bool autoDimmingMirror = false;
  bool leatherSeats = false;
  bool pushButtonStart = false;
  bool remoteStart = false;
  bool ambientLighting = false;
  bool keylessEntry = false;
  bool powerSeats = false;
  bool memorySeats = false;
  bool powerFoldingMirrors = false;
  bool softCloseDoor = false;
  bool electricRunningBoard = false;
  bool handsFreeLifgate = false;
  bool massageSeats = false;
  bool heatedCooledSeats = false;
  bool lumbarSupport = false;
  bool newBrakePads = false;
  bool agencyMaintained = false;
  bool specialModifications = false;
  bool newBattery = false;
  bool newTyres = false;
  bool premiumAccessories = false;

  CarFeatures();

  CarFeatures.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    createdAt = json['createdAt']?.toString() ?? '';
    updatedAt = json['updatedAt']?.toString() ?? '';
    deletedAt = json['deletedAt']?.toString() ?? '';
    carId = json['carId']?.toString() ?? '';

    blindSpotMonitor = json['blindSpotMonitor'] ?? false;
    laneKeepAssist = json['laneKeepAssist'] ?? false;
    preCollisionSystem = json['preCollisionSystem'] ?? false;
    ledHeadlights = json['ledHeadlights'] ?? false;
    fogLights = json['fogLights'] ?? false;
    brakeAssist = json['brakeAssist'] ?? false;
    bluetooth = json['bluetooth'] ?? false;
    carplay = json['carplay'] ?? false;
    rearEntertainment = json['rearEntertainment'] ?? false;
    premiumSound = json['premiumSound'] ?? false;
    headsUpDisplay = json['headsUpDisplay'] ?? false;
    parkingSensors = json['parkingSensors'] ?? false;
    cruiseControl = json['cruiseControl'] ?? false;
    navigationSystem = json['navigationSystem'] ?? false;
    reversingCamera = json['reversingCamera'] ?? false;
    birdsEyeCamera = json['birdsEyeCamera'] ?? false;
    digitalDisplayMirror = json['digitalDisplayMirror'] ?? false;
    automatedParking = json['automatedParking'] ?? false;
    adaptiveCruiseControl = json['adaptiveCruiseControl'] ?? false;
    digitalDisplay = json['digitalDisplay'] ?? false;
    steeringControls = json['steeringControls'] ?? false;
    paddleShifters = json['paddleShifters'] ?? false;
    autoDimmingMirror = json['autoDimmingMirror'] ?? false;
    leatherSeats = json['leatherSeats'] ?? false;
    pushButtonStart = json['pushButtonStart'] ?? false;
    remoteStart = json['remoteStart'] ?? false;
    ambientLighting = json['ambientLighting'] ?? false;
    keylessEntry = json['keylessEntry'] ?? false;
    powerSeats = json['powerSeats'] ?? false;
    memorySeats = json['memorySeats'] ?? false;
    powerFoldingMirrors = json['powerFoldingMirrors'] ?? false;
    softCloseDoor = json['softCloseDoor'] ?? false;
    electricRunningBoard = json['electricRunningBoard'] ?? false;
    handsFreeLifgate = json['handsFreeLifgate'] ?? false;
    massageSeats = json['massageSeats'] ?? false;
    heatedCooledSeats = json['heatedCooledSeats'] ?? false;
    lumbarSupport = json['lumbarSupport'] ?? false;
    newBrakePads = json['newBrakePads'] ?? false;
    agencyMaintained = json['agencyMaintained'] ?? false;
    specialModifications = json['specialModifications'] ?? false;
    newBattery = json['newBattery'] ?? false;
    newTyres = json['newTyres'] ?? false;
    premiumAccessories = json['premiumAccessories'] ?? false;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'carId': carId,
      'blindSpotMonitor': blindSpotMonitor,
      'laneKeepAssist': laneKeepAssist,
      'preCollisionSystem': preCollisionSystem,
      'ledHeadlights': ledHeadlights,
      'fogLights': fogLights,
      'brakeAssist': brakeAssist,
      'bluetooth': bluetooth,
      'carplay': carplay,
      'rearEntertainment': rearEntertainment,
      'premiumSound': premiumSound,
      'headsUpDisplay': headsUpDisplay,
      'parkingSensors': parkingSensors,
      'cruiseControl': cruiseControl,
      'navigationSystem': navigationSystem,
      'reversingCamera': reversingCamera,
      'birdsEyeCamera': birdsEyeCamera,
      'digitalDisplayMirror': digitalDisplayMirror,
      'automatedParking': automatedParking,
      'adaptiveCruiseControl': adaptiveCruiseControl,
      'digitalDisplay': digitalDisplay,
      'steeringControls': steeringControls,
      'paddleShifters': paddleShifters,
      'autoDimmingMirror': autoDimmingMirror,
      'leatherSeats': leatherSeats,
      'pushButtonStart': pushButtonStart,
      'remoteStart': remoteStart,
      'ambientLighting': ambientLighting,
      'keylessEntry': keylessEntry,
      'powerSeats': powerSeats,
      'memorySeats': memorySeats,
      'powerFoldingMirrors': powerFoldingMirrors,
      'softCloseDoor': softCloseDoor,
      'electricRunningBoard': electricRunningBoard,
      'handsFreeLifgate': handsFreeLifgate,
      'massageSeats': massageSeats,
      'heatedCooledSeats': heatedCooledSeats,
      'lumbarSupport': lumbarSupport,
      'newBrakePads': newBrakePads,
      'agencyMaintained': agencyMaintained,
      'specialModifications': specialModifications,
      'newBattery': newBattery,
      'newTyres': newTyres,
      'premiumAccessories': premiumAccessories,
    };
  }
}

/// Car documents (list)
class CarDocument {
  String type = '';
  String description = '';
  CarAttachment? attachment;

  CarDocument();

  CarDocument.fromJson(Map<dynamic, dynamic> json) {
    type = json['type']?.toString() ?? '';
    description = json['description']?.toString() ?? '';
    attachment = json['attachment'] != null
        ? CarAttachment.fromJson(json['attachment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'description': description,
      'attachment': attachment?.toJson(),
    };
  }
}

class CarAttachment {
  String attachmentType = '';
  String imageUrl = '';
  String rank = '';
  String mimeType = '';

  CarAttachment();

  CarAttachment.fromJson(Map<String, dynamic> json) {
    attachmentType = json['attachmentType']?.toString() ?? '';
    imageUrl = json['imageUrl']?.toString() ?? '';
    if(imageUrl.isNotEmpty){
      imageUrl = ApiEndpoint.imageBaseUrl + imageUrl;
    }
    rank = json['rank']?.toString() ?? '';
    mimeType = json['mimeType']?.toString() ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'attachmentType': attachmentType,
      'imageUrl': imageUrl,
      'rank': rank,
      'mimeType': mimeType,
    };
  }
}
