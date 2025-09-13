class OrderModel {
  String id = '';
  String timeslot = '';
  String timeslotLabel = '';
  String status = '';
  String serviceId = '';
  String serviceName = '';
  String price = '';
  String branchName = '';
  String streetAddress = '';
  String branchPhone = '';
  String businessName = '';
  String createdAt = '';
  String cancellationReason = '';

  OrderModel();

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    timeslot = json['timeslot']?.toString() ?? '';
    timeslotLabel = json['timeslotLabel']?.toString() ?? '';
    status = json['status']?.toString() ?? '';
    serviceId = json['serviceId']?.toString() ?? '';
    serviceName = json['serviceName']?.toString() ?? '';
    price = json['price']?.toString() ?? '';
    branchName = json['branchName']?.toString() ?? '';
    streetAddress = json['streetAddress']?.toString() ?? '';
    branchPhone = json['branchPhone']?.toString() ?? '';
    businessName = json['businessName']?.toString() ?? '';
    createdAt = json['createdAt']?.toString() ?? '';
    cancellationReason = json['cancellationReason']?.toString() ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timeslot': timeslot,
      'timeslotLabel': timeslotLabel,
      'status': status,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'price': price,
      'branchName': branchName,
      'streetAddress': streetAddress,
      'branchPhone': branchPhone,
      'businessName': businessName,
      'createdAt': createdAt,
      'cancellationReason': cancellationReason,
    };
  }
}
