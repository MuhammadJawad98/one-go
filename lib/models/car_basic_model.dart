import 'package:car_wash_app/utils/api_endpoint.dart';

class CarBasicModel {
  String id = '';
  String year = '';
  String mileage = '';
  String makeId = '';
  String modelId = '';
  String variant = '';
  String color = '';
  String cityId = '';
  String conditionType = '';
  String listingPrice = '';
  String bodyType = '';
  String transmission = '';
  String fuelType = '';
  String engineSize = '';
  String noOfSeats = '';
  String driveType = '';
  String cylinders = '';
  String regionalSpecs = '';
  String optionLevel = '';
  String status = '';
  String createdAt = '';
  String updatedAt = '';
  String mainImageUrl = '';
  bool isFeatured = false;

  // step 2
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
  String extraCreatedAt = '';
  String extraUpdatedAt = '';

  ///step 3
  List<CarDocument> documentsList = [];
  CarModel? model;
  Make? make;
  CarFeatures carFeatures = CarFeatures();

  CarBasicModel();

  /// From JSON
  CarBasicModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    year = json['year']?.toString() ?? '';
    mileage = json['mileage']?.toString() ?? '';
    makeId = json['makeId']?.toString() ?? '';
    modelId = json['modelId']?.toString() ?? '';
    variant = json['variant']?.toString() ?? '';
    color = json['color']?.toString() ?? '';
    cityId = json['cityId']?.toString() ?? '';
    conditionType = json['conditionType']?.toString() ?? '';
    listingPrice = json['listingPrice']?.toString() ?? '';
    bodyType = json['bodyType']?.toString() ?? '';
    transmission = json['transmission']?.toString() ?? '';
    fuelType = json['fuelType']?.toString() ?? '';
    engineSize = json['engineSize']?.toString() ?? '';
    noOfSeats = json['noOfSeats']?.toString() ?? '';
    driveType = json['driveType']?.toString() ?? '';
    cylinders = json['cylinders']?.toString() ?? '';
    regionalSpecs = json['regionalSpecs']?.toString() ?? '';
    optionLevel = json['optionLevel']?.toString() ?? '';
    status = json['status']?.toString() ?? '';
    createdAt = json['createdAt']?.toString() ?? '';
    updatedAt = json['updatedAt']?.toString() ?? '';
    if (json['isFeatured'] is bool) {
      isFeatured = json['isFeatured'];
    }

