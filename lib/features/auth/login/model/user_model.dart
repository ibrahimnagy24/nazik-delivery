import '../../../../network/mapper.dart';

class UserModel extends SingleMapper {
  int? id;
  String? token;
  String? balance;
  String? name;
  String? email;
  String? phone;
  String? countryCode;
  int? isActive;
  String? createdAt;
  int? roleId;
  String? roleName;
  List<String>? permissions;
  String? emailSignature;
  String? profilePhoto;

  UserModel(
      {this.id,
      this.token,
      this.balance,
      this.name,
      this.email,
      this.phone,
      this.countryCode,
      this.isActive,
      this.createdAt,
      this.roleId,
      this.roleName,
      this.permissions,
      this.emailSignature,
      this.profilePhoto});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    balance = json['balance']?.toString();
    countryCode = json['country_code'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    roleId = json['role_id'];
    roleName = json['role_name'];
    permissions = json['permissions'].cast<String>();
    emailSignature = json['email_signature'];
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['balance'] = balance;
    data['token'] = token;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['country_code'] = countryCode;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['role_id'] = roleId;
    data['role_name'] = roleName;
    data['permissions'] = permissions;
    data['email_signature'] = emailSignature;
    data['profile_photo'] = profilePhoto;
    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }
}
