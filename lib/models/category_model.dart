class Category {
  String id = '';
  String createdAt = '';
  String updatedAt = '';
  String deletedAt = '';
  String parentId = '';
  String name = '';
  String slug = '';
  String description = '';
  String iconUrl = '';
  String bannerUrl = '';
  String level = '';
  String path = '';
  bool isActive = false;
  bool isSelected = false;
  String metaTitle = '';
  String metaDescription = '';

  Category();

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    createdAt = json['createdAt']?.toString() ?? '';
    updatedAt = json['updatedAt']?.toString() ?? '';
    deletedAt = json['deletedAt']?.toString() ?? '';
    parentId = json['parentId']?.toString() ?? '';
    name = json['name']?.toString() ?? '';
    slug = json['slug']?.toString() ?? '';
    description = json['description']?.toString() ?? '';
    iconUrl = json['iconUrl']?.toString() ?? '';
    bannerUrl = json['bannerUrl']?.toString() ?? '';
    level = json['level']?.toString() ?? '';
    path = json['path']?.toString() ?? '';
    if (json['isActive'] is bool) {
      isActive = json['isActive'];
    }
    metaTitle = json['metaTitle']?.toString() ?? '';
    metaDescription = json['metaDescription']?.toString() ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'parentId': parentId,
      'name': name,
      'slug': slug,
      'description': description,
      'iconUrl': iconUrl,
      'bannerUrl': bannerUrl,
      'level': level,
      'path': path,
      'isActive': isActive,
      'metaTitle': metaTitle,
      'metaDescription': metaDescription,
    };
  }

  Category copyWith({
    String? id,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? parentId,
    String? name,
    String? slug,
    String? description,
    String? iconUrl,
    String? bannerUrl,
    String? level,
    String? path,
    bool? isActive,
    String? metaTitle,
    String? metaDescription,
  }) {
    return Category()
      ..id = id ?? this.id
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..deletedAt = deletedAt ?? this.deletedAt
      ..parentId = parentId ?? this.parentId
      ..name = name ?? this.name
      ..slug = slug ?? this.slug
      ..description = description ?? this.description
      ..iconUrl = iconUrl ?? this.iconUrl
      ..bannerUrl = bannerUrl ?? this.bannerUrl
      ..level = level ?? this.level
      ..path = path ?? this.path
      ..isActive = isActive ?? this.isActive
      ..metaTitle = metaTitle ?? this.metaTitle
      ..metaDescription = metaDescription ?? this.metaDescription;
  }
}