    mainImageUrl = json['mainImageUrl']?.toString() ?? '';
    if (mainImageUrl.isNotEmpty) {
      mainImageUrl = "${ApiEndpoint.imageBaseUrl}$mainImageUrl";
    }
    if (json['model'] is Map) {
      model = CarModel.fromJson(json['model']);
    }
    if (json['make'] is Map) {
      make = Make.fromJson(json['make']);
    }
    if (json['features'] is Map) {
      carFeatures = CarFeatures.fromJson(json['features']);
    }
    if (json['documents'] is List) {
      var list = json['documents'] as List;
      for (var e in list) {
        documentsList.add(CarDocument.fromJson(e));
      }
    }
    if(json['details'] is Map){
      var data = json['details'];
      carId = data['carId']?.toString() ?? '';
      overallCondition = data['overallCondition']?.toString() ?? '';
      isAccidented = data['isAccidented']?.toString() ?? '';
      accidentDetail = data['accidentDetail']?.toString() ?? '';
      airBagsCondition = data['airBagsCondition']?.toString() ?? '';
      chassisCondition = data['chassisCondition']?.toString() ?? '';
      engineCondition = data['engineCondition']?.toString() ?? '';
      gearBoxCondition = data['gearBoxCondition']?.toString() ?? '';
      alloyRims = data['alloyRims'] is bool ? data['alloyRims'] : false;
      rimSize = data['rimSize']?.toString() ?? '';
      roofType = data['roofType']?.toString() ?? '';
      currentlyFinanced = data['currentlyFinanced'] is bool
          ? data['currentlyFinanced']
          : false;
      firstOwner = data['firstOwner'] is bool ? data['firstOwner'] : false;
      specialAboutCar = data['specialAboutCar']?.toString() ?? '';
      extraCreatedAt = data['createdAt']?.toString() ?? '';
      extraUpdatedAt = data['updatedAt']?.toString() ?? '';
    }
  }

  CarBasicModel.parseDetails(Map<String, dynamic> json) {
    // These fields are not in your original model, so we add them here
    carId = json['carId']?.toString() ?? '';
    overallCondition = json['overallCondition']?.toString() ?? '';
    isAccidented = json['isAccidented']?.toString() ?? '';
    accidentDetail = json['accidentDetail']?.toString() ?? '';
    airBagsCondition = json['airBagsCondition']?.toString() ?? '';
    chassisCondition = json['chassisCondition']?.toString() ?? '';
    engineCondition = json['engineCondition']?.toString() ?? '';
    gearBoxCondition = json['gearBoxCondition']?.toString() ?? '';
    alloyRims = json['alloyRims'] is bool ? json['alloyRims'] : false;
    rimSize = json['rimSize']?.toString() ?? '';
    roofType = json['roofType']?.toString() ?? '';
    currentlyFinanced = json['currentlyFinanced'] is bool
        ? json['currentlyFinanced']
        : false;
    firstOwner = json['firstOwner'] is bool ? json['firstOwner'] : false;
    specialAboutCar = json['specialAboutCar']?.toString() ?? '';
    extraCreatedAt = json['createdAt']?.toString() ?? '';
    extraUpdatedAt = json['updatedAt']?.toString() ?? '';
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'year': year,
      'mileage': mileage,
      'makeId': makeId,
      'modelId': modelId,
      'variant': variant,
      'color': color,
      'cityId': cityId,
      'conditionType': conditionType,
      'listingPrice': listingPrice,
      'bodyType': bodyType,
      'transmission': transmission,
      'fuelType': fuelType,
      'engineSize': engineSize,
      'noOfSeats': noOfSeats,
      'driveType': driveType,
      'cylinders': cylinders,
      'regionalSpecs': regionalSpecs,
      'optionLevel': optionLevel,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isFeatured': isFeatured,
      'mainImageUrl': mainImageUrl,

      // New
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
      'documentsList': documentsList.map((e) => e.toJson()).toList(),
      'model': model?.toJson(),
      'make': make?.toJson(),
      'features': carFeatures.toJson(),
    };
  }

  /// CopyWith
  CarBasicModel copyWith({
    String? id,
    String? year,
    String? mileage,
    String? makeId,
    String? modelId,
    String? variant,
    String? color,
    String? cityId,
    String? conditionType,
    String? listingPrice,
    String? bodyType,
    String? transmission,
    String? fuelType,
    String? engineSize,
    String? noOfSeats,
    String? driveType,
    String? cylinders,
    String? regionalSpecs,
    String? optionLevel,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? mainImageUrl,
    bool? isFeatured,
  }) {
    return CarBasicModel()
      ..id = id ?? this.id
      ..year = year ?? this.year
      ..mileage = mileage ?? this.mileage
      ..makeId = makeId ?? this.makeId
      ..modelId = modelId ?? this.modelId
      ..variant = variant ?? this.variant
      ..color = color ?? this.color
      ..cityId = cityId ?? this.cityId
      ..conditionType = conditionType ?? this.conditionType
      ..listingPrice = listingPrice ?? this.listingPrice
      ..bodyType = bodyType ?? this.bodyType
      ..transmission = transmission ?? this.transmission
      ..fuelType = fuelType ?? this.fuelType
      ..engineSize = engineSize ?? this.engineSize
      ..noOfSeats = noOfSeats ?? this.noOfSeats
      ..driveType = driveType ?? this.driveType
      ..cylinders = cylinders ?? this.cylinders
      ..regionalSpecs = regionalSpecs ?? this.regionalSpecs
      ..optionLevel = optionLevel ?? this.optionLevel
      ..status = status ?? this.status
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..mainImageUrl = mainImageUrl ?? this.mainImageUrl
      ..isFeatured = isFeatured ?? this.isFeatured;
  }
}

class CarDocument {
  String id = '';
  String createdAt = '';
  String updatedAt = '';
  String deletedAt = '';
  String type = '';
  String attachmentId = '';
  String carId = '';
  String description = '';
  CarAttachment? attachment;

  CarDocument();

  CarDocument.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    createdAt = json['createdAt']?.toString() ?? '';
    updatedAt = json['updatedAt']?.toString() ?? '';
    deletedAt = json['deletedAt']?.toString() ?? '';
    type = json['type']?.toString() ?? '';
    attachmentId = json['attachmentId']?.toString() ?? '';
    carId = json['carId']?.toString() ?? '';
    description = json['description']?.toString() ?? '';
    if (json['attachment'] is Map) {
      attachment = CarAttachment.fromJson(json['attachment']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'type': type,
      'attachmentId': attachmentId,
      'carId': carId,
      'description': description,
      'attachment': attachment?.toJson(),
    };
  }
}

