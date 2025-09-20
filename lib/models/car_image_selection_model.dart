import 'package:car_wash_app/models/selection_object.dart';
import 'package:flutter/cupertino.dart';

class CarImagesSelectionModel{
  String id = '';
  String localPath = '';
  SelectionObject imageType = SelectionObject();
  TextEditingController description = TextEditingController();
  String imageUrl = '';

  Map<String, dynamic> toJson() {
    return {
      'attachmentId': int.tryParse(id) ?? '',
      'description': description.text.trim(),
      'type': imageType.value,
    };
  }
}