class Attachment {
  String id = '';
  String createdAt = '';
  String updatedAt = '';
  String deletedAt = '';
  String attachmentType = '';
  String objectKey = '';
  String rank = '';
  String byteSize = '';
  String mimeType = '';
  String relativePath = '';

  Attachment();

  Attachment.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    createdAt = json['createdAt']?.toString() ?? '';
    updatedAt = json['updatedAt']?.toString() ?? '';
    deletedAt = json['deletedAt']?.toString() ?? '';
    attachmentType = json['attachmentType']?.toString() ?? '';
    objectKey = json['objectKey']?.toString() ?? '';
    rank = json['rank']?.toString() ?? '';
    byteSize = json['byteSize']?.toString() ?? '';
    mimeType = json['mimeType']?.toString() ?? '';
    relativePath = json['relativePath']?.toString() ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "deletedAt": deletedAt,
      "attachmentType": attachmentType,
      "objectKey": objectKey,
      "rank": rank,
      "byteSize": byteSize,
      "mimeType": mimeType,
      "relativePath": relativePath,
    };
  }

  /// CopyWith method
  Attachment copyWith({
    String? id,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? attachmentType,
    String? objectKey,
    String? rank,
    String? byteSize,
    String? mimeType,
    String? relativePath,
  }) {
    return Attachment()
      ..id = id ?? this.id
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..deletedAt = deletedAt ?? this.deletedAt
      ..attachmentType = attachmentType ?? this.attachmentType
      ..objectKey = objectKey ?? this.objectKey
      ..rank = rank ?? this.rank
      ..byteSize = byteSize ?? this.byteSize
      ..mimeType = mimeType ?? this.mimeType
      ..relativePath = relativePath ?? this.relativePath;
  }
}