class CarAttachment {
  String id = '';
  String createdAt = '';
  String updatedAt = '';
  String deletedAt = '';
  String attachmentType = '';
  String objectKey = '';
  String rank = '';
  String byteSize = '';
  String mimeType = '';

  CarAttachment();

  CarAttachment.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    createdAt = json['createdAt']?.toString() ?? '';
    updatedAt = json['updatedAt']?.toString() ?? '';
    deletedAt = json['deletedAt']?.toString() ?? '';
    attachmentType = json['attachmentType']?.toString() ?? '';
    objectKey = json['objectKey']?.toString() ?? '';
    rank = json['rank']?.toString() ?? '';
    byteSize = json['byteSize']?.toString() ?? '';
    mimeType = json['mimeType']?.toString() ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'attachmentType': attachmentType,
      'objectKey': objectKey,
      'rank': rank,
      'byteSize': byteSize,
      'mimeType': mimeType,
    };
  }
}

class CarModel {
  String id = '';
  String createdAt = '';
  String updatedAt = '';
  String deletedAt = '';
  String name = '';
  String slug = '';
  String makeId = '';

  CarModel();

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    createdAt = json['createdAt']?.toString() ?? '';
    updatedAt = json['updatedAt']?.toString() ?? '';
    deletedAt = json['deletedAt']?.toString() ?? '';
    name = json['name']?.toString() ?? '';
    slug = json['slug']?.toString() ?? '';
    makeId = json['makeId']?.toString() ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "deletedAt": deletedAt,
      "name": name,
      "slug": slug,
      "makeId": makeId,
    };
  }
}

class Make {
  String id = '';
  String createdAt = '';
  String updatedAt = '';
  String deletedAt = '';
  String name = '';
  String slug = '';

  Make();

