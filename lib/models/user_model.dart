class UserModel {
  String id = '';
  bool isActive = false;
  String mobile = '';
  String name = '';
  String email = '';
  String profilePictureUrl = '';
  List<String> roles = [];

  UserModel();

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] is String || json['id'] is num) {
      id = json['id'].toString();
    }
    if(json['isActive'] is bool){
      isActive = json['isActive'];
    }
    mobile = json['mobile']?.toString() ?? '';
    name = json['name']?.toString() ?? '';
    email = json['email']?.toString() ?? '';
    profilePictureUrl = json['profilePictureUrl']?.toString() ?? '';

    // Handle roles which could come as List<dynamic> or List<String>
    if (json['roles'] is List) {
      roles = json['roles'].map<String>((role) => role.toString()).toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "isActive": isActive,
      "mobile": mobile,
      "name": name,
      "email": email,
      "profilePictureUrl": profilePictureUrl,
      "roles": roles,
    };
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, mobile: $mobile, roles: $roles}';
  }
}