  Make.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    createdAt = json['createdAt']?.toString() ?? '';
    updatedAt = json['updatedAt']?.toString() ?? '';
    deletedAt = json['deletedAt']?.toString() ?? '';
    name = json['name']?.toString() ?? '';
    slug = json['slug']?.toString() ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "deletedAt": deletedAt,
      "name": name,
      "slug": slug,
    };
  }
}

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
    if (json['blindSpotMonitor'] is bool) {
      blindSpotMonitor = json['blindSpotMonitor'];
    }
    if (json['laneKeepAssist'] is bool) {
      laneKeepAssist = json['laneKeepAssist'];
    }
    if (json['preCollisionSystem'] is bool) {
      preCollisionSystem = json['preCollisionSystem'];
    }
    if (json['ledHeadlights'] is bool) {
      ledHeadlights = json['ledHeadlights'];
    }
    if (json['fogLights'] is bool) {
      fogLights = json['fogLights'];
    }
    if (json['brakeAssist'] is bool) {
      brakeAssist = json['brakeAssist'];
    }
    if (json['bluetooth'] is bool) {
      bluetooth = json['bluetooth'];
    }
    if (json['carplay'] is bool) {
      carplay = json['carplay'];
    }
    if (json['rearEntertainment'] is bool) {
      rearEntertainment = json['rearEntertainment'];
    }
    if (json['premiumSound'] is bool) {
      premiumSound = json['premiumSound'];
    }
    if (json['headsUpDisplay'] is bool) {
      headsUpDisplay = json['headsUpDisplay'];
    }
    if (json['parkingSensors'] is bool) {
      parkingSensors = json['parkingSensors'];
    }
    if (json['cruiseControl'] is bool) {
      cruiseControl = json['cruiseControl'];
    }
    if (json['navigationSystem'] is bool) {
      navigationSystem = json['navigationSystem'];
    }
    if (json['reversingCamera'] is bool) {
      reversingCamera = json['reversingCamera'];
    }
    if (json['birdsEyeCamera'] is bool) {
      birdsEyeCamera = json['birdsEyeCamera'];
    }
    if (json['digitalDisplayMirror'] is bool) {
      digitalDisplayMirror = json['digitalDisplayMirror'];
    }
    if (json['automatedParking'] is bool) {
      automatedParking = json['automatedParking'];
    }
    if (json['adaptiveCruiseControl'] is bool) {
      adaptiveCruiseControl = json['adaptiveCruiseControl'];
    }
    if (json['digitalDisplay'] is bool) {
      digitalDisplay = json['digitalDisplay'];
    }
    if (json['steeringControls'] is bool) {
      steeringControls = json['steeringControls'];
    }
    if (json['paddleShifters'] is bool) {
      paddleShifters = json['paddleShifters'];
    }
    if (json['autoDimmingMirror'] is bool) {
      autoDimmingMirror = json['autoDimmingMirror'];
    }
    if (json['leatherSeats'] is bool) {
      leatherSeats = json['leatherSeats'];
    }
    if (json['pushButtonStart'] is bool) {
      pushButtonStart = json['pushButtonStart'];
    }
    if (json['remoteStart'] is bool) {
      remoteStart = json['remoteStart'];
    }
    if (json['ambientLighting'] is bool) {
      ambientLighting = json['ambientLighting'];
    }
    if (json['keylessEntry'] is bool) {
      keylessEntry = json['keylessEntry'];
    }
    if (json['powerSeats'] is bool) {
      powerSeats = json['powerSeats'];
    }
    if (json['memorySeats'] is bool) {
      memorySeats = json['memorySeats'];
    }
    if (json['powerFoldingMirrors'] is bool) {
      powerFoldingMirrors = json['powerFoldingMirrors'];
    }
    if (json['softCloseDoor'] is bool) {
      softCloseDoor = json['softCloseDoor'];
    }
    if (json['electricRunningBoard'] is bool) {
      electricRunningBoard = json['electricRunningBoard'];
    }
    if (json['handsFreeLifgate'] is bool) {
      handsFreeLifgate = json['handsFreeLifgate'];
    }
    if (json['massageSeats'] is bool) {
      massageSeats = json['massageSeats'];
    }
    if (json['heatedCooledSeats'] is bool) {
      heatedCooledSeats = json['heatedCooledSeats'];
    }
    if (json['lumbarSupport'] is bool) {
      lumbarSupport = json['lumbarSupport'];
    }
    if (json['newBrakePads'] is bool) {
      newBrakePads = json['newBrakePads'];
    }
    if (json['agencyMaintained'] is bool) {
      agencyMaintained = json['agencyMaintained'];
    }
    if (json['specialModifications'] is bool) {
      specialModifications = json['specialModifications'];
    }
    if (json['newBattery'] is bool) {
      newBattery = json['newBattery'];
    }
    if (json['newTyres'] is bool) {
      newTyres = json['newTyres'];
    }
    if (json['premiumAccessories'] is bool) {
      premiumAccessories = json['premiumAccessories'];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "deletedAt": deletedAt,
      "carId": carId,
      "blindSpotMonitor": blindSpotMonitor,
      "laneKeepAssist": laneKeepAssist,
      "preCollisionSystem": preCollisionSystem,
      "ledHeadlights": ledHeadlights,
      "fogLights": fogLights,
      "brakeAssist": brakeAssist,
      "bluetooth": bluetooth,
      "carplay": carplay,
      "rearEntertainment": rearEntertainment,
      "premiumSound": premiumSound,
      "headsUpDisplay": headsUpDisplay,
      "parkingSensors": parkingSensors,
      "cruiseControl": cruiseControl,
      "navigationSystem": navigationSystem,
      "reversingCamera": reversingCamera,
      "birdsEyeCamera": birdsEyeCamera,
      "digitalDisplayMirror": digitalDisplayMirror,
      "automatedParking": automatedParking,
      "adaptiveCruiseControl": adaptiveCruiseControl,
      "digitalDisplay": digitalDisplay,
      "steeringControls": steeringControls,
      "paddleShifters": paddleShifters,
      "autoDimmingMirror": autoDimmingMirror,
      "leatherSeats": leatherSeats,
      "pushButtonStart": pushButtonStart,
      "remoteStart": remoteStart,
      "ambientLighting": ambientLighting,
      "keylessEntry": keylessEntry,
      "powerSeats": powerSeats,
      "memorySeats": memorySeats,
      "powerFoldingMirrors": powerFoldingMirrors,
      "softCloseDoor": softCloseDoor,
      "electricRunningBoard": electricRunningBoard,
      "handsFreeLifgate": handsFreeLifgate,
      "massageSeats": massageSeats,
      "heatedCooledSeats": heatedCooledSeats,
      "lumbarSupport": lumbarSupport,
      "newBrakePads": newBrakePads,
      "agencyMaintained": agencyMaintained,
      "specialModifications": specialModifications,
      "newBattery": newBattery,
      "newTyres": newTyres,
      "premiumAccessories": premiumAccessories,
    };
  }
}
